package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.PerguntaDAO;
import br.edu.fei.sigepapp.bancodedados.model.Pergunta;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tom Mix
 * @version 0.01 Abr 1, 2009
 */
public class CadPerguntaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        boolean inserido = false;
        boolean erro = false;

        Pergunta pergunta = new Pergunta();

        pergunta.setCd_pergunta(Long.parseLong(request.getParameter("cd_pergunta")));
        pergunta.setDs_pergunta(request.getParameter("ds_pergunta"));




        try {
            PerguntaDAO perguntaDao = new PerguntaDAO();

            long c=0;

            if (!erro){
                c = perguntaDao.inserePergunta(pergunta);
                if (c == 1){
                    erro = false;
                    inserido=true;
                    perguntaDao.fechaConexao();
                }else{
                    erro = true;
                    perguntaDao.fechaConexao();
                }
            }

        } catch (Exception e) {
            GravarLog.gravaErro(CadPerguntaServlet.class.getName() + ": erro durante o cadastro da pergunta: " + e.getMessage());
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
