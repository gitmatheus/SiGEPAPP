/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.QuestPreenchDAO;
import br.edu.fei.sigepapp.bancodedados.dao.RelacPergRespDAO;
import br.edu.fei.sigepapp.bancodedados.dao.Resp_Quest_PreenchDAO;
import br.edu.fei.sigepapp.bancodedados.dao.RespostaDAO;
import br.edu.fei.sigepapp.bancodedados.model.QuestPreench;
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
import br.edu.fei.sigepapp.bancodedados.model.Resp_Quest_Preench;
import br.edu.fei.sigepapp.bancodedados.model.Resposta;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.oracore.OracleTypeDATE;

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

        try {


            NomesAtributos = request.getParameterNames();

            RelacPergRespDAO respostaDao = new RelacPergRespDAO();


            List<Long> list_perguntas = new ArrayList<Long>();
            List<Long> list_respostas = new ArrayList<Long>();
            List<Long> list_pesos = new ArrayList<Long>();

            while (NomesAtributos.hasMoreElements()) {
                listaAtributos.add(NomesAtributos.nextElement().toString());
            }

            for (int i = listaAtributos.size() - 2; i >= 0; i--) {
                list_perguntas.add(Long.parseLong(listaAtributos.get(i)));
            }

            for (Long cd_pergunta : list_perguntas) {
                list_respostas.add(Long.parseLong(request.getParameter(cd_pergunta.toString())));
                //list_pesos.add(Long.parseLong(request.getParameter("valor_resp"+cd_pergunta.toString())));
            }

            List<Relac_Perg_Resp> pesquisaResp = respostaDao.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp());
            respostaDao.fechaConexao();
            Long Soma = 0l;
            for (int i = 0; i < listaAtributos.size() - 1; i++) {
                list_pesos.add(pesquisaResp.get(
                        pesquisaResp.indexOf(new Relac_Perg_Resp(list_perguntas.get(i), list_respostas.get(i), 0))).getNro_valor_resp());
                Soma += list_pesos.get(i);
                out.println(list_perguntas.get(i) + "::" + list_respostas.get(i) + "->" + list_pesos.get(i));
            }

            QuestPreenchDAO preencheDao = new QuestPreenchDAO();

            QuestPreench questionario = new QuestPreench();
            out.print("asdsadl�");
            questionario.setCd_objeto(Long.parseLong(request.getParameter("CD_OBJ")));
            questionario.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            questionario.setVl_avaliacao(Soma);
            questionario.setDt_aplicacao(new Date(Calendar.getInstance().getTimeInMillis()));
            out.print("Vou inserir");
            long retorno = preencheDao.APPP_INS_QUEST_PREENCH(questionario);
            out.print("Ja inseri");
            if (retorno > 1) {
                out.print("Ok");
                Resp_Quest_PreenchDAO quest_PreenchDAO = new Resp_Quest_PreenchDAO();
                for (int i = 0; i < listaAtributos.size() - 1; i++) {
                    Resp_Quest_Preench respostas_quest = new Resp_Quest_Preench();
                    respostas_quest.setCd_quest_preench(retorno);
                    respostas_quest.setCd_pergunta(list_perguntas.get(i));
                    respostas_quest.setCd_resposta(list_respostas.get(i));
                    quest_PreenchDAO.APPP_INS_RESP_QUEST_PREENCH(respostas_quest);
                }
                //response.sendRedirect("/frmAvaliacao2.jsp");

                quest_PreenchDAO.fechaConexao();
            } else {
                out.print("fudeu!");
            }
            preencheDao.fechaConexao();

        } catch (Exception e) {
            out.print(e.getMessage()+"Erro");
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="M�todos HttpServlet. Clique no sinal de + � esquerda para editar o c�digo.">
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
