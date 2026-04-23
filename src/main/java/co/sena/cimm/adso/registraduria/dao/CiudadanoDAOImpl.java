package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.config.ConexionDB;
import co.sena.cimm.adso.registraduria.model.Ciudadano;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementación del DAO para Ciudadanos de la Registraduría de Nobsa.
 * Incluye automatización de ID, validación de integridad y consultas con JOIN.
 * @author Salazar
 */
public class CiudadanoDAOImpl implements CiudadanoDAO {

    @Override
    public void insertar(Ciudadano c) throws Exception {
        // 1. GENERACIÓN AUTOMÁTICA DEL NÚMERO DE DOCUMENTO
        // Si el campo llega nulo o vacío desde el Servlet, se genera el ID regional
        if (c.getNumeroDocumento() == null || c.getNumeroDocumento().trim().isEmpty()) {
            // Código regional Nobsa (15491) + sufijo aleatorio de 5 dígitos
            String docAuto = "15491" + (int)(Math.random() * 90000 + 10000);
            c.setNumeroDocumento(docAuto);
        }

        String sql = "INSERT INTO ciudadanos (numero_documento, nombres, apellidos, fecha_nacimiento, telefono, correo, id_mesa) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNumeroDocumento());
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setObject(4, c.getFechaNacimiento());
            ps.setString(5, c.getTelefono());
            ps.setString(6, c.getCorreo());
            ps.setObject(7, c.getIdMesa()); 
            ps.executeUpdate();
        }
    }

    @Override
    public List<Ciudadano> listarTodos() throws Exception {
        List<Ciudadano> lista = new ArrayList<>();
        // Relación para la vista del Administrador: Ciudadano -> Mesa -> Zona
        String sql = "SELECT c.*, m.numero_mesa, z.puesto_votacion " +
                     "FROM ciudadanos c " +
                     "LEFT JOIN mesas_votacion m ON c.id_mesa = m.id " +
                     "LEFT JOIN zonas_votacion z ON m.id_zona = z.id " +
                     "ORDER BY c.apellidos ASC";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ciudadano c = mapear(rs);
                // Asignación de campos transitorios para la tabla JSP
                c.setNumeroMesa(rs.getInt("numero_mesa"));
                String puesto = rs.getString("puesto_votacion");
                c.setNombreZona(puesto != null ? puesto : "No asignado");
                lista.add(c);
            }
        }
        return lista;
    }

    @Override
    public Ciudadano buscarPorDocumento(String numDoc) throws Exception {
        // Consulta para el Votante: Integra el 'estado' desde documentos_expedidos vía JOIN
        String sql = "SELECT c.*, d.estado AS estado_doc, m.numero_mesa, z.puesto_votacion " +
                     "FROM ciudadanos c " +
                     "LEFT JOIN documentos_expedidos d ON c.id = d.id_ciudadano " +
                     "LEFT JOIN mesas_votacion m ON c.id_mesa = m.id " +
                     "LEFT JOIN zonas_votacion z ON m.id_zona = z.id " +
                     "WHERE c.numero_documento = ?";
                     
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, numDoc);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Ciudadano c = mapear(rs);
                    c.setNumeroMesa(rs.getInt("numero_mesa"));
                    c.setNombreZona(rs.getString("puesto_votacion"));
                    // Se llena el atributo estado del objeto con el valor del JOIN
                    c.setEstado(rs.getString("estado_doc")); 
                    return c;
                }
            }
        }
        return null;
    }

    @Override
    public void actualizar(Ciudadano c) throws Exception {
        String sql = "UPDATE ciudadanos SET nombres=?, apellidos=?, fecha_nacimiento=?, telefono=?, correo=?, id_mesa=? WHERE id=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getNombres());
            ps.setString(2, c.getApellidos());
            ps.setObject(3, c.getFechaNacimiento());
            ps.setString(4, c.getTelefono());
            ps.setString(5, c.getCorreo());
            ps.setObject(6, c.getIdMesa());
            ps.setInt(7, c.getId());
            ps.executeUpdate();
        }
    }

    @Override
    public void eliminar(int id) throws Exception {
        // VALIDACIÓN DE INTEGRIDAD: No permitir borrar si tiene documentos en el sistema
        if (tieneDocumentos(id)) {
            throw new Exception("No se puede eliminar: El ciudadano tiene trámites de identidad registrados.");
        }

        String sql = "DELETE FROM ciudadanos WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    @Override
    public boolean tieneDocumentos(int id) throws Exception {
        String sql = "SELECT COUNT(*) FROM documentos_expedidos WHERE id_ciudadano = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    /**
     * Mapea el ResultSet de la base de datos al objeto Java Ciudadano.
     */
    private Ciudadano mapear(ResultSet rs) throws SQLException {
        Ciudadano c = new Ciudadano();
        c.setId(rs.getInt("id"));
        c.setNumeroDocumento(rs.getString("numero_documento"));
        c.setNombres(rs.getString("nombres"));
        c.setApellidos(rs.getString("apellidos"));
        c.setFechaNacimiento(rs.getObject("fecha_nacimiento", java.time.LocalDate.class));
        c.setTelefono(rs.getString("telefono"));
        c.setCorreo(rs.getString("correo"));
        c.setIdMesa(rs.getObject("id_mesa", Integer.class));
        
        Timestamp ts = rs.getTimestamp("fecha_registro");
        if (ts != null) {
            c.setFechaRegistro(ts.toLocalDateTime());
        }
        return c;
    }
}