/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.GenericDAO;
import br.edu.fei.sigepapp.bancodedados.model.AtributosBuscaSimilaridade;
import br.edu.fei.sigepapp.bancodedados.model.AtributosBuscaSimilaridadePE;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
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
public class BuscaSimilaridadeServlet extends HttpServlet {

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

            if (request.getParameter("tipo").equals("APP")) {

                List<AtributosBuscaSimilaridade> buscaSimilaridade;
                GenericDAO daoGenerica = new GenericDAO();

                buscaSimilaridade = daoGenerica.buscaSimilaridade(request.getParameter("nome").trim(), request.getParameter("contexto").trim(), request.getParameter("problema").trim(), request.getParameter("solucao").trim());

                daoGenerica.fechaConexao();

                out.println("<xml>");

                NumberFormat nf = new DecimalFormat("0.000");


                for (AtributosBuscaSimilaridade registro : buscaSimilaridade) {
                    if (registro.getSimilaridade() != 0) {
                        out.println("<documento>");
                        out.println("<codigo>");
                        out.println(registro.getCd_objeto());
                        out.println("</codigo>");
                        out.println("<tipo>");
                        out.println(registro.getTp_estrutura());
                        out.println("</tipo>");
                        out.println("<similaridade>");
                        //System.out.println("sim:"+ registro.getSimilaridade());
                        out.println(nf.format(registro.getSimilaridade() * 100));
                        out.println("</similaridade>");
                        out.println("<nome>");
                        out.println(registro.getNm_objeto());
                        out.println("</nome>");
                        out.println("<contexto>");
                        out.println(registro.getContexto());
                        out.println("</contexto>");
                        out.println("<problema>");
                        out.println(registro.getProblema());
                        out.println("</problema>");
                        out.println("<solucao>");
                        out.println(registro.getSolucao());
                        out.println("</solucao>");
                        out.println("</documento>");
                    }
                }
                out.println("</xml>");
            } else if (request.getParameter("tipo").equals("PE")) {
                
                List<AtributosBuscaSimilaridadePE> buscaSimilaridade;
                GenericDAO daoGenerica = new GenericDAO();

                buscaSimilaridade = daoGenerica.buscaSimilaridadePE(request.getParameter("nome").trim(), request.getParameter("descricao").trim());

                daoGenerica.fechaConexao();

                out.println("<xml>");

                NumberFormat nf = new DecimalFormat("0.000");

                for (AtributosBuscaSimilaridadePE registro : buscaSimilaridade) {
                    if (registro.getSimilaridade() != 0) {
                        out.println("<documento>");
                        out.println("<codigo>");
                        out.println(registro.getCd_objeto());
                        out.println("</codigo>");
                        out.println("<similaridade>");
                        out.println(nf.format(registro.getSimilaridade() * 100));
                        out.println("</similaridade>");
                        out.println("<nome>");
                        out.println(registro.getNm_objeto());
                        out.println("</nome>");
                        out.println("<descricao>");
                        out.println(registro.getDs_objeto());
                        out.println("</descricao>");
                        out.println("</documento>");
                    }
                }
                out.println("</xml>");
                
                
            }


        } catch (SQLException ex) {
            Logger.getLogger(BuscaSimilaridadeServlet.class.getName()).log(Level.SEVERE, null, ex);
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
