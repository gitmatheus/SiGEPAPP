/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.AtributoDAO;
import br.edu.fei.sigepapp.bancodedados.dao.TipoDAO;
import br.edu.fei.sigepapp.bancodedados.model.Atributo;
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
public class ExisteAtributoServlet extends HttpServlet {

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
        List<Atributo> listaAtributos;
        String retorno;
        try {
            
            String nome = request.getParameter("nome");
            AtributoDAO atributoDao = new AtributoDAO();

            listaAtributos = atributoDao.APPP_SEL_ATRIBUTO_OBJ(new Atributo(0, nome, null, 0, null));

            atributoDao.fechaConexao();
            retorno = "nao";
            for (Atributo atributo : listaAtributos) {
                if (atributo.getNm_atributo_obj().trim().equalsIgnoreCase(nome.trim())) {
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
}
