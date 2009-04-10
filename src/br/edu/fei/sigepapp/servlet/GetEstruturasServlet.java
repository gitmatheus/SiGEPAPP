/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.Estrutura_ObjDAO;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author user
 */
public class GetEstruturasServlet extends HttpServlet {

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
        response.setContentType("text/xhtml");
        try {

            String nome = request.getParameter("nome");
            String tipo = request.getParameter("tipo");

            Estrutura_ObjDAO daoPesquisa = new Estrutura_ObjDAO();

            List<Estrutura> estruturasEncontradas;
            estruturasEncontradas = daoPesquisa.APPP_SEL_Estrutura_OBJ(new Estrutura(0, nome, null, null, 0, tipo),null);
            daoPesquisa.fechaConexao();

            out.println("<xml>");
            for (Estrutura estrutura : estruturasEncontradas) {
                out.println("<Estrutura>");
                out.println("<Nome>");
                out.println(estrutura.getNm_estrutura());
                out.println("</Nome>");
                out.println("<Cod>");
                out.println(estrutura.getCd_estrutura());
                out.println("</Cod>");
                out.println("<Descricao>");
                out.println(estrutura.getDs_estrutura());
                out.println("</Descricao>");
                out.println("</Estrutura>");
            }

        } catch (Exception e) {
            out.println("erro: " + e.getMessage());
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
