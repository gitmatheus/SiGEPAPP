package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.Estrutura_ObjDAO;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class BuscaEstrutCadAPPPServlet extends HttpServlet {

    /**
     * 
     * @param request
     * @param response
     * @throws java.io.IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml; charset: ISO-8859-1");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();
        int qtdAPPP = 0;

        try {
            Estrutura_ObjDAO dao = new Estrutura_ObjDAO();
            Collection<Estrutura> estruturas = dao.APPP_SEL_Estrutura_Geral(new Estrutura());
            dao.fechaConexao();

            writer.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
            writer.println("<estruturas>");

            switch (Integer.parseInt(request.getParameter("tipos_requisitados"))) {
                case 1:
                    for (Estrutura e : estruturas) {
                        writer.println("<estrutura>");
                        writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                        writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                        if (e.getTp_estrutura().equals("PA")) {
                            writer.println("<tp_est>Pattern</tp_est>");
                        } else if (e.getTp_estrutura().equals("AP")) {
                            writer.println("<tp_est>Anti-Pattern</tp_est>");
                        } else if (e.getTp_estrutura().equals("PE")) {
                            writer.println("<tp_est>Persona</tp_est>");
                        }
                        writer.println("</estrutura>");
                        qtdAPPP++;
                    }
                    break;
                case 2:
                    for (Estrutura e : estruturas) {
                        if (!e.getTp_estrutura().equals("PA")) {
                            writer.println("<estrutura>");
                            writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                            writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                            if (e.getTp_estrutura().equals("AP")) {
                                writer.println("<tp_est>Anti-Pattern</tp_est>");
                            } else if (e.getTp_estrutura().equals("PE")) {
                                writer.println("<tp_est>Persona</tp_est>");
                            }
                            writer.println("</estrutura>");
                            qtdAPPP++;
                        }
                    }
                    break;
                case 3:
                    for (Estrutura e : estruturas) {
                        if (!e.getTp_estrutura().equals("AP")) {
                            writer.println("<estrutura>");
                            writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                            writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                            if (e.getTp_estrutura().equals("PA")) {
                                writer.println("<tp_est>Pattern</tp_est>");
                            } else if (e.getTp_estrutura().equals("PE")) {
                                writer.println("<tp_est>Persona</tp_est>");
                            }
                            writer.println("</estrutura>");
                            qtdAPPP++;
                        }
                    }
                    break;
                case 4:
                    for (Estrutura e : estruturas) {
                        if (!e.getTp_estrutura().equals("PE")) {
                            writer.println("<estrutura>");
                            writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                            writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                            if (e.getTp_estrutura().equals("AP")) {
                                writer.println("<tp_est>Anti-Pattern</tp_est>");
                            } else if (e.getTp_estrutura().equals("PA")) {
                                writer.println("<tp_est>Pattern</tp_est>");
                            }
                            writer.println("</estrutura>");
                            qtdAPPP++;
                        }
                    }
                    break;
                case 5:
                    for (Estrutura e : estruturas) {
                        if (e.getTp_estrutura().equals("PA")) {
                            writer.println("<estrutura>");
                            writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                            writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                            writer.println("<tp_est>Pattern</tp_est>");
                            writer.println("</estrutura>");
                            qtdAPPP++;
                        }
                    }
                    break;
                case 6:
                    for (Estrutura e : estruturas) {
                        if (e.getTp_estrutura().equals("AP")) {
                            writer.println("<estrutura>");
                            writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                            writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                            writer.println("<tp_est>Anti-Pattern</tp_est>");
                            writer.println("</estrutura>");
                            qtdAPPP++;
                        }
                    }
                    break;
                case 7:
                    for (Estrutura e : estruturas) {
                        if (e.getTp_estrutura().equals("PE")) {
                            writer.println("<estrutura>");
                            writer.println("<cod_est>" + e.getCd_estrutura() + "</cod_est>");
                            writer.println("<nm_est>" + e.getNm_estrutura() + "</nm_est>");
                            writer.println("<tp_est>Persona</tp_est>");
                            writer.println("</estrutura>");
                            qtdAPPP++;
                        }
                    }
                    break;
            }

            writer.println("<qtd>" + qtdAPPP + "</qtd>");
            writer.println("</estruturas>");
            writer.flush();
            writer.close();

        } catch (Exception e) {
            GravarLog.gravaErro(BuscaEstrutCadAPPPServlet.class.getName() + ": erro na busca de estrutura: " + e.getMessage());
            writer.println("<estruturas><cod_est>erro</cod_est><nm_est></nm_est><tp_est></tp_est><qtd>0</qtd></estruturas>");
            writer.flush();
            writer.close();
        }
    }
}
