package co.sena.cimm.adso.registraduria.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Modelo que representa a un Ciudadano en el censo electoral.
 * Se incluye el atributo estado para validar la vigencia del documento via JOIN.
 * @author Salazar
 */
public class Ciudadano {
    private int id;
    private String numeroDocumento;
    private String nombres;
    private String apellidos;
    private LocalDate fechaNacimiento;
    private String telefono;
    private String correo;
    
    // Atributos de relacion (Normalizacion ADSO)
    private Integer idMesa;      // Llave foranea hacia mesas_votacion
    private Integer numeroMesa;  // Atributo auxiliar para la tabla JSP
    private String nombreZona;   // Atributo auxiliar para mostrar el Puesto (Zona)
    
    // Atributo dinamico para el estado de la cedula (traido desde documentos_expedidos)
    private String estado; 
    
    private LocalDateTime fechaRegistro;

    public Ciudadano() {}

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNumeroDocumento() { return numeroDocumento; }
    public void setNumeroDocumento(String numeroDocumento) { this.numeroDocumento = numeroDocumento; }

    public String getNombres() { return nombres; }
    public void setNombres(String nombres) { this.nombres = nombres; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public LocalDate getFechaNacimiento() { return fechaNacimiento; }
    public void setFechaNacimiento(LocalDate fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public Integer getIdMesa() { return idMesa; }
    public void setIdMesa(Integer idMesa) { this.idMesa = idMesa; }

    public Integer getNumeroMesa() { return numeroMesa; }
    public void setNumeroMesa(Integer numeroMesa) { this.numeroMesa = numeroMesa; }

    public String getNombreZona() { return nombreZona; }
    public void setNombreZona(String nombreZona) { this.nombreZona = nombreZona; }

    // METODOS PARA EL ESTADO DEL DOCUMENTO (JOIN)
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public LocalDateTime getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(LocalDateTime fechaRegistro) { this.fechaRegistro = fechaRegistro; }
}