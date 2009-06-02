package br.edu.fei.sigepapp.avaliacao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;

/**
 * Classe responsável pela avaliação de Objetos: Patterns Anti-Patter e Personas.
 * É utilizada uma procedure no banco de dados para avaliar os documentos.
 *
 * @author Andrey
 * @version 0.01 28 Abr 2009
 */
public class AvaliaObjeto {

    Connection conn;

    /**
     * Construtor
     * @throws java.sql.SQLException
     */
    public AvaliaObjeto() throws SQLException {
        conn = ConnectionFactory.getConnection();
    }

    /**
     * Faz a avaliação de um Documento. A Avaliação é feita pelo banco de dados.
     * Caso o banco retorne 1, a nota do documento está acima da média.
     * Caso o banco retorne 2, não há avaliações suficientes.
     * Caso o banco retorne 3, o documento é bloqueado e um e-mail é enviando ao
     * autor do documento.
     *
     * @param pCD_OBJ Código do Objeto que está sendo avaliado.
     * @param pCD_USER Código do usuário que está avaliando uma estrutura.
     * @throws java.lang.Exception
     */
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
                    cstmt.close();
                    conn.close();
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": nota da avaliação do APPP acima do limite de bloqueio.");
                    break;
                case 2:
                    cstmt.close();
                    conn.close();
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": número de avaliações não atingiu o minimo para comparações.");
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
                        throw new Exception("Objeto Não Encontrado");
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
                        throw new Exception("Email do usuário não encontrado");
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
                        throw new Exception("Usuário não encontrado");
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

            GravarLog.gravaErro(AvaliaObjeto.class.getName() + ": erro ao realizar avaliação: " + e.getSQLState() + " : " + e.getMessage());
            this.conn.close();
        }

    }

    /**
     * Envia um E-mail em html para um usuário.
     * 
     * @param nomeUsuario Nome do usuário
     * @param emailUsuario Email do usuário
     * @param nomeObj Nome do objeto
     * @param codigoObj Código do objeto
     * @throws EmailException
     */
    public void enviaEmail(String nomeUsuario, String emailUsuario, String nomeObj, long codigoObj) throws EmailException {
        try {
            HtmlEmail email = new HtmlEmail();

            email.setHostName("smtp.gmail.com"); // o servidor SMTP para envio do e-mail
            email.addTo(emailUsuario, nomeUsuario); //destinatário
            email.setFrom("no.reply.sigepapp@gmail.com", "SIGEPAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas"); // remetente
            email.setSubject("[SIGEPAPP] Bloqueio de Documento APPP"); // assunto do e-mail
            email.setHtmlMsg("<html><font> Caro(a) " + nomeUsuario + ",<br /> Seu documento APPP " +
                    "<a href='http://200.207.91.166/sigepapp/viewAPPP.jsp?cd_objeto=" + codigoObj + "'>" + nomeObj + "</a>, " +
                    "foi indisponibilizado devido a baixa nota de avaliação.<br /><br />Atenciosamente,<br />" +
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

    /**
     * Envia um e-mail simples para um usuário
     *
     * @param nomeUsuario Nome do usuário
     * @param emailUsuario Email do usuário
     * @param nomeObj Nome do Objeto
     * @param codigoObj Código do Objeto
     * @throws org.apache.commons.mail.EmailException
     */
    public void enviaEmailSimples(String nomeUsuario, String emailUsuario, String nomeObj, long codigoObj) throws EmailException {

        SimpleEmail email = new SimpleEmail();
        email.setHostName("smtp.gmail.com"); // o servidor SMTP para envio do e-mail
        email.addTo(emailUsuario, nomeUsuario); //destinatário
        email.setFrom("no.reply.sigepapp@gmail.com", "SIGEPAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas"); // remetente
        email.setSubject("[SIGEPAPP] Bloqueio de Documento APPP"); // assunto do e-mail
        email.setMsg("<font> Caro(a)" + nomeUsuario + ",<br /> Seu documento APPP " +
                "<a href='/sigepapp/viewAPPP.jsp?cd_objeto=" + codigoObj + "'>" + nomeObj + "</a>, " +
                "foi indisponibilizado devido a baixa nota de avaliação.<br /><br />Atenciosamente,<br />" +
                "Equipe Sigepapp</font>"); //conteudo do e-mail

        email.setAuthentication("no.reply.sigepapp@gmail.com", "apppsigepapp");
        email.setSmtpPort(465);
        email.setSSL(true);
        email.setTLS(true);
        email.send();
    }
}

