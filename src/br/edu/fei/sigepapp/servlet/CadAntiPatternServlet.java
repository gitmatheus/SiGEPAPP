package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.AntiPatternDAO;
import br.edu.fei.sigepapp.bancodedados.dao.ObjetoDAO;
import br.edu.fei.sigepapp.bancodedados.model.AntiPattern;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 12, 2009
 */
public class CadAntiPatternServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            try {
                Objeto objeto = new Objeto();
                AntiPattern antipattern = new AntiPattern();

                objeto.setCd_estrutura(cod_estrutura);
                objeto.setNm_objeto(valores[0]);
                objeto.setDs_objeto(valores[1]);
                objeto.setCd_user_criacao(cod_usuario);
                antipattern.setDs_Problema(valores[2]);
                antipattern.setDs_Barreiras(valores[3]);
                antipattern.setDs_Sintomas(valores[4]);
                antipattern.setDs_Consequencias(valores[5]);
                antipattern.setDs_Recomendacoes(valores[6]);

                ObjetoDAO objDao = new ObjetoDAO();
                long codigo = objDao.insereObjeto(objeto);
                objDao.fechaConexao();

                if ((int) codigo > 0) {
                    antipattern.setCd_AntiPattern(codigo);
                    AntiPatternDAO dao = new AntiPatternDAO();
                    int cResult = (int) dao.APPP_INS_ANTI_PATTERN(antipattern);
                    dao.fechaConexao();

                    if (cResult < 1) {
                        writer.println("<xml><sucesso>-3</sucesso></xml>");
                    } else {
                        writer.println("<xml><sucesso>" + codigo + "</sucesso></xml>");
                    }
                } else {
                    writer.println("<xml><sucesso>0</sucesso></xml>");
                }

            } catch (SQLException e) {
                GravarLog.gravaErro(CadPatternServlet.class.getName() + ": erro na operação da DAO: " + e.getSQLState() + " : " + e.getMessage());
                writer.println("<xml><sucesso>0</sucesso></xml>");
            }
        }
        writer.flush();
        writer.close();

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
