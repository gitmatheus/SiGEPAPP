/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.Estrutura_ObjDAO;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
public class CadEstruturaServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {

            long cod_estrut = 0;

            Estrutura estrutura = new Estrutura();

            estrutura.setCod_user(35140189879l);
            estrutura.setDs_estrutura(request.getParameter("ds_estrutura"));
            estrutura.setDt_criacao(new Date(Calendar.getInstance().getTimeInMillis()));
            estrutura.setNm_estrutura(request.getParameter("nm_estrutura"));
            estrutura.setTp_estrutura(request.getParameter("tp_estrutura"));

            Estrutura_ObjDAO estrutura_ObjDAO = new Estrutura_ObjDAO();
            cod_estrut = estrutura_ObjDAO.APPP_INS_Estrutura_Obj(estrutura);

            estrutura_ObjDAO.fechaConexao();

            out.println("Estrutura: "+cod_estrut+" Tipo de Estrutura: "+request.getParameter("tp_estrutura")+" Nome: "+request.getParameter("nm_estrutura")+"\n Desc:"+request.getParameter("ds_estrutura"));
            
        } catch (Exception e) {
            out.println("erro: " + e.getMessage());
        } finally {
            out.flush();
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
