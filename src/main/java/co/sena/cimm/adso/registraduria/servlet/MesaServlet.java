package co.sena.cimm.adso.registraduria.servlet;

import co.sena.cimm.adso.registraduria.dao.MesaDAO;
import co.sena.cimm.adso.registraduria.dao.MesaDAOImpl;
import co.sena.cimm.adso.registraduria.dao.ZonaDAO;
import co.sena.cimm.adso.registraduria.dao.ZonaDAOImpl;
import co.sena.cimm.adso.registraduria.model.mesa;
import co.sena.cimm.adso.registraduria.model.Zona;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Controlador para la gestion de mesas de votacion.
 * @author Salazar
 */
@WebServlet(name = "MesaServlet", urlPatterns = {"/mesas"})
public class MesaServlet extends HttpServlet {

    private final MesaDAO mesaDao = new MesaDAOImpl();
    private final ZonaDAO zonaDao = new ZonaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        action = (action == null) ? "listar" : action;

        try {
            // Siempre cargamos las zonas para que el modal de "Nueva Mesa" tenga opciones
            List<Zona> listaZonas = zonaDao.listar();
            request.setAttribute("listaZonas", listaZonas);

            switch (action) {
                case "eliminar" -> {
                    int id = Integer.parseInt(request.getParameter("id"));
                    if (mesaDao.tieneCiudadanos(id)) {
                        request.getSession().setAttribute("error", "No se puede eliminar: la mesa tiene ciudadanos inscritos.");
                    } else {
                        mesaDao.eliminar(id);
                    }
                    response.sendRedirect(request.getContextPath() + "/mesas");
                }
                default -> {
                    // Listado de mesas
                    List<mesa> listaMesas = mesaDao.listar();
                    request.setAttribute("listaMesas", listaMesas);
                    
                    // Capturar mensajes de error de la sesion si existen
                    String error = (String) request.getSession().getAttribute("error");
                    if (error != null) {
                        request.setAttribute("error", error);
                        request.getSession().removeAttribute("error");
                    }
                    
                    request.getRequestDispatcher("/mesa.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error en MesaServlet (GET)", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        try {
            mesa m = new mesa();
            
            // Mapeo de campos desde el formulario
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                m.setId(Integer.parseInt(idStr));
            }
            
            m.setNumero_mesa(Integer.parseInt(request.getParameter("numero_mesa")));
            m.setCapacidad(Integer.parseInt(request.getParameter("capacidad")));
            m.setUbicacion_detallada(request.getParameter("ubicacion_detallada"));
            m.setId_zona(Integer.parseInt(request.getParameter("id_zona")));

            if ("actualizar".equals(action)) {
                mesaDao.actualizar(m);
            } else {
                mesaDao.insertar(m);
            }

            response.sendRedirect(request.getContextPath() + "/mesas");
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error en MesaServlet (POST)", e);
        }
    }
}