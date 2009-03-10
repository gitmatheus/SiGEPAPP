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
public class GetAtribDeEstrut extends HttpServlet {

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
            Atrib_EstruturaDAO atrib_EstruturaDAO = new Atrib_EstruturaDAO();

            List<Atrib_Estrutura> codAtributos = atrib_EstruturaDAO.APPP_SEL_ATRIB_ESTRUTURA(new Atrib_Estrutura(Long.parseLong(request.getParameter("codatrib")) , 0));
            atrib_EstruturaDAO.fechaConexao();
            List<Atributo> nomes;

            AtributoDAO atributoDAO = new AtributoDAO();
            out.print("<xml>");
            for (Atrib_Estrutura atrib_Estrutura : codAtributos) {
                Atributo atributo = new Atributo(atrib_Estrutura.getCd_atributo_obj(), null, null, 0, null);
                nomes = atributoDAO.APPP_SEL_ATRIBUTO_OBJ(atributo);

                out.print("<atributo>" + nomes.get(0).getNm_atributo_obj().trim() + "</atributo>");

            //out.println(nomes.get(0).getNm_atributo_obj());
            }
            out.println("</xml>");
            atributoDAO.fechaConexao();
            out.flush();
            out.close();
        } catch (SQLException ex) {
            Logger.getLogger(GetAtribDeEstrut.class.getName()).log(Level.SEVERE, null, ex);
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
