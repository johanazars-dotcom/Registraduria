package co.sena.cimm.adso.registraduria.model;

/**
 * Modelo que representa una Ciudad o Municipio en el sistema.
 * Es la base de la jerarquia de ubicacion para zonas y ciudadanos.
 * @author Salazar
 */
public class Ciudad {
    
    private int id;
    private String nombre;
    private String departamento;

    // Constructor vacio obligatorio para el DAO
    public Ciudad() {}

    // Constructor con parametros (Opcional, util para pruebas)
    public Ciudad(int id, String nombre, String departamento) {
        this.id = id;
        this.nombre = nombre;
        this.departamento = departamento;
    }

    // --- Getters y Setters ---

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    /**
     * Sobrescribimos toString para facilitar la depuracion en consola.
     */
    @Override
    public String toString() {
        return "Ciudad{" + "id=" + id + ", nombre=" + nombre + ", departamento=" + departamento + '}';
    }
}