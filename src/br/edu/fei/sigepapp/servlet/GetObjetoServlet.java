/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.ObjetoDAO;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class GetObjetoServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
        out.println("<xml>");
        try {
            ObjetoDAO dao = new ObjetoDAO();
            Collection<Objeto> objetos = dao.pesquisaObjetoAtivos(new Objeto());
            dao.fechaConexao();
            for (Objeto obj : objetos) {
                out.println("<Objeto>");
                out.println("<Codigo_Objeto>" + obj.getCd_objeto() + "</Codigo_Objeto>");
                out.println("<Nome_Objeto>" + obj.getNm_objeto() + "</Nome_Objeto>");
                out.println("<Descricao_Objeto>" + obj.getDs_objeto() + "</Descricao_Objeto>");
                out.println("</Objeto>");
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(GetObjetoServlet.class.getName() + ": erro na pesquisa: " + e.getSQLState() + " : " + e.getMessage());
        } finally {
            out.println("</xml>");
            out.flush();
            out.close();
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
