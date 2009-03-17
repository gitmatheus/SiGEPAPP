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
            GravarLog.gravaAlerta("Data: " + dt_nasc);
            usuario.setDt_nasc(dt_nasc);
        } catch (ParseException e) {
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no parse da data: " + e.getMessage());
        }
        //usuario.setDt_cadastro(new Date(data_atual.getDate(), data_atual.getMonth(), data_atual.getYear()));
        usuario.setNr_nota(0);
        usuario.setNm_msn(request.getParameter("msn"));
        usuario.setNm_skype(request.getParameter("skype"));
        usuario.setDs_area_interesse(request.getParameter("areainteresse"));

        GravarLog.gravaAlerta("Completou Usuario");

        codigoPostal.setCd_cep(Long.parseLong(request.getParameter("cep")));
        codigoPostal.setCd_cidade(Long.parseLong(request.getParameter("cidade")));
        codigoPostal.setNm_rua(request.getParameter("endereco"));

        GravarLog.gravaAlerta("Completou CodigoPostal");

        endereco.setCd_user(Long.parseLong(request.getParameter("cpf")));
        endereco.setDs_complemento(request.getParameter("endcomplemento"));
        endereco.setNr_cep(Long.parseLong(request.getParameter("cep")));
        endereco.setNr_numero(Long.parseLong(request.getParameter("nroendereco")));
        endereco.setTp_endereco(request.getParameter("tipoendereco"));

        GravarLog.gravaAlerta("Completou Endereco");

        email.setCd_user(Long.parseLong(request.getParameter("cpf")));
        email.setNm_email(request.getParameter("email"));
        email.setTp_email(request.getParameter("tipoemail"));

        GravarLog.gravaAlerta("Completou Email");

        telefone.setCd_user(Long.parseLong(request.getParameter("cpf")));
        telefone.setNr_ddi(55);
        telefone.setNr_ddd(Long.parseLong(request.getParameter("telefone").substring(0, 1)));
        telefone.setNr_telefone(Long.parseLong(request.getParameter("telefone").substring(2, 9)));
        telefone.setTp_telefone(request.getParameter("tipotelefone"));

        GravarLog.gravaAlerta("Completou Telefone");

        login.setCd_user(Long.parseLong(request.getParameter("cpf")));
        login.setNm_login(request.getParameter("login"));
        login.setPw_senha(request.getParameter("senha"));

        GravarLog.gravaAlerta("Completou Login");

        GravarLog.gravaAlerta("Completou etapa 1 - ir para a gravacao");
        try {
            UsuarioDAO usuarioDao = new UsuarioDAO();
            if (usuarioDao.insere(usuario)) {
                usuarioDao.fechaConexao();
                CodigoPostalDAO cpDao = new CodigoPostalDAO();
                if (cpDao.insere(codigoPostal)) {
                    cpDao.fechaConexao();
                    EnderecoDAO endDao = new EnderecoDAO();
                    if (endDao.insere(endereco)) {
                        endDao.fechaConexao();
                        EmailDAO emailDao = new EmailDAO();
                        if (emailDao.insere(email)) {
                            emailDao.fechaConexao();
                            TelefoneDAO telDao = new TelefoneDAO();
                            if (telDao.insere(telefone)) {
                                telDao.fechaConexao();
                                LoginDAO loginDao = new LoginDAO();
                                if (loginDao.insere(login)) {
                                    loginDao.fechaConexao();
                                    inserido = true;
                                    GravarLog.gravaAlerta("pSucesso");
                                } else {
                                    loginDao.fechaConexao();
                                    inserido = false;
                                    GravarLog.gravaAlerta("p6");
                                }
                            } else {
                                telDao.fechaConexao();
                                inserido = false;
                                GravarLog.gravaAlerta("p5");
                            }
                        } else {
                            emailDao.fechaConexao();
                            inserido = false;
                            GravarLog.gravaAlerta("p4");
                        }
                    } else {
                        endDao.fechaConexao();
                        inserido = false;
                        GravarLog.gravaAlerta("p3");
                    }
                } else {
                    cpDao.fechaConexao();
                    inserido = false;
                    GravarLog.gravaAlerta("p2");
                }
            } else {
                usuarioDao.fechaConexao();
                inserido = false;
                GravarLog.gravaAlerta("p1");
            }

        } catch (Exception e) {
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro durante o cadastro do usuario: " + e.getMessage());
        }

        if (inserido) {
            writer.println("<sucesso>sim</sucesso>");
        } else {
            writer.println("<sucesso>nao</sucesso>");
        }

        writer.flush();
        writer.close();

    }
}
