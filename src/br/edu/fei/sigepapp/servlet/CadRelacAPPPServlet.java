/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.RelacObjetoDAO;
import br.edu.fei.sigepapp.bancodedados.model.RelacObjetos;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class CadRelacAPPPServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/xml; charset: ISO-8859-1");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter out = response.getWriter();
        out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
        out.println("<xml>");
        try {
            RelacObjetos relacObj = new RelacObjetos();
            RelacObjetoDAO dao = new RelacObjetoDAO();

            long cd_objeto = Long.parseLong(request.getParameter("cd_objeto"));
            String[] appp = request.getParameterValues("cod_appp_relac");
            String[] atributos = request.getParameterValues("cod_atrib_relac");
            String[] valores = request.getParameterValues("vlr_relacao");
            int cResult = 0;

            for(int i = 0; i < appp.length; i++){
                relacObj.setCd_obj_relacionado(cd_objeto);
                relacObj.setCd_obj_relacionando(Long.parseLong(appp[i]));
                relacObj.setCd_atributo_obj(Long.parseLong(atributos[i]));
                relacObj.setVl_relac(valores[i]);
                cResult = dao.insereRelacionamentos(relacObj);
                if(cResult == 1){
                    GravarLog.gravaInformacao(CadRelacAPPPServlet.class.getName() + ": relacionamento cadastrado com sucesso.");
                }else{
                    GravarLog.gravaErro(CadRelacAPPPServlet.class.getName() + ": erro no cadastro do relacionamento. APPP: " + appp[i] + " Atributo: " + atributos[i] + " Valor: " + valores[i]);
                }

            }

            dao.fechaConexao();
            out.println("<sucesso>1</sucesso>");

        }catch(SQLException e){
            GravarLog.gravaErro(CadRelacAPPPServlet.class.getName() + ": exception no cadastro do relacionamento: " + e.getSQLState() + " : " + e.getMessage());
            out.println("<sucesso>0</sucesso>");
        } finally {
            out.println("</xml>");
            out.flush();
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
