/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Resp_Quest_Preench;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author lopespt
 */
public class Resp_Quest_PreenchDAO {


    private Connection conn;

    public Resp_Quest_PreenchDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public boolean APPP_INS_RESP_QUEST_PREENCH(Resp_Quest_Preench inserir){

        CallableStatement cstmt = null;
        long resultado = 0;

        try {
            cstmt = conn.prepareCall("begin  APPP_INS_RESP_QUEST_PREENCH(?, ?, ?, ?); end;");

            cstmt.setLong(1, inserir.getCd_quest_preench());
            cstmt.setLong(2, inserir.getCd_pergunta());
            cstmt.setLong(3, inserir.getCd_resposta());

            cstmt.registerOutParameter(4, OracleTypes.NUMBER);
            cstmt.execute();

            resultado = cstmt.getLong(4);

            cstmt.close();

            if (resultado == 1) {
                GravarLog.gravaInformacao(Resp_Quest_Preench.class.getName() + ": inserção do Resp_Quest_Preench no banco realizada com sucesso");
                return true;
            } else {
                GravarLog.gravaErro(Resp_Quest_Preench.class.getName() + ": erro na inserção do Resp_Quest_Preench no banco: Erro generico.");
                return false;
            }
        } catch (SQLException ex) {
            GravarLog.gravaErro(Resp_Quest_Preench.class.getName() + ": erro na inserção no banco de dados: " + ex.getSQLState());
            return false;
        }


    }

    
    /**
     * Metodo para fechar o banco de dados da classe
     */
    public void fechaConexao() {
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(RelacPergRespDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
