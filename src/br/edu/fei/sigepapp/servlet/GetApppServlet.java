/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.dao.GenericDAO;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author lopespt
 */
public class GetApppServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain;charset=ISO-8859-1");
        PrintWriter out = response.getWriter();
        Connection conn;
        ResultSet rs = null;
        CallableStatement cstmt = null;
        try {

            conn = ConnectionFactory.getConnection();

            cstmt = conn.prepareCall("begin APPP_SEL_APPP_GEN(?,?); end;");
            cstmt.setLong(1, 1);
            cstmt.registerOutParameter(2, OracleTypes.CURSOR);

            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(2);
            //cstmt.close();
            int TotalCols = rs.getMetaData().getColumnCount();

            out.println("<xml>");
            while (rs.next()) {
                for (int i = 0; i < TotalCols; i++) {
                    out.println("<Atributo>");
                    out.println("<Nome>");
                    out.println(rs.getMetaData().getColumnName(i));
                    out.println("</Nome>");
                    out.println("<Tipo>");
                    //out.println(rs.getMetaData().getColumnType(i));
                    out.println("</Tipo>");
                    out.println("<Valor>");
                    //out.println(rs.getString(i));
                    out.println("</Valor>");

                    out.println("</Atributo>");
                }
            }
            rs.close();
            cstmt.close();
            out.println("</xml>");
        } catch (SQLException e) {
            
            GravarLog.gravaErro(GenericDAO.class.getName() + ": erro ao pesquisar o Objeto APPP: " + e.getMessage() + " : " + e.getSQLState());

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
