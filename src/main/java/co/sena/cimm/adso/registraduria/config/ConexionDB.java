package co.sena.cimm.adso.registraduria.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 * Clase optimizada exclusivamente para PostgreSQL.
 * Gestiona la conexión a la base de datos de la Registraduría de Nobsa.
 */
public class ConexionDB {

    private static final Properties props = new Properties();

    // Carga la configuración al iniciar la clase
    static {
        try (InputStream in = ConexionDB.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in == null) {
                throw new RuntimeException("Error: db.properties no encontrado en resources.");
            }
            props.load(in);
            // Registramos el driver de PostgreSQL explícitamente
            Class.forName("org.postgresql.Driver");
        } catch (Exception e) {
            throw new RuntimeException("Error crítico al inicializar la conexión.", e);
        }
    }

    /**
     * Establece y retorna la conexión activa a PostgreSQL usando las propiedades.
     * @return Connection objeto de conexión.
     * @throws Exception Si ocurre un error de autenticación o red.
     */
    public static Connection obtenerConexion() throws Exception {
        String url = props.getProperty("postgresql.url"); 
        String user = props.getProperty("postgresql.user"); 
        String pass = props.getProperty("postgresql.password");

        if (url == null || user == null) {
            throw new RuntimeException("Faltan credenciales de PostgreSQL en db.properties.");
        }

        return DriverManager.getConnection(url, user, pass); 
    }

    /**
     * Metodo puente para compatibilidad con los DAOs.
     * Llama internamente a obtenerConexion() y maneja la excepcion.
     * @return Connection o null si falla.
     */
    public static Connection getConexion() {
        try {
            return obtenerConexion();
        } catch (Exception e) {
            System.err.println("Error critico en ConexionDB.getConexion(): " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}