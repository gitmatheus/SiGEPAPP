package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 11, 2009
 */
public class ObjetoDAO {

    private Connection conn;

    public ObjetoDAO() throws SQLException{
        this.conn = ConnectionFactory.getConnection();
    }

    public long insereObjeto(Objeto obj){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_OBJETO(?,?,?,?,?,?,?); end;");

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.setString(2, obj.getNm_objeto());
            cstmt.setLong(3, obj.getCd_estrutura());
            cstmt.setString(4, obj.getDs_objeto());
            cstmt.setLong(5, obj.getCd_user_criacao());
            cstmt.setLong(6, obj.getFl_ativo());
            cstmt.registerOutParameter(7, OracleTypes.NUMBER);

            cstmt.execute();

            int cd_obj  = (int) cstmt.getLong(1);
            int cResult = (int) cstmt.getLong(7);

            cstmt.close();

            if(cResult != 1){
                GravarLog.gravaErro(ObjetoDAO.class.getName() + ": ocorreu um erro durante a inserção no banco: " + cResult);
                return 0;
            }else{
                GravarLog.gravaInformacao(ObjetoDAO.class.getName() + ": inserido com sucesso");
                return cd_obj;
            }

        }catch(SQLException e){
            GravarLog.gravaErro(ObjetoDAO.class.getName() + ": ocorreu um erro durante a execução: " + e.getSQLState() + " : " + e.getMessage());
            return 0;
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
            GravarLog.gravaErro(ObjetoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }

}
