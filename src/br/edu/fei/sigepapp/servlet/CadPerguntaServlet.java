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
        boolean cadastrado = false;

        Pergunta pergunta = new Pergunta();

        pergunta.setCd_pergunta(Long.parseLong(request.getParameter("codPerg")));
        pergunta.setDs_pergunta(request.getParameter("descPerg"));

        try {
            PerguntaDAO perguntaDao = new PerguntaDAO();

            int c=0;

            if (!erro){
                c = perguntaDao.inserePergunta(pergunta);
                if (c == 1){
                    erro = false;
                    perguntaDao.fechaConexao();
                }else if (c == 2){
                    cadastrado = true;
                    perguntaDao.fechaConexao();
                }else{
                    erro = true;
                    perguntaDao.fechaConexao();
                }
            }

            if (erro){
                rollback();
            }

        } catch (Exception e) {
            GravarLog.gravaErro(CadPerguntaServlet.class.getName() + ": erro durante o cadastro da pergunta: " + e.getMessage());
        }

        if (inserido) {
            writer.println("<sucesso>sim</sucesso>");
        } else {
            writer.println("<sucesso>nao</sucesso>");
        }

        writer.flush();
        writer.close();

    }

    public void rollback(){

    }
}
