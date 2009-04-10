/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.AtributoDAO;
import br.edu.fei.sigepapp.bancodedados.model.Atributo;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lopespt
 */
public class CadAtributoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/plain");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter out = response.getWriter();

        try {

            Atributo atributoInserir = new Atributo(0, request.getParameter("nome"), request.getParameter("descricao"), Long.parseLong(request.getParameter("codTipo")), request.getParameter("relac"));
            AtributoDAO atributoDAO = new AtributoDAO();
            if (atributoDAO.APPP_INS_ATRIBUTO_OBJ(atributoInserir) == true) {
                out.print("<xml><codAtrib>"+atributoInserir.getCd_atributo_obj()+"</codAtrib></xml>");
            } else {
                out.print("Erro no cadastro");
            }
            atributoDAO.fechaConexao();
        } catch (Exception e) {
            out.print("Erro no cadastro");
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro durante o cadastro do usuario: " + e.getMessage());
        } finally {
            out.flush();
            out.close();
        }
    }
}
