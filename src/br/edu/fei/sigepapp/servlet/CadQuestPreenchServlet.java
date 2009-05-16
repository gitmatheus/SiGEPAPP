package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.QuestPreenchDAO;
import br.edu.fei.sigepapp.bancodedados.dao.RelacPergRespDAO;
import br.edu.fei.sigepapp.bancodedados.model.QuestPreench;
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Vector;
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

        try {
            RelacPergRespDAO relacDAO = new RelacPergRespDAO();

            List<Long> perguntas = new Vector<Long>();
            List<Long> respostas = new Vector<Long>();
            List<Long> pesos = new Vector<Long>();


            //Pegando parametros
            //questPreench.setCd_quest_preench(Long.parseLong(request.getParameter("cd_quest_preench")));
            perguntas = (List<Long>) request.getParameterNames();

            for (Long cdpergunta : perguntas) {
                pesos.add(Long.parseLong(request.getParameter(cdpergunta.toString())));
            }

            for (int i = 0; i < pesos.size(); i++) {
                Relac_Perg_Resp r = relacDAO.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp(perguntas.get(i), 0, pesos.get(i))).get(0);
                respostas.add(r.getCd_resposta());
            }



            //respostas

            pesos = (List<Long>) request.getParameterNames();

            long notaFinal = pesos.get(0);

            for (int i = 1; i < perguntas.size(); i++) {
                notaFinal = (notaFinal + pesos.get(i)) / 2l;
            }

            questPreench.setVl_avaliacao(notaFinal);
            questPreench.setDs_proj_aplic(request.getParameter("ds_proj_aplic"));
            questPreench.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            questPreench.setCd_objeto(Long.parseLong(request.getParameter("CD_OBJ")));


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

            relacDAO.fechaConexao();


        } catch (SQLException ex) {
            GravarLog.gravaErro(CadQuestPreenchServlet.class.getName() + ": erro SQL durante o cadastro do questionario preenchido: " + ex.getMessage());

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
