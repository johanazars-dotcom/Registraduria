package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.config.ConexionDB;
import co.sena.cimm.adso.registraduria.model.Administrador;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAOImpl implements AdminDAO {

    @Override
    public Administrador validar(String usuario, String clave) {
        Administrador admin = null;
        // Consulta SQL para buscar en la tabla administradores de Nobsa
        String sql = "SELECT * FROM administradores WHERE usuario = ? AND clave = ?";
        
        try (Connection con = ConexionDB.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, usuario);
            ps.setString(2, clave);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    admin = new Administrador();
                    // Mapeo de columnas de PostgreSQL a objeto Java
                    admin.setId(rs.getInt("id"));
                    admin.setUsuario(rs.getString("usuario"));
                    
                    /* CORRECCIÓN CRÍTICA: 
                       Se cambia "nombre" por "nombre_completo" para que coincida 
                       con la columna real de tu tabla en la base de datos.
                    */
                    admin.setNombre(rs.getString("nombre_completo"));
                }
            }
        } catch (Exception e) {
            // Imprime el error en la consola de NetBeans para seguimiento
            System.err.println("Error al validar administrador en Nobsa: " + e.getMessage());
        }
        return admin;
    }
}