package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.config.ConexionDB;
import co.sena.cimm.adso.registraduria.model.Ciudad;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementacion del DAO para la gestion de Ciudades.
 * Proporciona los datos necesarios para los select de Zonas y Ciudadanos.
 * @author Salazar
 */
public class CiudadDAOImpl implements CiudadDAO {

    /**
     * Obtiene el listado completo de ciudades registradas.
     * Utilizado para cargar los dropdowns (select) en los formularios JSP.
     * @return Lista de objetos Ciudad ordenados alfabeticamente.
     */
    @Override
    public List<Ciudad> listarTodos() {
        List<Ciudad> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, departamento FROM ciudades ORDER BY nombre ASC";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ciudad c = new Ciudad();
                c.setId(rs.getInt("id"));
                c.setNombre(rs.getString("nombre"));
                c.setDepartamento(rs.getString("departamento"));
                lista.add(c);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar ciudades: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Busca una ciudad especifica por su llave primaria.
     * @param id Identificador de la ciudad.
     * @return Objeto Ciudad o null si no se encuentra.
     */
    @Override
    public Ciudad buscarPorId(int id) {
        String sql = "SELECT id, nombre, departamento FROM ciudades WHERE id = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Ciudad c = new Ciudad();
                    c.setId(rs.getInt("id"));
                    c.setNombre(rs.getString("nombre"));
                    c.setDepartamento(rs.getString("departamento"));
                    return c;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar ciudad por ID: " + e.getMessage());
        }
        return null;
    }
}