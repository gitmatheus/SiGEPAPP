
package br.edu.fei.sigepapp.avaliacao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.log.GravarLog;
import java.lang.Exception;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

import org.apache.commons.mail.EmailException;  
import org.apache.commons.mail.SimpleEmail;

/**
 *
 * @author Andrey
 * @version 0.01 28 Abr 2009
 */
public class AvaliaObjeto {

    Connection conn;

    public AvaliaObjeto() throws SQLException{
        conn = ConnectionFactory.getConnection();
    }

    public void executaAcoes(long pCD_OBJ, long pCD_USER) throws Exception{
        try{
            CallableStatement cstmt = this.conn.prepareCall("{? = call APPP_FN_AVALIA_QUEST(?)}");

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.setLong(2, pCD_OBJ);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(1);

            switch(cResult){
                case 1:
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": nota da avaliação do APPP acima do limite de bloqueio.");
                    break;
                case 2:
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": número de avaliações não atingiu o minimo para comparações.");
                    break;
                case 3:
                    GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + "APPP n: " + pCD_OBJ + " : foi bloqueado.");
                    cstmt = this.conn.prepareCall("begin APPP_SEL_USER_EMAIL(?,?,?,?); end;");

                    cstmt.setLong(1, pCD_USER);
                    cstmt.setNull(2, OracleTypes.VARCHAR);
                    cstmt.setNull(3, OracleTypes.VARCHAR);
                    cstmt.registerOutParameter(4, OracleTypes.CURSOR);

                    cstmt.execute();

                    ResultSet rs = (ResultSet) cstmt.getObject(4);
                    int tamRS = 0;

                    while(rs.next()){
                        tamRS++;
                    }

                    if (tamRS != 1){
                        throw new Exception();
                    }

                    String emailUsuario = rs.getString("NM_EMAIL");

                    cstmt = this.conn.prepareCall("begin APPP_SEL_USERS(?,?,?,?,?,?,?,?,?,?,?,?,?); end;");

                    cstmt.setLong(1, pCD_USER);
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

                    while(rs.next()){
                        tamRS++;
                    }

                    if (tamRS != 1){
                        throw new Exception();
                    }

                    String nomeUsuario = rs.getString("NM_PRIM_NOME") + rs.getString("NM_ULT_NOME");

                    cstmt = this.conn.prepareCall("begin APPP_SEL_OBJETO(?,?,?,?,?,?,?,?); end;");

                    cstmt.setLong(1, pCD_OBJ);
                    cstmt.setNull(2, OracleTypes.VARCHAR);
                    cstmt.setNull(3, OracleTypes.NUMBER);
                    cstmt.setNull(4, OracleTypes.VARCHAR);
                    cstmt.setNull(5, OracleTypes.DATE);
                    cstmt.setNull(6, OracleTypes.DATE);
                    cstmt.setNull(7, OracleTypes.NUMBER);
                    cstmt.registerOutParameter(8, OracleTypes.CURSOR);

                    cstmt.execute();

                    rs = (ResultSet) cstmt.getObject(7);
                    tamRS = 0;

                    while(rs.next()){
                        tamRS++;
                    }

                    if (tamRS != 1){
                        throw new Exception();
                    }

                    String nomeObj = rs.getString("NM_OBJETO");
                    
                    enviaEmail(nomeUsuario,emailUsuario,nomeObj);
                    break;

            }

        }catch(SQLException e){
            GravarLog.gravaErro(AvaliaObjeto.class.getName() + ": erro ao realizar avaliação: " + e.getSQLState() + " : " + e.getMessage());
        }
        
    }
    
    /**
     * 
     * @param nomeUsuario
     * @param emailUsuario
     */
    public void enviaEmail(String nomeUsuario, String emailUsuario, String nomeObj) throws EmailException{
        try{
            SimpleEmail email = new SimpleEmail();
            email.setHostName("smtp.gmail.com"); // o servidor SMTP para envio do e-mail
            email.addTo(emailUsuario, nomeUsuario); //destinatário
            email.setFrom("teste@gmail.com", "SIGEPAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas"); // remetente
            email.setSubject("[SIGEPAPP] Bloqueio de APPP"); // assunto do e-mail
            email.setMsg("Seu APPP: " + nomeObj + " foi bloqueiado após avaliações.\nVerifique as respostas das avaliações acessando o SIGEPAPP.\n\nAtenciosamente,\nEquipe SIGEPAPP."); //conteudo do e-mail
            email.setAuthentication("teste", "xxxxx");
            email.setSmtpPort(465);
            email.setSSL(true);
            email.setTLS(true);
            email.send();
            GravarLog.gravaInformacao(AvaliaObjeto.class.getName() + ": email enviado com sucesso.");

        }catch(Exception e){
            GravarLog.gravaErro(AvaliaObjeto.class.getName() + ": erro ao enviar email: " + e.getMessage());

        }
    }
}

