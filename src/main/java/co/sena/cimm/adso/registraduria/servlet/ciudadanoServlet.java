package co.sena.cimm.adso.registraduria.servlet;

import co.sena.cimm.adso.registraduria.dao.CiudadanoDAO;
import co.sena.cimm.adso.registraduria.dao.CiudadanoDAOImpl;
import co.sena.cimm.adso.registraduria.dao.MesaDAO;
import co.sena.cimm.adso.registraduria.dao.MesaDAOImpl;
import co.sena.cimm.adso.registraduria.model.Ciudadano;
import co.sena.cimm.adso.registraduria.model.mesa;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * Servlet para la gestión de Ciudadanos de la Registraduría de Nobsa.
 * Implementa el patrón POST/Redirect/GET y validación de integridad referencial.
 */
@WebServlet(name = "ciudadanoServlet", urlPatterns = {"/ciudadanos"})
public class ciudadanoServlet extends HttpServlet {

    private final CiudadanoDAO dao = new CiudadanoDAOImpl();
    private final MesaDAO mesaDao = new MesaDAOImpl(); 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        action = (action == null) ? "listar" : action;

        try {
            // Carga de mesas disponibles para los formularios de registro y edición
            List<mesa> listaMesas = mesaDao.listar();
            request.setAttribute("listaMesas", listaMesas);

            switch (action) {
                case "eliminar" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    
                    // Verificación de integridad referencial antes de eliminar [cite: 790, 804-813]
                    if (dao.tieneDocumentos(id)) {
                        request.getSession().setAttribute("error", 
                            "No se puede eliminar: El ciudadano tiene trámites de identidad registrados.");
                    } else {
                        dao.eliminar(id);
                        request.getSession().setAttribute("mensaje", "Ciudadano eliminado correctamente.");
                    }
                    // Aplicación de patrón Redirect para limpiar la URL y evitar reenvíos
                    response.sendRedirect(request.getContextPath() + "/ciudadanos");
                }
                
                default -> { 
                    // Listado general de ciudadanos con datos obtenidos mediante el DAO [cite: 582-586]
                    List<Ciudadano> lista = dao.listarTodos();
                    request.setAttribute("lista", lista);
                    
                    // Manejo de mensajes de error o éxito almacenados en la sesión
                    String error = (String) request.getSession().getAttribute("error");
                    if (error != null) {
                        request.setAttribute("error", error);
                        request.getSession().removeAttribute("error");
                    }
                    
                    String mensaje = (String) request.getSession().getAttribute("mensaje");
                    if (mensaje != null) {
                        request.setAttribute("mensaje", mensaje);
                        request.getSession().removeAttribute("mensaje");
                    }
                    
                    // Redirección a la vista JSP segura dentro de WEB-INF [cite: 657-660, 674]
                    request.getRequestDispatcher("/ciudadano.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error en CiudadanoServlet (operación GET)", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Configuración de codificación UTF-8 para procesar tildes y ñ 
        request.setCharacterEncoding("UTF-8");
        
        try {
            String action = request.getParameter("action");
            Ciudadano c = new Ciudadano();
            
            // 1. Captura de ID (Requerido solo para actualizaciones)
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                c.setId(Integer.parseInt(idStr.trim()));
            }

            // 2. Mapeo de información personal
            // Se permite enviar el número de documento vacío para que el DAO lo genere automáticamente
            String docParam = request.getParameter("numeroDocumento");
            c.setNumeroDocumento((docParam != null && !docParam.trim().isEmpty()) ? docParam.trim() : null);
            
            c.setNombres(request.getParameter("nombres"));
            c.setApellidos(request.getParameter("apellidos"));
            
            // 3. Procesamiento de fecha de nacimiento
            String fechaStr = request.getParameter("fechaNacimiento");
            if (fechaStr != null && !fechaStr.trim().isEmpty()) {
                c.setFechaNacimiento(LocalDate.parse(fechaStr));
            }

            c.setTelefono(request.getParameter("telefono"));
            c.setCorreo(request.getParameter("correo"));
            
            // 4. Captura de la Mesa de votación asignada (Puede ser null)
            String idMesaStr = request.getParameter("idMesa");
            if (idMesaStr != null && !idMesaStr.trim().isEmpty()) {
                c.setIdMesa(Integer.parseInt(idMesaStr));
            } else {
                c.setIdMesa(null);
            }
            
            // 5. Ejecución de la operación en el DAO
            if ("actualizar".equals(action)) {
                dao.actualizar(c);
                request.getSession().setAttribute("mensaje", "Datos actualizados correctamente.");
            } else {
                // El método insertar generará automáticamente el ID de Nobsa si el documento está vacío
                dao.insertar(c);
                request.getSession().setAttribute("mensaje", "Ciudadano registrado exitosamente.");
            }

            // Patrón POST/Redirect/GET obligatorio para evitar duplicados [cite: 789]
            response.sendRedirect(request.getContextPath() + "/ciudadanos");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Error al procesar la solicitud: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/ciudadanos");
        }
    }
}