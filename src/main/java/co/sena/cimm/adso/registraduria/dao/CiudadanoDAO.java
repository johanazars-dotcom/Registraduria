package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.model.Ciudadano;
import java.util.List;

/**
 * Interfaz que define las operaciones CRUD para la gestion de Ciudadanos.
 * Vincula al ciudadano con su respectiva Zona de Votacion en Nobsa.
 * @author Salazar
 */
public interface CiudadanoDAO {
    
    /**
     * Registra un nuevo ciudadano en el censo electoral.
     * @param c Objeto con los datos del ciudadano e ID de zona.
     */
    void insertar(Ciudadano c) throws Exception;

    /**
     * Obtiene la lista completa de ciudadanos con el nombre de su puesto de votacion.
     * @return Lista de ciudadanos ordenados por apellidos.
     */
    List<Ciudadano> listarTodos() throws Exception;

    /**
     * Busca un ciudadano especifico mediante su numero de cedula.
     * @param numDoc Numero de documento unico.
     * @return Objeto Ciudadano o null si no existe.
     */
    Ciudadano buscarPorDocumento(String numDoc) throws Exception;

    /**
     * Actualiza la informacion personal o de votacion de un ciudadano.
     * @param c Objeto con los datos modificados.
     */
    void actualizar(Ciudadano c) throws Exception;

    /**
     * Elimina a un ciudadano del sistema por su ID primario.
     * @param id Identificador unico en la base de datos.
     */
    void eliminar(int id) throws Exception;

    /**
     * Verifica si el ciudadano tiene tramites vinculados antes de eliminar.
     * Garantiza la integridad referencial de la base de datos.
     * @param id Identificador del ciudadano.
     * @return true si tiene documentos asociados.
     */
    boolean tieneDocumentos(int id) throws Exception;
}