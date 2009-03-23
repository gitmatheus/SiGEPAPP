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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lopespt
 */
public class CadTipoServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="Métodos HttpServlet. Clique no sinal de + à esquerda para editar o código.">
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");

        PrintWriter out = response.getWriter();
        try {
            TipoDAO tipoDAO = new TipoDAO();
            Tipo tipoInserir = new Tipo(0, request.getParameter("nome"), request.getParameter("expreg"), "S");
            if (tipoDAO.APPP_INS_TIPO(tipoInserir)) {
                out.print("Cadastrado com sucesso");
            } else {
                out.print("Erro no cadastro");
            }
            tipoDAO.fechaConexao();
        } catch (Exception e) {
            out.print("Erro no cadastro");
        } finally {
            out.close();
        }



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
