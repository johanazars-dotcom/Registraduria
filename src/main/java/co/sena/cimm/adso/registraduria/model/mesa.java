package co.sena.cimm.adso.registraduria.model;

/**
 * Modelo que representa una Mesa de Votacion.
 * @author Salazar
 */
public class mesa {
    private int id;
    private int numero_mesa;
    private int capacidad;
    private String ubicacion_detallada;
    private int id_zona;
    private String nombreZona; 

    // Constructor vacio (Obligatorio)
    public mesa() {}

    // Constructor con parametros (Obligatorio)
    public mesa(int id, int numero_mesa, int capacidad, String ubicacion_detallada, int id_zona) {
        this.id = id;
        this.numero_mesa = numero_mesa;
        this.capacidad = capacidad;
        this.ubicacion_detallada = ubicacion_detallada;
        this.id_zona = id_zona;
    }

    // Getters y Setters (Aqui es donde fallaba el compilador)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getNumero_mesa() { return numero_mesa; }
    public void setNumero_mesa(int numero_mesa) { this.numero_mesa = numero_mesa; }

    public int getCapacidad() { return capacidad; }
    public void setCapacidad(int capacidad) { this.capacidad = capacidad; }

    public String getUbicacion_detallada() { return ubicacion_detallada; }
    public void setUbicacion_detallada(String ubicacion_detallada) { this.ubicacion_detallada = ubicacion_detallada; }

    public int getId_zona() { return id_zona; }
    public void setId_zona(int id_zona) { this.id_zona = id_zona; }

    public String getNombreZona() { return nombreZona; }
    public void setNombreZona(String nombreZona) { this.nombreZona = nombreZona; }
}