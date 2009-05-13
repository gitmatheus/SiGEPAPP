package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.QuestPreenchDAO;
import br.edu.fei.sigepapp.bancodedados.model.QuestPreench;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tom Mix
 * @version 0.12 Abr 18, 2009
 */
public class CadQuestPreenchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        boolean inserido = false;
        boolean erro = false;

        QuestPreench questPreench = new QuestPreench();

        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

        //Pegando parametros
        questPreench.setCd_quest_preench(Long.parseLong(request.getParameter("cd_quest_preench")));
        try {
            Date dt_aplic = new Date(df.parse(request.getParameter("dt_aplicacao")).getTime());
            questPreench.setDt_aplicacao(dt_aplic);
        } catch (ParseException e) {
            GravarLog.gravaErro(CadQuestPreenchServlet.class.getName() + ": erro no parse da data: " + e.getMessage());
        }
        questPreench.setVl_avaliacao(Long.parseLong(request.getParameter("vl_avaliacao")));
        questPreench.setDs_proj_aplic(request.getParameter("ds_proj_aplic"));
        questPreench.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
        questPreench.setCd_objeto(Long.parseLong(request.getParameter("CD_OBJ")));

        try {
            QuestPreenchDAO questPreenchDAO = new QuestPreenchDAO();

            long c = 0;

            if (!erro) {
                c = questPreenchDAO.APPP_INS_QUEST_PREENCH(questPreench);
                if (c == 1) {
                    erro = false;
                    inserido = true;
                    questPreenchDAO.fechaConexao();
                } else {
                    erro = true;
                    questPreenchDAO.fechaConexao();
                }
            }

        } catch (Exception e) {
            GravarLog.gravaErro(CadQuestPreenchServlet.class.getName() + ": erro durante o cadastro do questionario preenchido: " + e.getMessage());
            inserido = false;
            erro = true;
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
