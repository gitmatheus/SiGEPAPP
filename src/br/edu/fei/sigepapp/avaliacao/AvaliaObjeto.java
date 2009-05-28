package br.edu.fei.sigepapp.avaliacao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.dao.ObjetoDAO;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import oracle.jdbc.OracleTypes;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;

/**
 *
 * @author Andrey
 * @version 0.01 28 Abr 2009
 */
public class AvaliaObjeto {

    Connection conn;

    public AvaliaObjeto() throws SQLException {
        conn = ConnectionFactory.getConnection();
    }

    public void executaAcoes(long pCD_OBJ, long pCD_USER) throws Exception {
        long pCD_CRIADOR = 0;
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_PROC_AVALIA_QUEST(?,?,?); end;");

            cstmt.registerOutParameter(3, OracleTypes.NUMBER);
            cstmt.setLong(1, pCD_OBJ);
            cstmt.setLong(2, pCD_USER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(3);

            switch (cResult) {
                case 1:
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": nota da avalia��o do APPP acima do limite de bloqueio.");
                    break;
                case 2:
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": n�mero de avalia��es n�o atingiu o minimo para compara��es.");
                    break;
                case 3:

                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + "APPP n: " + pCD_OBJ + " : foi bloqueado.");


                    cstmt = this.conn.prepareCall("begin APPP_SEL_OBJETO(?,?,?,?,?,?,?,?,?); end;");

                    cstmt.setLong(1, pCD_OBJ);
                    cstmt.setNull(2, OracleTypes.VARCHAR);
                    cstmt.setNull(3, OracleTypes.NUMBER);
                    cstmt.setNull(4, OracleTypes.VARCHAR);
                    cstmt.setNull(5, OracleTypes.DATE);
                    cstmt.setNull(6, OracleTypes.DATE);
                    cstmt.setNull(7, OracleTypes.NUMBER);
                    cstmt.setNull(8, OracleTypes.NUMBER);
                    cstmt.registerOutParameter(9, OracleTypes.CURSOR);

                    cstmt.execute();

                    ResultSet rs = (ResultSet) cstmt.getObject(9);
                    int tamRS = 0;

                    String nomeObj = new String();
                    while (rs.next()) {
                        tamRS++;
                        nomeObj = rs.getString("NM_OBJETO");
                        pCD_CRIADOR = rs.getLong("CD_USER_CRIADOR");
                    }
                    rs.close();
                    if (tamRS != 1) {
                        throw new Exception("Objeto N�o Encontrado");
                    }

                    //cstmt.close();
                    //this.conn.close();


                    cstmt = this.conn.prepareCall("begin APPP_SEL_USER_EMAIL(?,?,?,?); end;");

                    cstmt.setLong(1, pCD_CRIADOR);
                    cstmt.setNull(2, OracleTypes.VARCHAR);
                    cstmt.setNull(3, OracleTypes.VARCHAR);
                    cstmt.registerOutParameter(4, OracleTypes.CURSOR);

                    cstmt.execute();

                    rs = (ResultSet) cstmt.getObject(4);
                    tamRS = 0;

                    String emailUsuario = new String();
                    while (rs.next()) {
                        tamRS++;
                        emailUsuario = rs.getString("NM_EMAIL");
                    }

                    if (tamRS != 1) {
                        throw new Exception("Email do usu�rio n�o encontrado");
                    }
                    rs.close();
                    //cstmt.close();
                    //this.conn.close();

                    cstmt = this.conn.prepareCall("begin APPP_SEL_USERS(?,?,?,?,?,?,?,?,?,?,?,?,?); end;");

                    cstmt.setLong(1, pCD_CRIADOR);
                    cstmt.setNull(2, OracleTypes.VARCHAR);
                    cstmt.setNull(3, OracleTypes.VARCHAR);
                    cstmt.setNull(4, OracleTypes.DATE);
                    cstmt.setNull(5, OracleTypes.DATE);
                    cstmt.setNull(6, OracleTypes.NUMBER);
                    cstmt.setNull(7, OracleTypes.NUMBER);
                    cstmt.setNull(8, OracleTypes.DATE);
                    cstmt.setNull(9, OracleTypes.DATE);
                    cstmt.setNull(10, OracleTypes.VARCHAR);
                    cstmt.setNull(11, OracleTypes.VARCHAR);
                    cstmt.setNull(12, OracleTypes.VARCHAR);
                    cstmt.registerOutParameter(13, OracleTypes.CURSOR);

                    cstmt.execute();

                    rs = (ResultSet) cstmt.getObject(13);
                    tamRS = 0;
                    String nomeUsuario = new String();

                    while (rs.next()) {
                        nomeUsuario = rs.getString("NM_PRIM_NOME") + rs.getString("NM_ULT_NOME");
                        tamRS++;
                    }
                    rs.close();
                    if (tamRS != 1) {
                        throw new Exception("Usu�rio n�o encontrado");
                    }

                    //cstmt.close();
                    //this.conn.close();
                    cstmt.close();
                    this.conn.close();


                    GravarLog.gravaInformacao("Enviei um pedido de bloqueio");

                    final String tr_nome = nomeUsuario;
                    final String tr_email = emailUsuario;
                    final String tr_nomeObj = nomeObj;
                    final long tr_OCD_OBJ = pCD_OBJ;

                    new Thread(new Runnable() {

                        @Override
                        public void run() {
                            try {
                                enviaEmail(tr_nome, tr_email, tr_nomeObj, tr_OCD_OBJ);
                            } catch (Exception e) {
                                GravarLog.gravaErro("Erro no envio de Email: " + e.getMessage());
                            }
                        }
                    }).start();

                    break;

            }


        } catch (SQLException e) {

            GravarLog.gravaErro(AvaliaObjeto.class.getName() + ": erro ao realizar avalia��o: " + e.getSQLState() + " : " + e.getMessage());
            this.conn.close();
        }

    }

    /**
     * 
     * @param nomeUsuario
     * @param emailUsuario
     */
    public void enviaEmail(String nomeUsuario, String emailUsuario, String nomeObj, long codigoObj) throws EmailException {
        try {
            HtmlEmail email = new HtmlEmail();

            email.setHostName("smtp.gmail.com"); // o servidor SMTP para envio do e-mail
            email.addTo(emailUsuario, nomeUsuario); //destinat�rio
            email.setFrom("no.reply.sigepapp@gmail.com", "SIGEPAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas"); // remetente
            email.setSubject("[SIGEPAPP] Bloqueio de Documento APPP"); // assunto do e-mail
            email.setHtmlMsg("<html><font> Caro(a) " + nomeUsuario + ",<br /> Seu documento APPP " +
                    "<a href='http://200.207.91.166/sigepapp/viewAPPP.jsp?cd_objeto=" + codigoObj + "'>" + nomeObj + "</a>, " +
                    "foi indisponibilizado devido a baixa nota de avalia��o.<br /><br />Atenciosamente,<br />" +
                    "Equipe Sigepapp</font></html>"); //conteudo do e-mail
            email.setAuthentication("no.reply.sigepapp@gmail.com", "apppsigepapp");
            email.setSmtpPort(465);
            email.setSSL(true);
            email.setTLS(true);
            email.send();
            GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": email enviado com sucesso.");

        } catch (Exception e) {
            GravarLog.gravaErro(AvaliaObjeto.class.getName() + ": erro ao enviar email: " + e.getMessage());
        }
    }

    public void enviaEmailSimples(String nomeUsuario, String emailUsuario, String nomeObj, long codigoObj) throws EmailException {

        SimpleEmail email = new SimpleEmail();
        email.setHostName("smtp.gmail.com"); // o servidor SMTP para envio do e-mail
        email.addTo(emailUsuario, nomeUsuario); //destinat�rio
        email.setFrom("no.reply.sigepapp@gmail.com", "SIGEPAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas"); // remetente
        email.setSubject("[SIGEPAPP] Bloqueio de Documento APPP"); // assunto do e-mail
        email.setMsg("<font> Caro(a)" + nomeUsuario + ",<br /> Seu documento APPP " +
                "<a href='/sigepapp/viewAPPP.jsp?cd_objeto=" + codigoObj + "'>" + nomeObj + "</a>, " +
                "foi indisponibilizado devido a baixa nota de avalia��o.<br /><br />Atenciosamente,<br />" +
                "Equipe Sigepapp</font>"); //conteudo do e-mail
        email.setAuthentication("no.reply.sigepapp@gmail.com", "apppsigepapp");
        email.setSmtpPort(465);
        email.setSSL(true);
        email.setTLS(true);
        email.send();
    }
}

