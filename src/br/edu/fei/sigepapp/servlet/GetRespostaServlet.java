/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.RespostaDAO;
import br.edu.fei.sigepapp.bancodedados.model.Resposta;
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
 * @author Tom Mix
 * @version 0.01 Abr 18, 2009
 */
public class GetRespostaServlet extends HttpServlet {

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
            RespostaDAO respDAO = new RespostaDAO();
            List<Resposta> listRespostas = respDAO.APPP_SEL_RESPOSTA(new Resposta());
            respDAO.fechaConexao();
            out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
            out.println("<xml>");

            for (Resposta resposta : listRespostas) {
                out.println("<Resposta>");
                out.println("<Cod>");
                out.println(resposta.getCd_resposta());
                out.println("</Cod>");
                out.println("<DescResposta>");
                out.println(resposta.getDs_resposta());
                out.println("</DescResposta>");
                out.println("</Resposta>");
            }

            out.println("</xml>");

            out.flush();


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
