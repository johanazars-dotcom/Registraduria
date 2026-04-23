package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.model.Zona;
import java.util.List;

/**
 * Interfaz que define las operaciones CRUD para la entidad Zona.
 * Implementa la vinculacion territorial tecnica con la tabla de Ciudades.
 * Sigue los estandares de persistencia para el proyecto Registraduria Nobsa.
 * @author Salazar
 */
public interface ZonaDAO {
    
    /**
     * Obtiene el listado completo de zonas de votacion.
     * Debe implementar un JOIN (preferiblemente LEFT JOIN) en la DB para 
     * recuperar el nombre de la ciudad asociada a cada zona.
     * @return Lista de objetos Zona con la informacion territorial cargada.
     */
    public List<Zona> listar();

    /**
     * Registra una nueva zona de votacion en el sistema.
     * Es obligatorio que el objeto Zona contenga un id_ciudad valido 
     * para mantener la integridad referencial.
     * @param z Objeto zona con nombre, puesto, direccion e id_ciudad.
     * @return true si el registro fue exitoso en PostgreSQL.
     */
    public boolean insertar(Zona z);

    /**
     * Actualiza los datos de una zona de votacion existente.
     * Permite modificar tanto la informacion fisica como la ciudad de pertenencia.
     * @param z Objeto zona con los datos actualizados e ID correspondiente.
     * @return true si la fila fue afectada correctamente.
     */
    public boolean actualizar(Zona z);

    /**
     * Elimina una zona de votacion de la base de datos por su ID.
     * Nota: La operacion puede verse restringida si la zona tiene mesas vinculadas.
     * @param id Identificador unico de la zona a eliminar.
     * @return true si la zona se elimino satisfactoriamente.
     */
    public boolean eliminar(int id);

    /**
     * Busca y recupera la informacion detallada de una zona por su ID.
     * Utilizado principalmente para cargar datos en los modales de edicion.
     * @param id Identificador unico de la zona buscada.
     * @return Objeto Zona con todos sus atributos o null si no existe.
     */
    public Zona buscarPorId(int id);
}