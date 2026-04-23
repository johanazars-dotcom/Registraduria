package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.model.DocumentoExpedido;
import java.util.List;

/**
 * Interfaz que define las operaciones CRUD para la gestion de Documentos Expedidos.
 * Permite administrar el historial de tramites de identidad de los ciudadanos de Nobsa.
 * @author Salazar
 */
public interface DocumentoExpedidoDAO {

    /**
     * Registra la expedicion de un nuevo documento (Cedula, TI, Registro Civil).
     * @param d Objeto con los datos del documento y el ID del ciudadano dueño.
     */
    void insertar(DocumentoExpedido d) throws Exception;

    /**
     * Obtiene todos los documentos registrados con la informacion del ciudadano vinculada (JOIN).
     * @return Lista de documentos expedidos ordenados por fecha de emision.
     */
    List<DocumentoExpedido> listarTodos() throws Exception;

    /**
     * Recupera un documento especifico por su identificador primario.
     * @param id Identificador unico del registro.
     * @return Objeto DocumentoExpedido con datos del ciudadano incluidos.
     */
    DocumentoExpedido buscarPorId(int id) throws Exception;

    /**
     * Modifica los datos de un documento existente.
     * @param d Objeto con la informacion actualizada.
     */
    void actualizar(DocumentoExpedido d) throws Exception;

    /**
     * Cambia el estado del documento (vigente, vencido o cancelado).
     * Requerimiento obligatorio del modulo de documentos.
     * @param id Identificador del documento.
     * @param nuevoEstado Texto con el nuevo estado.
     */
    void cambiarEstado(int id, String nuevoEstado) throws Exception;

    /**
     * Elimina el registro de un documento del sistema.
     * @param id Identificador unico del documento a borrar.
     */
    void eliminar(int id) throws Exception;

    /**
     * Valida la unicidad del numero de serie antes de insertar un nuevo tramite.
     * @param numeroSerie Cadena unica que identifica al documento fisico.
     * @return true si la serie ya existe en el sistema.
     */
    boolean existeSerie(String numeroSerie) throws Exception;
    
    /**
     * Lista todos los documentos pertenecientes a un ciudadano en particular.
     * @param idCiudadano ID del ciudadano a consultar.
     * @return Lista de documentos del ciudadano.
     */
    List<DocumentoExpedido> listarPorCiudadano(int idCiudadano) throws Exception;
}