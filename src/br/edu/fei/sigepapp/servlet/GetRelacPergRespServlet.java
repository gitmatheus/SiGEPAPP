package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.PerguntaDAO;
import br.edu.fei.sigepapp.bancodedados.dao.RelacPergRespDAO;
import br.edu.fei.sigepapp.bancodedados.dao.RespostaDAO;
import br.edu.fei.sigepapp.bancodedados.model.Pergunta;
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
import br.edu.fei.sigepapp.bancodedados.model.Resposta;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Tom Mix
 */
public class GetRelacPergRespServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=ISO-8859-1");
        PrintWriter out = response.getWriter();
        Boolean erro = false;
        String xml = new String();
        long ultimoCodigo = 0l;

        try {
            RelacPergRespDAO relacPergRespDAO = new RelacPergRespDAO();
            List<Relac_Perg_Resp> listRelacPergResp = relacPergRespDAO.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp());
            relacPergRespDAO.fechaConexao();
            Relac_Perg_Resp relacPergResp;

            Pergunta p = new Pergunta();
            Resposta r = new Resposta();

            out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
            out.println("<xml>");

            for (int i = 0; i < listRelacPergResp.size(); i++) {
                relacPergResp = listRelacPergResp.get(i);
                if (ultimoCodigo != relacPergResp.getCd_pergunta() || ultimoCodigo == 0) {

                    out.println("<PerguntaResposta>");
                    out.println("<Pergunta>");
                    ultimoCodigo = relacPergResp.getCd_pergunta();
                    out.println("<CDPerg>");
                    out.println(relacPergResp.getCd_pergunta());
                    out.println("</CDPerg>");


                    p.setCd_pergunta(relacPergResp.getCd_pergunta());
                    PerguntaDAO pDAO = new PerguntaDAO();
                    List<Pergunta> listP = pDAO.APPP_SEL_PERGUNTA(p);
                    pDAO.fechaConexao();
                    if (listP.size() > 1) {
                        out.println("<erro>1</erro>");
                        erro = true;
                    } else {
                        for (Pergunta x : listP) {
                            out.println("<DSPerg>");
                            out.println(x.getDs_pergunta());
                            out.println("</DSPerg>");
                        }
                    }
                    out.println("</Pergunta>");
                    out.println("<ListaRespostas>");

                }

                out.println("<Resposta>");
                out.println("<CDResp>");
                out.println(relacPergResp.getCd_resposta());
                out.println("</CDResp>");


                RespostaDAO rDAO = new RespostaDAO();
                r.setCd_resposta(relacPergResp.getCd_resposta());
                List<Resposta> listR = rDAO.APPP_SEL_RESPOSTA(r);
                rDAO.fechaConexao();
                if (listR.size() > 1) {
                    out.println("<erro>1</erro>");
                    erro = true;
                } else {
                    for (Resposta x : listR) {
                        out.println("<DSResp>");
                        out.println(x.getDs_resposta());
                        out.println("</DSResp>");
                    }
                }

                out.println("</Resposta>");

                if (i + 1 == listRelacPergResp.size()) {
                    out.println("</ListaRespostas>");
                    out.println("</PerguntaResposta>");

                } else {
                    if (listRelacPergResp.get(i).getCd_pergunta() != listRelacPergResp.get(i + 1).getCd_pergunta()) {
                        out.println("</ListaRespostas>");
                        out.println("</PerguntaResposta>");
                    }
                }

            }

            out.println("</xml>");
            out.flush();

        } catch (SQLException ex) {
            Logger.getLogger(GetPerguntaServlet.class.getName()).log(Level.SEVERE, null, ex);
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
