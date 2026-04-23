package co.sena.cimm.adso.registraduria.dao;

import co.sena.cimm.adso.registraduria.model.Administrador;

public interface AdminDAO {
    // Método para validar el ingreso a la Registraduría
    Administrador validar(String usuario, String clave);
}