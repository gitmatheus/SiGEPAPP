/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.avaliacao.AvaliaObjeto;
import br.edu.fei.sigepapp.bancodedados.dao.PerguntaDAO;
import br.edu.fei.sigepapp.bancodedados.dao.QuestPreenchDAO;
import br.edu.fei.sigepapp.bancodedados.dao.RelacPergRespDAO;
import br.edu.fei.sigepapp.bancodedados.dao.Resp_Quest_PreenchDAO;
import br.edu.fei.sigepapp.bancodedados.model.Pergunta;
import br.edu.fei.sigepapp.bancodedados.model.QuestPreench;
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
import br.edu.fei.sigepapp.bancodedados.model.Resp_Quest_Preench;
import br.edu.fei.sigepapp.bancodedados.model.Resposta;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author lopespt
 */
public class CadQuestPreenchServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter out = response.getWriter();
        Enumeration NomesAtributos;
        List<String> listaAtributos = new ArrayList<String>();
        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        RelacPergRespDAO respostaDao;
        QuestPreenchDAO preencheDao;
        Resp_Quest_PreenchDAO quest_PreenchDAO;
        PerguntaDAO perguntaDAO;

        try {




            NomesAtributos = request.getParameterNames();

            List<Long> list_respostas = new ArrayList<Long>();

            perguntaDAO=new PerguntaDAO();
            List<Pergunta> list_perguntas = perguntaDAO.APPP_SEL_PERGUNTA(new Pergunta());
            perguntaDAO.fechaConexao();

            respostaDao = new RelacPergRespDAO();
            List<Relac_Perg_Resp> pesquisaResp = respostaDao.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp());
            respostaDao.fechaConexao();
            Long Soma = 0l;
            int i=0;
            List<Long> list_pesos = new ArrayList<Long>();

            for (Pergunta pergunta : list_perguntas) {
                list_respostas.add(Long.parseLong(request.getParameter(Long.toString(pergunta.getCd_pergunta()))));
                list_pesos.add(pesquisaResp.get(
                        pesquisaResp.indexOf(new Relac_Perg_Resp(pergunta.getCd_pergunta(), list_respostas.get(i), 0))).getNro_valor_resp());
                Soma += list_pesos.get(i);
                out.println(list_perguntas.get(i).getCd_pergunta() + "::" + list_respostas.get(i) + "->" + list_pesos.get(i));
                i++;
            }

            preencheDao = new QuestPreenchDAO();

            QuestPreench questionario = new QuestPreench();

            questionario.setCd_objeto(Long.parseLong(request.getParameter("CD_OBJ")));
            questionario.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            questionario.setVl_avaliacao(Soma);
            questionario.setDs_proj_aplic(request.getParameter("Projeto_Aplicado"));
            questionario.setDt_aplicacao(new Date(Calendar.getInstance().getTimeInMillis()));

            long ins_quest = preencheDao.APPP_INS_QUEST_PREENCH(questionario);
            boolean ins_respostas = true;
            preencheDao.fechaConexao();
            if (ins_quest > 1) {

                i=0;
                quest_PreenchDAO = new Resp_Quest_PreenchDAO();
                for (Pergunta pergunta : list_perguntas) {
                    Resp_Quest_Preench respostas_quest = new Resp_Quest_Preench();
                    respostas_quest.setCd_quest_preench(ins_quest);
                    respostas_quest.setCd_pergunta(pergunta.getCd_pergunta());
                    respostas_quest.setCd_resposta(list_respostas.get(i));
                    if (quest_PreenchDAO.APPP_INS_RESP_QUEST_PREENCH(respostas_quest) == false) {
                        ins_respostas = false;
                    }
                    i++;
                }
                quest_PreenchDAO.fechaConexao();

                AvaliaObjeto avaliacao = new AvaliaObjeto();

                avaliacao.executaAcoes(Long.parseLong(request.getParameter("CD_OBJ")), Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));


                if (ins_quest > 1 && ins_respostas) {
                    response.sendRedirect("viewAPPP.jsp?CD_OBJ=" + Long.parseLong(request.getParameter("CD_OBJ")) + "&MSG=1");
                } else {
                    response.sendRedirect("frmAvaliacao2.jsp?MSG=2");
                }
            } else {
                response.sendRedirect("frmAvaliacao2.jsp?MSG=2");
            }



        } catch (SQLException e) {
            GravarLog.gravaErro(CadQuestPreenchServlet.class + " erro referente à uma excessão SQL : " + e.getMessage() + e.getSQLState());

        } catch (Exception e) {
            GravarLog.gravaErro(CadQuestPreenchServlet.class + " erro genérico: " + e.getMessage());
        //e.printStackTrace(out);
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
