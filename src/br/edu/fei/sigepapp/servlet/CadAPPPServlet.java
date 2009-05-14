package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.GenericDAO;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 13, 2009
 */
public class CadAPPPServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml; charset: ISO-8859-1");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        String[] valores = request.getParameterValues("valores");
        String[] atributos = request.getParameterValues("atributos");
        long cod_estrutura = Long.parseLong(request.getParameter("estrutura"));
        long cod_usuario = Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString());

        try {
            GenericDAO dao = new GenericDAO();
            int cResult = (int) dao.insertData(cod_estrutura, cod_usuario, valores, atributos);
            dao.fechaConexao();

            if (cResult != 1) {
                writer.println("<xml><sucesso>" + cResult + "</sucesso></xml>");
            } else {
                writer.println("<xml><sucesso>" + cResult + "</sucesso></xml>");
            }

        } catch (SQLException e) {
            GravarLog.gravaErro(CadPatternServlet.class.getName() + ": erro na operação da DAO: " + e.getSQLState() + " : " + e.getMessage());
            writer.println("<xml><sucesso>0</sucesso></xml>");
        } finally {
            writer.flush();
            writer.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
