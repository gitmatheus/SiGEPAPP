/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.TipoDAO;
import br.edu.fei.sigepapp.bancodedados.model.Tipo;
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
public class ExisteTipoServlet extends HttpServlet {
   
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
        List<Tipo> listaTipos;
        String retorno;
        try {

            String nome = request.getParameter("nome");
            TipoDAO tipoDAO = new TipoDAO();

            listaTipos = tipoDAO.APPP_SEL_TIPO_OBJ(new Tipo(0, null, null, null));

            tipoDAO.fechaConexao();
            retorno = "nao";
            for (Tipo tipo : listaTipos) {
                if (tipo.getNm_tipo().trim().equalsIgnoreCase(nome.trim())) {
                    retorno = "sim";
                    break;
                }
            }

            out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
            out.println("<xml>");
            out.println("<existente>");
            out.println(retorno);
            out.println("</existente>");
            out.println("</xml>");
        } catch (SQLException ex) {
            out.println("<erro>" + ex.getMessage() + "</erro>");
        } finally {

            out.flush();
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
