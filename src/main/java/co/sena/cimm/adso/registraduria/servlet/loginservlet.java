package co.sena.cimm.adso.registraduria.servlet;

import co.sena.cimm.adso.registraduria.dao.AdminDAO;
import co.sena.cimm.adso.registraduria.dao.AdminDAOImpl;
import co.sena.cimm.adso.registraduria.model.Administrador;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet para gestionar el acceso administrativo del sistema de la Registraduria de Nobsa.
 * @author salazar
 */
@WebServlet(name = "loginservlet", urlPatterns = {"/login"})
public class loginservlet extends HttpServlet {

    private final AdminDAO adminDao = new AdminDAOImpl();

    /**
     * Maneja el acceso via GET redirigiendo directamente al formulario de login.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    /**
     * Procesa la autenticacion del administrador validando contra la base de datos.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Configurar codificacion para soportar caracteres especiales
        request.setCharacterEncoding("UTF-8");
        
        // 1. Captura de datos del formulario login.jsp
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");

        try {
            // 2. Validacion mediante el DAO
            // El DAO ahora trae el campo 'nombre_completo' de la base de datos
            Administrador admin = adminDao.validar(usuario, clave);

            if (admin != null) {
                // 3. Credenciales correctas: Crear Sesion de Usuario
                HttpSession session = request.getSession();
                
                // Guardamos el nombre completo para que el navbar.jsp lo muestre
                session.setAttribute("admin", admin.getNombre());
                session.setAttribute("idAdmin", admin.getId());
                
                // Redirigir al panel de ciudadanos (CRUD)
                response.sendRedirect(request.getContextPath() + "/ciudadanos");
            } else {
                // 4. Credenciales incorrectas: Regresar al login con mensaje
                request.setAttribute("error", "Usuario o clave invalidos. Intente de nuevo.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            // Manejo de excepciones de conexion
            e.printStackTrace(); // Para ver el error en la consola
            request.setAttribute("error", "Error tecnico: No se pudo verificar el acceso.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Controlador de autenticacion administrativa - Registraduria Nobsa";
    }
}