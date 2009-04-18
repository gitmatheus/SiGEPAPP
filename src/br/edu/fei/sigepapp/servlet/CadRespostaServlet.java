package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.RespostaDAO;
import br.edu.fei.sigepapp.bancodedados.model.Resposta;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tom Mix
 * @version 0.01 Abr 18, 2009
 */
public class CadRespostaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        boolean inserido = false;
        boolean erro = false;

        Resposta resposta = new Resposta();

        resposta.setCd_resposta(Long.parseLong(request.getParameter("cd_resposta")));
        resposta.setDs_resposta(request.getParameter("ds_resposta"));

        try {
            RespostaDAO respostaDAO = new RespostaDAO();

            long c=0;

            if (!erro){
                c = respostaDAO.APPP_INS_RESPOSTA(resposta);
                if (c == 1){
                    erro = false;
                    inserido=true;
                    respostaDAO.fechaConexao();
                }else{
                    erro = true;
                    respostaDAO.fechaConexao();
                }
            }

        } catch (Exception e) {
            GravarLog.gravaErro(CadRespostaServlet.class.getName() + ": erro durante o cadastro da resposta: " + e.getMessage());
            inserido=false;
            erro=true;
        }

        if (inserido) {
            writer.println("<xml><sucesso>sim</sucesso></xml>");
        } else {
            writer.println("<xml><sucesso>nao</sucesso><xml>");
        }

        writer.flush();
        writer.close();

    }

}
