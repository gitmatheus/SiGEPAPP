/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.CodigoPostalDAO;
import br.edu.fei.sigepapp.bancodedados.dao.EmailDAO;
import br.edu.fei.sigepapp.bancodedados.dao.EnderecoDAO;
import br.edu.fei.sigepapp.bancodedados.dao.TelefoneDAO;
import br.edu.fei.sigepapp.bancodedados.dao.UsuarioDAO;
import br.edu.fei.sigepapp.bancodedados.model.CodigoPostal;
import br.edu.fei.sigepapp.bancodedados.model.Email;
import br.edu.fei.sigepapp.bancodedados.model.Endereco;
import br.edu.fei.sigepapp.bancodedados.model.Telefone;
import br.edu.fei.sigepapp.bancodedados.model.Usuario;
import br.edu.fei.sigepapp.log.GravarLog;
import com.sun.net.ssl.internal.ssl.Debug;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class UpdUsuarioServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        out.println("<?xml version='1.0' encoding='ISO-8859-1'?>");
        out.println("<xml>");
        try {
            boolean erro = false;
            int cResult = 0;

            Usuario usuario = new Usuario();
            Endereco endereco = new Endereco();
            Email email = new Email();
            CodigoPostal codigoPostal = new CodigoPostal();
            Telefone telefone = new Telefone();

            SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

            usuario.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            Debug.println("nome", request.getParameter("nome"));
            Debug.println("sobrenome", request.getParameter("sobrenome"));
            usuario.setNm_prim_nome(request.getParameter("nome"));
            usuario.setNm_ult_nome(request.getParameter("sobrenome"));
            try {
                Date dt_nasc = new Date(df.parse(request.getParameter("datanasc")).getTime());
                usuario.setDt_nasc(dt_nasc);
            } catch (ParseException e) {
                GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no parse da data: " + e.getMessage());
            }
            usuario.setNm_msn(request.getParameter("msn"));
            usuario.setNm_skype(request.getParameter("skype"));
            usuario.setDs_area_interesse(request.getParameter("areainteresse"));

            codigoPostal.setCd_cep(Long.parseLong(request.getParameter("cep")));
            codigoPostal.setCd_cidade(Long.parseLong(request.getParameter("cidade")));
            codigoPostal.setNm_rua(request.getParameter("endereco"));

            endereco.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            endereco.setDs_complemento(request.getParameter("endcomplemento"));
            endereco.setNr_cep(Long.parseLong(request.getParameter("cep")));
            endereco.setNr_numero(Long.parseLong(request.getParameter("nroendereco")));
            endereco.setTp_endereco(request.getParameter("tipoendereco"));

            email.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            email.setNm_email(request.getParameter("email"));
            email.setTp_email(request.getParameter("tipoemail"));

            telefone.setCd_user(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
            telefone.setNr_ddi(55);
            telefone.setNr_ddd(Long.parseLong(request.getParameter("telefone").substring(0, 2)));
            telefone.setNr_telefone(Long.parseLong(request.getParameter("telefone").substring(2, 10)));
            telefone.setTp_telefone(request.getParameter("tipotelefone"));

            UsuarioDAO userDao = new UsuarioDAO();
            cResult = userDao.atualiza(usuario);
            userDao.fechaConexao();

            if (cResult != 1) {
                erro = true;
            }

            CodigoPostalDAO cpDao = new CodigoPostalDAO();
            cResult = cpDao.insere(codigoPostal);
            cpDao.fechaConexao();

            if (cResult != 1 && cResult != 2) {
                erro = true;
            }

            EnderecoDAO endDao = new EnderecoDAO();
            cResult = endDao.atualiza(endereco);
            endDao.fechaConexao();

            if (cResult != 1) {
                erro = true;
            }

            EmailDAO emailDao = new EmailDAO();
            cResult = emailDao.atualiza(email);
            emailDao.fechaConexao();

            if (cResult != 1) {
                erro = true;
            }

            TelefoneDAO telDao = new TelefoneDAO();
            cResult = telDao.atualiza(telefone);
            telDao.fechaConexao();

            if (cResult != 1) {
                erro = true;
            }

            if (erro) {
                out.println("<erro>1</erro>");
            } else {
                out.println("<erro>0</erro>");
            }

        } catch (SQLException e) {
            GravarLog.gravaErro(UpdUsuarioServlet.class.getName() + ": erro durante atualização do cadastro de usuario: " + e.getMessage() + ":" + e.getSQLState());
            out.println("<erro>1</erro>");
        } finally {
            out.println("</xml>");
            out.flush();
            out.close();
        }
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
