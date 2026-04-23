package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.model.mesa;
import java.util.List;

/**
 * Interfaz que define las operaciones para la gestion de mesas de votacion.
 * @author Salazar
 */
public interface MesaDAO {
    
    /**
     * Obtiene la lista de todas las mesas incluyendo el nombre de su zona.
     * @return Lista de objetos mesa.
     */
    public List<mesa> listar();

    /**
     * Registra una nueva mesa vinculada a una zona especifica.
     * @param m Objeto mesa a insertar.
     * @return true si se registro con exito.
     */
    public boolean insertar(mesa m);

    /**
     * Actualiza la informacion de una mesa (capacidad, ubicacion o zona).
     * @param m Objeto mesa con datos editados.
     * @return true si se actualizo correctamente.
     */
    public boolean actualizar(mesa m);

    /**
     * Elimina una mesa por su ID.
     * @param id Identificador unico de la mesa.
     * @return true si se elimino exitosamente.
     */
    public boolean eliminar(int id);

    /**
     * Busca una mesa por su ID para procesos de edicion.
     * @param id ID de la mesa.
     * @return Objeto mesa encontrado o null.
     */
    public mesa buscarPorId(int id);
    
    /**
     * Verifica si la mesa tiene ciudadanos asignados antes de borrar.
     * @param id ID de la mesa.
     * @return true si hay ciudadanos en esta mesa.
     */
    public boolean tieneCiudadanos(int id);
}