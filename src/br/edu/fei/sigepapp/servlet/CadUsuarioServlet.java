package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.CodigoPostalDAO;
import br.edu.fei.sigepapp.bancodedados.dao.EmailDAO;
import br.edu.fei.sigepapp.bancodedados.dao.EnderecoDAO;
import br.edu.fei.sigepapp.bancodedados.dao.LoginDAO;
import br.edu.fei.sigepapp.bancodedados.dao.TelefoneDAO;
import br.edu.fei.sigepapp.bancodedados.dao.UsuarioDAO;
import br.edu.fei.sigepapp.bancodedados.model.CodigoPostal;
import br.edu.fei.sigepapp.bancodedados.model.Email;
import br.edu.fei.sigepapp.bancodedados.model.Endereco;
import br.edu.fei.sigepapp.bancodedados.model.Login;
import br.edu.fei.sigepapp.bancodedados.model.Telefone;
import br.edu.fei.sigepapp.bancodedados.model.Usuario;
import br.edu.fei.sigepapp.log.GravarLog;
import com.sun.net.ssl.internal.ssl.Debug;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 * @version 0.01 Mar 11, 2009
 */
public class CadUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        boolean inserido = false;
        boolean erro = false;
        boolean cadastrado = false;

        Usuario usuario = new Usuario();
        Endereco endereco = new Endereco();
        Email email = new Email();
        CodigoPostal codigoPostal = new CodigoPostal();
        Telefone telefone = new Telefone();
        Login login = new Login();

        SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
        //Date dt_nasc = new Date(Long.parseLong(request.getParameter("datanasc")));
        //java.util.Date data_atual = new java.util.Date();

        usuario.setCd_user(Long.parseLong(request.getParameter("cpf")));
        usuario.setNm_prim_nome(request.getParameter("nome"));
        usuario.setNm_ult_nome(request.getParameter("sobrenome"));
        try {
            //usuario.setDt_nasc((Date) df.parse(request.getParameter("datanasc")));
            //usuario.setDt_nasc(dt_nasc.valueOf(request.getParameter("datanasc")));
            Date dt_nasc = new Date(df.parse(request.getParameter("datanasc")).getTime());
            usuario.setDt_nasc(dt_nasc);
        } catch (ParseException e) {
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no parse da data: " + e.getMessage());
        }
        //usuario.setDt_cadastro(new Date(data_atual.getDate(), data_atual.getMonth(), data_atual.getYear()));
        usuario.setNr_nota(0);
        usuario.setNm_msn(request.getParameter("msn"));
        usuario.setNm_skype(request.getParameter("skype"));
        usuario.setDs_area_interesse(request.getParameter("areainteresse"));

        codigoPostal.setCd_cep(Long.parseLong(request.getParameter("cep")));
        codigoPostal.setCd_cidade(Long.parseLong(request.getParameter("cidade")));
        codigoPostal.setNm_rua(request.getParameter("endereco"));

        endereco.setCd_user(Long.parseLong(request.getParameter("cpf")));
        endereco.setDs_complemento(request.getParameter("endcomplemento"));
        endereco.setNr_cep(Long.parseLong(request.getParameter("cep")));
        endereco.setNr_numero(Long.parseLong(request.getParameter("nroendereco")));
        endereco.setTp_endereco(request.getParameter("tipoendereco"));

        email.setCd_user(Long.parseLong(request.getParameter("cpf")));
        email.setNm_email(request.getParameter("email"));
        email.setTp_email(request.getParameter("tipoemail"));

        telefone.setCd_user(Long.parseLong(request.getParameter("cpf")));
        telefone.setNr_ddi(55);
        telefone.setNr_ddd(Long.parseLong(request.getParameter("telefone").substring(0, 2)));
        telefone.setNr_telefone(Long.parseLong(request.getParameter("telefone").substring(2, 10)));
        telefone.setTp_telefone(request.getParameter("tipotelefone"));

        login.setCd_user(Long.parseLong(request.getParameter("cpf")));
        login.setNm_login(request.getParameter("login"));
        login.setPw_senha(request.getParameter("senha"));

        try {
            UsuarioDAO usuarioDao = new UsuarioDAO();
            CodigoPostalDAO cpDao = new CodigoPostalDAO();

            int c = cpDao.insere(codigoPostal);
            if (c == 3) {
                GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no cadastro do Código Postal");
                cpDao.fechaConexao();
            }else{
                cpDao.fechaConexao();
            }
            
            if (!erro){
                c = usuarioDao.insere(usuario);
                if (c == 1){
                    erro = false;
                    usuarioDao.fechaConexao();
                }else if (c == 2){
                    cadastrado = true;
                    usuarioDao.fechaConexao();
                }else{
                    erro = true;
                    usuarioDao.fechaConexao();
                }
            }

            EnderecoDAO endDao = new EnderecoDAO();
            if (!erro && !cadastrado){
               c = endDao.insere(endereco);
               if(c == 1){
                   erro = false;
                   endDao.fechaConexao();
                   EmailDAO emailDao = new EmailDAO();
                   c = emailDao.insere(email);
                   if(c == 1){
                       erro = false;
                       emailDao.fechaConexao();
                       TelefoneDAO telDao = new TelefoneDAO();
                       c = telDao.insere(telefone);
                       if (c == 1){
                           erro = false;
                           telDao.fechaConexao();
                           LoginDAO loginDao = new LoginDAO();
                           c = loginDao.insere(login);
                           if (c == 1){
                               erro = false;
                               loginDao.fechaConexao();
                               inserido = true;
                           }else{
                               erro = true;
                               loginDao.fechaConexao();
                           }
                       }else{
                           erro = false;
                           telDao.fechaConexao();
                       }
                   }else{
                       erro = true;
                       emailDao.fechaConexao();
                   }
               }else{
                   erro = true;
                   endDao.fechaConexao();
               }
            }

            if (erro){
                rollback(usuario, endereco, telefone, email, login);
            }

        } catch (Exception e) {
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro durante o cadastro do usuario: " + e.getMessage());
        }

        if (inserido) {
            writer.println("<sucesso>inserido</sucesso>");
        } else {
            if(cadastrado){
                writer.println("<sucesso>existente</sucesso>");
            }else{
                writer.println("<sucesso>erro</sucesso>");
            }
        }

        writer.flush();
        writer.close();
    }

    public void rollback(Usuario usuario, Endereco endereco, Telefone telefone, Email email, Login login){
        try{
            UsuarioDAO userDao = new UsuarioDAO();
            userDao.deleta(usuario);
            userDao.fechaConexao();

            EnderecoDAO endDao = new EnderecoDAO();
            endDao.deleta(endereco);
            endDao.fechaConexao();

            TelefoneDAO telDao = new TelefoneDAO();
            telDao.deleta(telefone);
            telDao.fechaConexao();

            EmailDAO emailDao = new EmailDAO();
            emailDao.deleta(email);
            emailDao.fechaConexao();

            LoginDAO loginDao = new LoginDAO();
            loginDao.deleta(login);
            loginDao.fechaConexao();
            
        }catch(Exception e){
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro durante rollback: CD_USER = " + usuario.getCd_user() + ": Msg de erro = " + e.getMessage());
        }

    }
}
