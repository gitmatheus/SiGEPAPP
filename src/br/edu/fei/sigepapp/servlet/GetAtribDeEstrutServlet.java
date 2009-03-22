/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.Atrib_EstruturaDAO;
import br.edu.fei.sigepapp.bancodedados.dao.AtributoDAO;
import br.edu.fei.sigepapp.bancodedados.model.Atrib_Estrutura;
import br.edu.fei.sigepapp.bancodedados.model.Atributo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lopespt
 */
public class GetAtribDeEstrutServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            AtributoDAO atributoDAO = new AtributoDAO();
            List<Atributo> rsAtributos;

            out.println("<xml>");

            rsAtributos = atributoDAO.APPP_PES_ATRIB_POR_ESTRUT(Long.parseLong(request.getParameter("codestr")));
            atributoDAO.fechaConexao();

            for (Atributo atributo : rsAtributos) {
                out.println("<atributo><nome>" + atributo.getNm_atributo_obj().trim() + "</nome><id>" + atributo.getCd_atributo_obj() + "</id></atributo>");
            }

            out.println("</xml>");

            out.flush();
            out.close();
        } catch (SQLException ex) {
            Logger.getLogger(GetAtribDeEstrutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
        }
    }

    // <editor-fold defaultstate="collapsed" desc="Métodos HttpServlet. Clique no sinal de + à esquerda para editar o código.">
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
