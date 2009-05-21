package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.RelacObjetos;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 20, 2009
 */
public class RelacObjetoDAO {

    private Connection conn;

    public RelacObjetoDAO() throws SQLException{
        this.conn = ConnectionFactory.getConnection();
    }

    public int insereRelacionamentos(RelacObjetos relacObj){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_OBJ_RELAC(?,?,?,?,?,?); end;");

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.setLong(2, relacObj.getCd_obj_relacionado());
            cstmt.setLong(3, relacObj.getCd_obj_relacionando());
            cstmt.setLong(4, relacObj.getCd_atributo_obj());
            cstmt.setString(5, relacObj.getVl_relac());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(6);

            if(cResult != 1){
                GravarLog.gravaErro(RelacObjetoDAO.class.getName() + ": erro durante a criação do relacionamento.");
                return 0;
            }else{
                GravarLog.gravaInformacao(RelacObjetoDAO.class.getName() + ": criação do relacionamento com sucesso.");
                return 1;
            }

        }catch(SQLException e){
            GravarLog.gravaErro(RelacObjetoDAO.class.getName() + ": erro durante a criação do relacionamento: " + e.getSQLState() + " : " + e.getMessage());
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
