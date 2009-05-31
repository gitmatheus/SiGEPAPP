/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.RelacPergRespDAO;
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tom Mix
 */
public class CadRelacPergRespServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=ISO-8859-1");
        PrintWriter out = response.getWriter();
        try {

            RelacPergRespDAO relacPergResp = new RelacPergRespDAO();

            String CDPerg[] = request.getParameterValues("CDPerg");
            String CDResp[] = request.getParameterValues("CDResp");
            String PesoResp[] = request.getParameterValues("PesoResp");


            for (int i = 0; i < CDPerg.length; i++) {
                if (CDResp[i] != null && !CDResp[i].equals("0")) {
                    relacPergResp.APPP_INS_RELAC_PERG_RESP(new Relac_Perg_Resp(Long.parseLong(CDPerg[i]), Long.parseLong(CDResp[i]), Long.parseLong(PesoResp[i])));
                } else {
                    relacPergResp.APPP_DEL_RELAC_PERG_RESP(new Relac_Perg_Resp(Long.parseLong(CDPerg[i]), 0, Long.parseLong(PesoResp[i])));
                }

                
            }
            relacPergResp.fechaConexao();
            response.sendRedirect("frmCadQuestionarioStep4.jsp");

        } catch (Exception e) {
            out.println("erro: " + e.getMessage());
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
