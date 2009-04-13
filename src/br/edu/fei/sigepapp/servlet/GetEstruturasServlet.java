/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.Estrutura_ObjDAO;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.Server;

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
        response.setContentType("text/xml;charset=UTF-8");

        try {

            String nome = request.getParameter("nome");
            String tipo = request.getParameter("tipo");

            Estrutura_ObjDAO daoPesquisa = new Estrutura_ObjDAO();

            List<Estrutura> estruturasEncontradas;
            estruturasEncontradas = daoPesquisa.APPP_SEL_Estrutura_OBJ(new Estrutura(0, nome, null, null, 0, tipo),null);
            daoPesquisa.fechaConexao();



            out.print("<xml>");
            for (Estrutura estrutura : estruturasEncontradas) {
                out.print("<Estrutura>");
                out.print("<Nome>");
                out.print(estrutura.getNm_estrutura());
                out.print("</Nome>");
                out.print("<Cod>");
                out.print(estrutura.getCd_estrutura());
                out.print("</Cod>");
                out.print("<Descricao>");
                out.print(estrutura.getDs_estrutura());
                out.print("</Descricao>");
                out.print("<Tipo>");
                out.print(estrutura.getTp_estrutura().trim());
                out.print("</Tipo>");
                out.print("</Estrutura>");
            }

        } catch (Exception e) {
            out.println("erro: " + e.getMessage());
        } finally {
            out.print("</xml>");
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
