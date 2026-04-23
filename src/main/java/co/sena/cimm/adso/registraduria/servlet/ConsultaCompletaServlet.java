package co.sena.cimm.adso.registraduria.servlet;

import co.sena.cimm.adso.registraduria.dao.CiudadanoDAO;
import co.sena.cimm.adso.registraduria.dao.CiudadanoDAOImpl;
import co.sena.cimm.adso.registraduria.model.Ciudadano;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet encargado de la consulta publica para el Votante.
 * Valida reCAPTCHA y verifica la vigencia del documento mediante el JOIN del DAO.
 * @author Salazar
 */
@WebServlet(name = "ConsultaCompletaServlet", urlPatterns = {"/consulta-completa"})
public class ConsultaCompletaServlet extends HttpServlet {

    private final CiudadanoDAO dao = new CiudadanoDAOImpl();

    // --- 1. VALIDACION DE SEGURIDAD RECAPTCHA ---
    private boolean validarCaptcha(String tokenGoogle) {
        if (tokenGoogle == null || tokenGoogle.trim().isEmpty()) {
            return false; 
        }

        try {
            String claveSecreta = "6Levgb4sAAAAAOrndKy3WBPK5jfK5LzkDqcQPrLC";
            URL url = new URL("https://www.google.com/recaptcha/api/siteverify");
            HttpURLConnection conexion = (HttpURLConnection) url.openConnection();
            
            conexion.setRequestMethod("POST");
            conexion.setDoOutput(true);
            
            String parametros = "secret=" + claveSecreta + "&response=" + tokenGoogle;
            conexion.getOutputStream().write(parametros.getBytes("UTF-8"));

            BufferedReader in = new BufferedReader(new InputStreamReader(conexion.getInputStream()));
            String inputLine;
            StringBuilder respuesta = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                respuesta.append(inputLine);
            }
            in.close();

            return respuesta.toString().contains("\"success\": true");

        } catch (Exception e) {
            System.err.println("Error validando CAPTCHA en Nobsa: " + e.getMessage());
            return false; 
        }
    }

    // --- 2. RECEPCION DEL FORMULARIO (POST) ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tokenRecaptcha = request.getParameter("g-recaptcha-response");
        String documento = request.getParameter("documento");
        
        // A. Validacion del Captcha
        if (!validarCaptcha(tokenRecaptcha)) {
            request.setAttribute("error", "Por favor, confirma que no eres un robot.");
            request.setAttribute("tipoError", "captcha");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return; 
        }

        if (documento == null || documento.trim().isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        try {
            // B. Buscar ciudadano (El DAO extrae el 'estado' desde documentos_expedidos via JOIN)
            Ciudadano c = dao.buscarPorDocumento(documento.trim());

            if (c != null) {
                // Obtenemos el estado mapeado en el modelo
                String estadoActual = c.getEstado(); 

                // C. Validacion de Vigencia para el proceso electoral
                if ("vigente".equalsIgnoreCase(estadoActual)) {
                    // EXITO: El ciudadano tiene su cedula al dia
                    request.setAttribute("c", c);
                    request.getRequestDispatcher("/perfil_ciudadano.jsp").forward(request, response);
                } else {
                    // ADVERTENCIA: El documento existe pero no es valido (vencido/cancelado)
                    request.setAttribute("error", "Su documento de identidad presenta una novedad: " + 
                                         (estadoActual != null ? estadoActual.toUpperCase() : "NO DISPONIBLE"));
                    request.setAttribute("tipoError", "documento-invalido");
                    request.setAttribute("estadoDetalle", estadoActual);
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                // ERROR: No se encuentra el numero en la base de datos
                request.setAttribute("error", "El número de documento " + documento + " no se encuentra registrado en el censo electoral.");
                request.setAttribute("tipoError", "no-encontrado");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error en el motor de consulta de Nobsa", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}