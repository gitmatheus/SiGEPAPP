/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.Atrib_EstruturaDAO;
import br.edu.fei.sigepapp.bancodedados.dao.Estrutura_ObjDAO;
import br.edu.fei.sigepapp.bancodedados.model.Atrib_Estrutura;
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
        response.setContentType("text/plain;charset=ISO-8859-1");

        out.println("<xml>");

        long codCriacao;
        try {

            long cod_estrut = 0;
            String atributos[];
            Estrutura estrutura = new Estrutura();


            estrutura.setCod_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            estrutura.setDs_estrutura(request.getParameter("ds_estrutura"));
            estrutura.setDt_criacao(new Date(Calendar.getInstance().getTimeInMillis()));
            estrutura.setNm_estrutura(request.getParameter("nm_estrutura"));
            estrutura.setTp_estrutura(request.getParameter("tp_estrutura"));
            atributos = request.getParameterValues("atributos");


            Estrutura_ObjDAO estrutura_ObjDAO = new Estrutura_ObjDAO();
            cod_estrut = estrutura_ObjDAO.APPP_INS_Estrutura_Obj(estrutura);
            estrutura_ObjDAO.fechaConexao();

            Atrib_EstruturaDAO atrib_estrut = new Atrib_EstruturaDAO();
            for (String codAtrib : atributos) {

                atrib_estrut.APPP_INS_ATRIB_ESTRUTURA(new Atrib_Estrutura(cod_estrut, Long.parseLong(codAtrib.trim())));
            }

            codCriacao = atrib_estrut.APPP_CRIA_TABELA_ESTRUT(cod_estrut);
            atrib_estrut.fechaConexao();

            out.println("<estrutura>");
            out.println("<tipo>");
            out.println(request.getParameter("tp_estrutura"));
            out.println("</tipo>");
            out.println("<nome>");
            out.println(request.getParameter("nm_estrutura"));
            out.println("</nome>");
            out.println("<descricao>");
            out.println(request.getParameter("ds_estrutura"));
            out.println("</descricao>");
            out.println("<codigo>");
            out.println(cod_estrut);
            out.println("</codigo>");
            out.println("</estrutura>");
            if(codCriacao!=7){
                out.println("<erro>Erro na criacao da tabela no banco</erro>");
            }            
            out.println("Estrutura: " + cod_estrut + " Tipo de Estrutura: " + request.getParameter("tp_estrutura") +
                    " Nome: " + request.getParameter("nm_estrutura") + "\n Desc:" +
                    request.getParameter("ds_estrutura") + "\nAtrib: " + atributos[1] +
                    " CodigoCria: "+codCriacao );
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<erro>" + e.toString() + "</erro>");
        } finally {
            out.println("</xml>");
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
