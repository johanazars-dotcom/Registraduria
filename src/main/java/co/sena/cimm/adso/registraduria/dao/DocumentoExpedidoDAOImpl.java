package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.config.ConexionDB;
import co.sena.cimm.adso.registraduria.model.DocumentoExpedido;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementación de la persistencia para Documentos Expedidos con automatización de reglas.
 * @author Salazar
 */
public class DocumentoExpedidoDAOImpl implements DocumentoExpedidoDAO {

    @Override
    public void insertar(DocumentoExpedido d) throws Exception {
        // 1. Automatización de Fechas (Reglas Registraduría de Colombia)
        LocalDate expedicion = d.getFechaExpedicion();
        if (expedicion == null) expedicion = LocalDate.now();
        
        // La Cédula no vence (null). TI y Registro Civil según el taller [cite: 600, 631-638]
        if (d.getTipoDocumento().contains("Cédula")) {
            d.setFechaVencimiento(null); 
        } else if (d.getTipoDocumento().contains("Tarjeta")) {
            d.setFechaVencimiento(expedicion.plusYears(10)); 
        } else if (d.getTipoDocumento().contains("Contraseña")) {
            d.setFechaVencimiento(expedicion.plusMonths(6));
        }

        // 2. Generación automática de Número de Serie (Único)
        // Formato sugerido: SIGLA-AÑO-CONSECUTIVO (Ej: CC-2026-A1B2)
        String sigla = d.getTipoDocumento().substring(0, 2).toUpperCase();
        String serieAuto = sigla + "-" + expedicion.getYear() + "-" + 
                           Integer.toHexString((int)(Math.random() * 65535)).toUpperCase();
        d.setNumeroSerie(serieAuto);

        String sql = "INSERT INTO documentos_expedidos (id_ciudadano, tipo_documento, numero_serie, " +
                     "fecha_expedicion, fecha_vencimiento, estado, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, d.getIdCiudadano());
            ps.setString(2, d.getTipoDocumento());
            ps.setString(3, d.getNumeroSerie());
            ps.setObject(4, expedicion);
            ps.setObject(5, d.getFechaVencimiento());
            ps.setString(6, "vigente"); // Todo documento inicia vigente por defecto
            ps.setString(7, d.getObservaciones());
            
            ps.executeUpdate();
        }
    }

    @Override
    public List<DocumentoExpedido> listarTodos() throws Exception {
        List<DocumentoExpedido> lista = new ArrayList<>();
        // JOIN requerido para mostrar nombres y apellidos del ciudadano [cite: 791, 797]
        String sql = "SELECT d.*, c.nombres, c.apellidos, c.numero_documento " +
                     "FROM documentos_expedidos d " +
                     "INNER JOIN ciudadanos c ON d.id_ciudadano = c.id " +
                     "ORDER BY d.fecha_expedicion DESC";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(mapear(rs));
            }
        }
        return lista;
    }

    @Override
    public List<DocumentoExpedido> listarPorCiudadano(int idCiudadano) throws Exception {
        List<DocumentoExpedido> lista = new ArrayList<>();
        String sql = "SELECT d.*, c.nombres, c.apellidos, c.numero_documento " +
                     "FROM documentos_expedidos d " +
                     "INNER JOIN ciudadanos c ON d.id_ciudadano = c.id " +
                     "WHERE d.id_ciudadano = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCiudadano);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapear(rs));
                }
            }
        }
        return lista;
    }

    @Override
    public void cambiarEstado(int id, String nuevoEstado) throws Exception {
        // Funcionalidad obligatoria: vigente, vencido o cancelado [cite: 691]
        String sql = "UPDATE documentos_expedidos SET estado = ? WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

    @Override
    public DocumentoExpedido buscarPorId(int id) throws Exception {
        String sql = "SELECT d.*, c.nombres, c.apellidos, c.numero_documento " +
                     "FROM documentos_expedidos d " +
                     "INNER JOIN ciudadanos c ON d.id_ciudadano = c.id " +
                     "WHERE d.id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        }
        return null;
    }

    @Override
    public void actualizar(DocumentoExpedido d) throws Exception {
        String sql = "UPDATE documentos_expedidos SET tipo_documento=?, numero_serie=?, " +
                     "fecha_expedicion=?, fecha_vencimiento=?, estado=?, observaciones=? WHERE id=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, d.getTipoDocumento());
            ps.setString(2, d.getNumeroSerie());
            ps.setObject(3, d.getFechaExpedicion());
            ps.setObject(4, d.getFechaVencimiento());
            ps.setString(5, d.getEstado());
            ps.setString(6, d.getObservaciones());
            ps.setInt(7, d.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        String sql = "DELETE FROM documentos_expedidos WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public boolean existeSerie(String numeroSerie) throws Exception {
        String sql = "SELECT COUNT(*) FROM documentos_expedidos WHERE numero_serie = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, numeroSerie);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    private DocumentoExpedido mapear(ResultSet rs) throws SQLException {
        DocumentoExpedido d = new DocumentoExpedido();
        d.setId(rs.getInt("id"));
        d.setIdCiudadano(rs.getInt("id_ciudadano"));
        d.setTipoDocumento(rs.getString("tipo_documento"));
        d.setNumeroSerie(rs.getString("numero_serie"));
        d.setFechaExpedicion(rs.getObject("fecha_expedicion", LocalDate.class));
        d.setFechaVencimiento(rs.getObject("fecha_vencimiento", LocalDate.class));
        d.setEstado(rs.getString("estado"));
        d.setObservaciones(rs.getString("observaciones"));
        
        // Mapeo de campos transitorios del JOIN para la vista JSP [cite: 801]
        d.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
        d.setDocumentoCiudadano(rs.getString("numero_documento"));
        return d;
    }
}