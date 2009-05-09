/*
 * @(#)GetAtribDeEstrutServlet.java 0.01 21/02/09
 *
 * Este c�digo � parte integrante do projeto de formatura,
 * do curso de ci�ncias da computa��o, do Centro Universit�rio da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 21/02/09    | Cria��o e elabora��o inicial         |
 * | Matheus     | 24/03/09    | Altera��o do Servlet                 |
 * |------------------------------------------------------------------|
 */

package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.AtributoDAO;
import br.edu.fei.sigepapp.bancodedados.model.AtributoCompleto;
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
        response.setContentType("text/xml;charset=ISO-8859-1");
        PrintWriter out = response.getWriter();
        try {
            long codEstrutura=Long.parseLong(request.getParameter("codestr").trim());
            AtributoDAO atributoDAO = new AtributoDAO();
            List<AtributoCompleto> rsAtributos;

            out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
            out.println("<xml>");
            

            rsAtributos = atributoDAO.APPP_PES_ATRIB_POR_ESTRUT(codEstrutura);

            atributoDAO.fechaConexao();
            
            for (AtributoCompleto atributo : rsAtributos) {
                out.println("<atributo>");
                out.println("<nome>" + atributo.getNm_atributo_obj().trim() + "</nome>");
                out.println("<id>" + atributo.getCd_atributo_obj() + "</id>");
                out.println("<descricao>" + atributo.getDs_atributo_obj() + "</descricao>");
                out.println("<idtipo>" + atributo.getCd_tipo() + "</idtipo>");
                out.println("<nmtipo>" + atributo.getNm_tipo() + "</nmtipo>");
                out.println("<oracletype>" + atributo.getT_type().trim() + "</oracletype>");
                out.println("<flagexpreg>" + atributo.getFl_exp_reg().trim() + "</flagexpreg>");
                out.println("<expreg>" + atributo.getFl_exp_reg() + "</expreg>");
                out.println("</atributo>");
            }

            out.println("</xml>");

            out.flush();
            out.close();
        } catch (SQLException ex) {
            Logger.getLogger(GetAtribDeEstrutServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
        }
    }

    // <editor-fold defaultstate="collapsed" desc="M�todos HttpServlet. Clique no sinal de + � esquerda para editar o c�digo.">
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
    
    public boolean campoDescritivo(String vCampo){

        return ( (vCampo.toUpperCase().equals("DESCRI��O")) || (vCampo.toUpperCase().equals("CONTEXTO")) );
    }
}
