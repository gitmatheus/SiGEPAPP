/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.PerguntaDAO;
import br.edu.fei.sigepapp.bancodedados.model.Pergunta;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Windows XP
 */
public class GetPerguntaServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml");
        PrintWriter out = response.getWriter();

        try {
            PerguntaDAO pergDAO = new PerguntaDAO();
           List<Pergunta> listPerguntas = pergDAO.APPP_SEL_PERGUNTA(new Pergunta());

            out.println("<xml>");

            for (Pergunta pergunta : listPerguntas) {
                out.println("<Pergunta>");
                out.println("<Cod>");
                out.println(pergunta.getCd_pergunta());
                out.println("</Cod>");
                out.println("<DescPergunta>");
                out.println(pergunta.getDs_pergunta());
                out.println("</DescPergunta>");
                out.println("</Pergunta>");
            }

            out.println("</xml>");

            out.flush();
            pergDAO.fechaConexao();

        } catch (SQLException ex) {
            Logger.getLogger(GetPerguntaServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {

            out.close();
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
