package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.model.Ciudad;
import java.util.List;

/**
 * Interfaz que define las operaciones para la gestion de Ciudades.
 * Permite centralizar la consulta de municipios para zonas y ciudadanos.
 * @author Salazar
 */
public interface CiudadDAO {

    /**
     * Recupera el listado completo de ciudades desde la base de datos.
     * @return Lista de objetos Ciudad.
     */
    public List<Ciudad> listarTodos();

    /**
     * Busca una ciudad especifica mediante su identificador unico.
     * @param id El ID de la ciudad a buscar.
     * @return El objeto Ciudad encontrado o null.
     */
    public Ciudad buscarPorId(int id);
    
}