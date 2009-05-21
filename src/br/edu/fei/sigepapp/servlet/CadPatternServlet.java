package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.model.Pattern;
import br.edu.fei.sigepapp.bancodedados.dao.PatternDAO;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 11, 2009
 */
public class CadPatternServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml; charset: ISO-8859-1");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        String[] valores = request.getParameterValues("valores");
        long cod_estrutura = Long.parseLong(request.getParameter("estrutura"));
        long cod_usuario = 0;
        boolean erro = false;
        try {
            cod_usuario = Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString());
        } catch (Exception e) {
            GravarLog.gravaErro(CadPatternServlet.class.getName() + ": usuário não logado");
            writer.println("<xml><sucesso>2</sucesso></xml>");
            erro = true;
        }

        if (!erro) {
            Objeto objeto = new Objeto();
            Pattern pattern = new Pattern();

            objeto.setCd_estrutura(cod_estrutura);
            objeto.setNm_objeto(valores[0]);
            objeto.setDs_objeto(valores[1]);
            objeto.setCd_user_criacao(cod_usuario);
            pattern.setDs_Pat_problema(valores[2]);
            pattern.setDs_Pat_solucao(valores[3]);

            try {
                PatternDAO dao = new PatternDAO();
                int cResult = (int) dao.APPP_CREATE_PATTERN(pattern, objeto);
                dao.fechaConexao();

                if (cResult < 1) {
                    writer.println("<xml><sucesso>-3</sucesso></xml>");
                } else {
                    writer.println("<xml><sucesso>" + cResult + "</sucesso></xml>");
                }

            } catch (SQLException e) {
                GravarLog.gravaErro(CadPatternServlet.class.getName() + ": erro na operação da DAO: " + e.getSQLState() + " : " + e.getMessage());
                writer.println("<xml><sucesso>0</sucesso></xml>");
            }

        }
        writer.flush();
        writer.close();
    }
}
