package co.sena.cimm.adso.registraduria.model;

/**
 * Modelo que representa una Zona de Votacion.
 * Vinculado tecnicamente con la tabla Ciudades.
 * @author Salazar
 */
public class Zona {
    private int id;
    private String nombreZona;
    private String puestoVotacion;
    private String direccion;
    
    // Atributos para la vinculacion con Ciudades
    private Integer idCiudad;     // Llave foranea (FK)
    private String nombreCiudad;  // Atributo auxiliar para mostrar en la vista

    public Zona() {}

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombreZona() { return nombreZona; }
    public void setNombreZona(String nombreZona) { this.nombreZona = nombreZona; }

    public String getPuestoVotacion() { return puestoVotacion; }
    public void setPuestoVotacion(String puestoVotacion) { this.puestoVotacion = puestoVotacion; }

    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }

    public Integer getIdCiudad() { return idCiudad; }
    public void setIdCiudad(Integer idCiudad) { this.idCiudad = idCiudad; }

    public String getNombreCiudad() { return nombreCiudad; }
    public void setNombreCiudad(String nombreCiudad) { this.nombreCiudad = nombreCiudad; }
}