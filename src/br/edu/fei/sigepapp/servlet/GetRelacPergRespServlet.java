package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.RelacPergRespDAO;
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
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
        response.setContentType("text/xml;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            RelacPergRespDAO relacPergRespDAO = new RelacPergRespDAO();
            List<Relac_Perg_Resp> listRelacPergResp = relacPergRespDAO.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp());

            out.println("<xml>");

            for (Relac_Perg_Resp relacPergResp : listRelacPergResp) {
                out.println("<RelacPergResp>");
                out.println("<CDPerg>");
                out.println(relacPergResp.getCd_pergunta());
                out.println("</CDPerg>");
                out.println("<CDResp>");
                out.println(relacPergResp.getCd_resposta());
                out.println("</CDResp>");
                out.println("<PesoResp>");
                out.println(relacPergResp.getNro_valor_resp());
                out.println("</PesoResp>");
                out.println("</RelacPergResp>");
            }

            out.println("</xml>");

            out.flush();
            relacPergRespDAO.fechaConexao();

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
