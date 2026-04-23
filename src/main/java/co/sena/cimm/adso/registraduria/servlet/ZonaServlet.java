package co.sena.cimm.adso.registraduria.servlet;

import co.sena.cimm.adso.registraduria.dao.CiudadDAO;
import co.sena.cimm.adso.registraduria.dao.CiudadDAOImpl;
import co.sena.cimm.adso.registraduria.dao.ZonaDAO;
import co.sena.cimm.adso.registraduria.dao.ZonaDAOImpl;
import co.sena.cimm.adso.registraduria.model.Ciudad;
import co.sena.cimm.adso.registraduria.model.Zona;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet para la gestion de Zonas de Votacion - Registraduria de Nobsa.
 * Implementa la vinculacion con Ciudades y cumple el patron POST/Redirect/GET.
 * @author salazar
 */
@WebServlet(name = "ZonaServlet", urlPatterns = {"/zonas"})
public class ZonaServlet extends HttpServlet {

    private final ZonaDAO zonaDao = new ZonaDAOImpl();
    private final CiudadDAO ciudadDao = new CiudadDAOImpl(); // Necesario para llenar el select de ciudades

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        action = (action == null) ? "listar" : action;

        try {
            if ("eliminar".equals(action)) {
                // 1. ELIMINAR: Proceso de eliminacion por ID
                int id = Integer.parseInt(request.getParameter("id"));
                zonaDao.eliminar(id);
                // Redireccion inmediata (PRG)
                response.sendRedirect(request.getContextPath() + "/zonas?msj=eliminado");
            } else {
                // 2. LISTAR: Cargamos las Zonas para la tabla y las Ciudades para el Modal
                List<Zona> listaZonas = zonaDao.listar();
                List<Ciudad> listaCiudades = ciudadDao.listarTodos(); // Asegurate de tener este metodo
                
                request.setAttribute("lista", listaZonas);
                request.setAttribute("listaCiudades", listaCiudades); 
                
                request.getRequestDispatcher("/zona.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/zonas?error=true");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Soporte para caracteres especiales
        request.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        Zona z = new Zona();
        
        // Captura de ID para actualizaciones
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            z.setId(Integer.parseInt(idStr.trim()));
        }
        
        // Captura de datos basicos
        z.setNombreZona(request.getParameter("nombre_zona"));
        z.setPuestoVotacion(request.getParameter("puesto_votacion"));
        z.setDireccion(request.getParameter("direccion"));
        
        // Captura de la Ciudad vinculada (FK)
        String idCiudadStr = request.getParameter("id_ciudad");
        if (idCiudadStr != null && !idCiudadStr.isEmpty()) {
            z.setIdCiudad(Integer.parseInt(idCiudadStr));
        }

        try {
            if ("actualizar".equals(action)) {
                zonaDao.actualizar(z);
            } else {
                zonaDao.insertar(z);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redireccion final (PRG)
        response.sendRedirect(request.getContextPath() + "/zonas");
    }

    @Override
    public String getServletInfo() {
        return "Controlador de Zonas de Votacion - Nobsa";
    }
}