package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.config.ConexionDB;
import co.sena.cimm.adso.registraduria.model.mesa;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementacion de las operaciones de base de datos para las mesas.
 * @author Salazar
 */
public class MesaDAOImpl implements MesaDAO {

    @Override
    public List<mesa> listar() {
        List<mesa> lista = new ArrayList<>();
        // JOIN para traer el nombre del puesto de votacion (zona)
        String sql = "SELECT m.*, z.puesto_votacion FROM mesas_votacion m " +
                     "JOIN zonas_votacion z ON m.id_zona = z.id ORDER BY m.numero_mesa ASC";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                mesa m = new mesa();
                m.setId(rs.getInt("id"));
                m.setNumero_mesa(rs.getInt("numero_mesa"));
                m.setCapacidad(rs.getInt("capacidad"));
                m.setUbicacion_detallada(rs.getString("ubicacion_detallada"));
                m.setId_zona(rs.getInt("id_zona"));
                m.setNombreZona(rs.getString("puesto_votacion")); // Traido del JOIN
                lista.add(m);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar mesas: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean insertar(mesa m) {
        String sql = "INSERT INTO mesas_votacion (numero_mesa, capacidad, ubicacion_detallada, id_zona) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, m.getNumero_mesa());
            ps.setInt(2, m.getCapacidad());
            ps.setString(3, m.getUbicacion_detallada());
            ps.setInt(4, m.getId_zona());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al insertar mesa: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean actualizar(mesa m) {
        String sql = "UPDATE mesas_votacion SET numero_mesa=?, capacidad=?, ubicacion_detallada=?, id_zona=? WHERE id=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, m.getNumero_mesa());
            ps.setInt(2, m.getCapacidad());
            ps.setString(3, m.getUbicacion_detallada());
            ps.setInt(4, m.getId_zona());
            ps.setInt(5, m.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar mesa: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM mesas_votacion WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar mesa: " + e.getMessage());
            return false;
        }
    }

    @Override
    public mesa buscarPorId(int id) {
        String sql = "SELECT * FROM mesas_votacion WHERE id = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new mesa(
                        rs.getInt("id"),
                        rs.getInt("numero_mesa"),
                        rs.getInt("capacidad"),
                        rs.getString("ubicacion_detallada"),
                        rs.getInt("id_zona")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar mesa: " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean tieneCiudadanos(int id) {
        String sql = "SELECT COUNT(*) FROM ciudadanos WHERE id_mesa = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}