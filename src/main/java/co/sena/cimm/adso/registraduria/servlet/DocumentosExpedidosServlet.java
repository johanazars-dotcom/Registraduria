package co.sena.cimm.adso.registraduria.servlet;

import co.sena.cimm.adso.registraduria.dao.CiudadanoDAO;
import co.sena.cimm.adso.registraduria.dao.CiudadanoDAOImpl;
import co.sena.cimm.adso.registraduria.dao.DocumentoExpedidoDAO;
import co.sena.cimm.adso.registraduria.dao.DocumentoExpedidoDAOImpl;
import co.sena.cimm.adso.registraduria.model.DocumentoExpedido;
import co.sena.cimm.adso.registraduria.model.Ciudadano;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controlador para la gestión de documentos expedidos en Nobsa.
 * Implementa automatización de serie y vencimiento delegada al DAO.
 */
@WebServlet(name = "DocumentosExpedidosServlet", urlPatterns = {"/documentos-expedidos"})
public class DocumentosExpedidosServlet extends HttpServlet {

    private final DocumentoExpedidoDAO docDao = new DocumentoExpedidoDAOImpl();
    private final CiudadanoDAO ciudadanoDao = new CiudadanoDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            if ("eliminar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                docDao.eliminar(id);
                response.sendRedirect("documentos-expedidos?msj=Documento eliminado correctamente");
                return;
            }

            // Listado con JOIN para mostrar nombre del ciudadano [cite: 582, 791]
            List<DocumentoExpedido> listaDocs = docDao.listarTodos();
            List<Ciudadano> listaCiu = ciudadanoDao.listarTodos();
            
            request.setAttribute("listaDocumentos", listaDocs);
            request.setAttribute("listaCiudadanos", listaCiu);
            
            request.getRequestDispatcher("/documentos_expedidos.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error cargando el modulo de documentos", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Codificación obligatoria para soportar tildes y ñ 
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        
        try {
            DocumentoExpedido d = new DocumentoExpedido();
            
            // 1. Captura de Ciudadano (Obligatorio)
            String idCiuStr = request.getParameter("idCiudadano");
            if (idCiuStr != null && !idCiuStr.isEmpty()) {
                d.setIdCiudadano(Integer.parseInt(idCiuStr));
            }
            
            d.setTipoDocumento(request.getParameter("tipoDocumento"));
            d.setObservaciones(request.getParameter("observaciones"));
            
            // 2. LÓGICA DE AUTOMATIZACIÓN PARA LA SERIE
            // Forzamos NULL si viene vacío para que el DAO genere la serie [cite: 600, 636]
            String serieParam = request.getParameter("numeroSerie");
            if (serieParam != null && !serieParam.trim().isEmpty()) {
                d.setNumeroSerie(serieParam.trim());
            } else {
                d.setNumeroSerie(null); 
            }

            // 3. Manejo de fecha de expedición
            String fExp = request.getParameter("fechaExpedicion");
            d.setFechaExpedicion((fExp != null && !fExp.isEmpty()) ? LocalDate.parse(fExp) : LocalDate.now());

            // 4. LÓGICA DE AUTOMATIZACIÓN PARA EL VENCIMIENTO
            // Forzamos NULL para que el DAO sume los años/meses legales 
            String fVenc = request.getParameter("fechaVencimiento");
            if (fVenc != null && !fVenc.trim().isEmpty()) {
                d.setFechaVencimiento(LocalDate.parse(fVenc));
            } else {
                d.setFechaVencimiento(null);
            }

            if ("insertar".equals(action)) {
                docDao.insertar(d);
            } else if ("actualizar".equals(action)) {
                d.setId(Integer.parseInt(request.getParameter("id")));
                d.setEstado(request.getParameter("estado"));
                docDao.actualizar(d);
            } else if ("cambiarEstado".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nuevoEstado = request.getParameter("nuevoEstado");
                docDao.cambiarEstado(id, nuevoEstado);
            }

            // Patrón POST/Redirect/GET exigido [cite: 589, 789]
            response.sendRedirect("documentos-expedidos?msj=Operacion realizada con exito");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("documentos-expedidos?error=Error al procesar: " + e.getMessage());
        }
    }
}