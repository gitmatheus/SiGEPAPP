/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.model.*;
import br.edu.fei.sigepapp.bancodedados.dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class GetUsuarioServlet extends HttpServlet {

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
            long cod_usuario = Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString());
            Usuario usuario = new Usuario();
            Endereco endereco = new Endereco();
            CodigoPostal codigoPostal = new CodigoPostal();
            Email email = new Email();
            Cidade cidade = new Cidade();
            Estado estado = new Estado();
            Telefone telefone = new Telefone();

            usuario.setCd_user(cod_usuario);
            UsuarioDAO usuarioDao = new UsuarioDAO();
            Collection<Usuario> usuarios = usuarioDao.seleciona(usuario);
            if (usuarios.size() == 1) {
                usuarioDao.fechaConexao();
                for (Usuario u : usuarios){
                    usuario.setCd_user(u.getCd_user());
                    usuario.setNm_prim_nome(u.getNm_prim_nome());
                    usuario.setNm_ult_nome(u.getNm_ult_nome());
                    usuario.setDt_nasc(u.getDt_nasc());
                    usuario.setNr_nota(u.getNr_nota());
                    usuario.setDt_cadastro(u.getDt_cadastro());
                    usuario.setDs_area_interesse(u.getDs_area_interesse());
                    usuario.setNm_msn(u.getNm_msn());
                    usuario.setNm_skype(u.getNm_skype());
                }
                endereco.setCd_user(usuario.getCd_user());
                EnderecoDAO enderecoDao = new EnderecoDAO();
                Collection<Endereco> enderecos = enderecoDao.seleciona(endereco);
                if(enderecos.size() == 1){
                    enderecoDao.fechaConexao();
                    for (Endereco e : enderecos){
                        endereco.setCd_user(e.getCd_user());
                        endereco.setNr_cep(e.getNr_cep());
                        endereco.setDs_complemento(e.getDs_complemento());
                        endereco.setNr_numero(e.getNr_numero());
                        endereco.setTp_endereco(e.getTp_endereco());
                    }
                    CodigoPostalDAO cpDao = new CodigoPostalDAO();
                    codigoPostal.setCd_cep(endereco.getNr_cep());
                    Collection<CodigoPostal> cpostais = cpDao.seleciona(codigoPostal);
                    if(cpostais.size() == 1){
                        cpDao.fechaConexao();
                        for(CodigoPostal cp : cpostais){
                            codigoPostal.setCd_cep(cp.getCd_cep());
                            codigoPostal.setNm_rua(cp.getNm_rua());
                            codigoPostal.setCd_cidade(cp.getCd_cidade());
                        }
                        CidadeDAO cidadeDao = new CidadeDAO();
                        cidade.setCd_cidade(codigoPostal.getCd_cidade());
                        Collection<Cidade> cidades = cidadeDao.APPP_SEL_CIDADE(cidade);
                        if(cidades.size() == 1){
                            cidadeDao.fechaConexao();
                            for (Cidade c : cidades){
                                cidade.setCd_cidade(c.getCd_cidade());
                                cidade.setNm_cidade(c.getNm_cidade());
                                cidade.setNm_abrev(c.getNm_abrev());
                                cidade.setCd_estado(c.getCd_estado());
                            }
                            EstadoDAO estadoDao = new EstadoDAO();
                            estado.setCd_estado(cidade.getCd_estado());
                            Collection<Estado> estados = estadoDao.APPP_SEL_ESTADO(estado);
                            if(estados.size() == 1){
                                
                            }
                        }
                    }
                }

            }

        } catch (SQLException e) {
            
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
