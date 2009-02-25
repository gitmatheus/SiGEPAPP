/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import br.edu.fei.sigepapp.bancodedados.ConexaoBanco;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*ALTEREI ESTA LINHA*/
/**
 *
 * @author lopespt
 */
public class user_login extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        boolean igual;

        try {

            ConexaoBanco cb = new ConexaoBanco();
            ResultSet res = cb.ConsultaSQL("select * from APPP_TB_LOGIN where nm_login='" + request.getParameter("nome") + "'");

            if (res.next()) {
                igual = request.getParameter("senha").equals(res.getString("PW_SENHA"));
                cb.getConn().close();
                if (igual) {
                    out.println("Logado com sucesso!");
                } else {
                    out.println("Erro: Senha incorreta");
                }
            } else {
                out.println("Erro: Usuário não encontrado");
            }


        } catch (Exception e) {
            out.println(e.getMessage());
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
