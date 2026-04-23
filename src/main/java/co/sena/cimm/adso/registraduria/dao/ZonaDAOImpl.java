package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.config.ConexionDB;
import co.sena.cimm.adso.registraduria.model.Zona;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementacion del DAO para la gestion de Zonas de Votacion vinculadas a Ciudades.
 * Cumple con las restricciones de PreparedStatement y Try-with-resources.
 * @author Salazar
 */
public class ZonaDAOImpl implements ZonaDAO {

    // 1. LISTAR TODAS LAS ZONAS CON JOIN A CIUDADES
    @Override
    public List<Zona> listar() {
        List<Zona> lista = new ArrayList<>();
        // El LEFT JOIN permite traer la zona incluso si no tiene ciudad asignada
        String sql = "SELECT z.*, c.nombre AS ciudad_nombre " +
                     "FROM zonas_votacion z " +
                     "LEFT JOIN ciudades c ON z.id_ciudad = c.id " +
                     "ORDER BY z.id ASC";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Zona z = new Zona();
                z.setId(rs.getInt("id"));
                z.setNombreZona(rs.getString("nombre_zona"));
                z.setPuestoVotacion(rs.getString("puesto_votacion"));
                z.setDireccion(rs.getString("direccion"));
                
                // Vinculacion tecnica: ID de la ciudad
                z.setIdCiudad(rs.getInt("id_ciudad")); 
                
                // Nombre de la ciudad obtenido del JOIN
                String nombreC = rs.getString("ciudad_nombre");
                z.setNombreCiudad(nombreC != null ? nombreC : "Sin asignar"); 
                
                lista.add(z);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar zonas con ciudades: " + e.getMessage());
        }
        return lista;
    }

    // 2. INSERTAR NUEVA ZONA VINCULADA A CIUDAD
    @Override
    public boolean insertar(Zona z) {
        String sql = "INSERT INTO zonas_votacion (nombre_zona, puesto_votacion, direccion, id_ciudad) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, z.getNombreZona());
            ps.setString(2, z.getPuestoVotacion());
            ps.setString(3, z.getDireccion());
            
            // Usamos setObject para manejar correctamente si el idCiudad es nulo
            if (z.getIdCiudad() != null && z.getIdCiudad() > 0) {
                ps.setInt(4, z.getIdCiudad());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al insertar zona: " + e.getMessage());
            return false;
        }
    }

    // 3. ACTUALIZAR ZONA Y SU VINCULO TERRITORIAL
    @Override
    public boolean actualizar(Zona z) {
        String sql = "UPDATE zonas_votacion SET nombre_zona = ?, puesto_votacion = ?, direccion = ?, id_ciudad = ? WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, z.getNombreZona());
            ps.setString(2, z.getPuestoVotacion());
            ps.setString(3, z.getDireccion());
            
            if (z.getIdCiudad() != null && z.getIdCiudad() > 0) {
                ps.setInt(4, z.getIdCiudad());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            ps.setInt(5, z.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar zona: " + e.getMessage());
            return false;
        }
    }

    // 4. ELIMINAR ZONA
    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM zonas_votacion WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar zona: " + e.getMessage());
            return false;
        }
    }

    // 5. BUSCAR POR ID CON DATOS DE CIUDAD
    @Override
    public Zona buscarPorId(int id) {
        String sql = "SELECT z.*, c.nombre AS ciudad_nombre " +
                     "FROM zonas_votacion z " +
                     "LEFT JOIN ciudades c ON z.id_ciudad = c.id " +
                     "WHERE z.id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Zona z = new Zona();
                    z.setId(rs.getInt("id"));
                    z.setNombreZona(rs.getString("nombre_zona"));
                    z.setPuestoVotacion(rs.getString("puesto_votacion"));
                    z.setDireccion(rs.getString("direccion"));
                    z.setIdCiudad(rs.getInt("id_ciudad"));
                    z.setNombreCiudad(rs.getString("ciudad_nombre"));
                    return z;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar zona: " + e.getMessage());
        }
        return null;
    }
}