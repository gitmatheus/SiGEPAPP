package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.RelacObjetos;
import br.edu.fei.sigepapp.bancodedados.model.RelacObjetos_View;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 20, 2009
 */
public class RelacObjetoDAO {

    private Connection conn;

    public RelacObjetoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public int insereRelacionamentos(RelacObjetos relacObj) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_OBJ_RELAC(?,?,?,?,?,?); end;");

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.setLong(2, relacObj.getCd_obj_relacionado());
            cstmt.setLong(3, relacObj.getCd_obj_relacionando());
            cstmt.setLong(4, relacObj.getCd_atributo_obj());
            cstmt.setString(5, relacObj.getVl_relac());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(6);
            cstmt.close();
            if (cResult != 1) {
                GravarLog.gravaErro(RelacObjetoDAO.class.getName() + ": erro durante a criação do relacionamento.");
                return 0;
            } else {
                GravarLog.gravaInformacao(RelacObjetoDAO.class.getName() + ": criação do relacionamento com sucesso.");
                return 1;
            }


        } catch (SQLException e) {
            GravarLog.gravaErro(RelacObjetoDAO.class.getName() + ": erro durante a criação do relacionamento: " + e.getSQLState() + " : " + e.getMessage());
            return 0;

        }
    }

    /**
     * @author Guilherme
     * @version 0.01 Mai 23, 2009
     */
    public List<RelacObjetos_View> APPP_SEL_OBJ_RELAC(RelacObjetos relacProcurado) {
        try {
            List<RelacObjetos_View> retorno = new ArrayList<RelacObjetos_View>();
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_OBJ_RELAC(?,?,?,?,?); end;");

            if (relacProcurado.getCd_atributo_obj() == 0) {
                cstmt.setNull(1, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(1, relacProcurado.getCd_relac());
            }

            if (relacProcurado.getCd_obj_relacionado() == 0) {
                cstmt.setNull(2, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(2, relacProcurado.getCd_obj_relacionado());
            }

            if (relacProcurado.getCd_obj_relacionando() == 0) {
                cstmt.setNull(3, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(3, relacProcurado.getCd_obj_relacionando());
            }

            if (relacProcurado.getCd_atributo_obj() == 0) {
                cstmt.setNull(4, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(4, relacProcurado.getCd_atributo_obj());
            }
            cstmt.registerOutParameter(5, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(5);

            while (rs.next()) {
                retorno.add(new RelacObjetos_View(rs.getLong("CD_RELAC"),
                        rs.getLong("CD_OBJ_RELACIONADO"),
                        rs.getLong("CD_OBJ_RELACIONANDO"),
                        rs.getLong("CD_ATRIBUTO_OBJ"),
                        rs.getString("VL_RELAC"),
                        rs.getString("NM_OBJETO"),
                        rs.getString("DS_OBJETO"),
                        rs.getString("NM_ESTRUTURA"),
                        rs.getString("TP_ESTRUTURA"),
                        rs.getString("NM_ATRIBUTO_OBJ")));
            }
            rs.close();
            cstmt.close();
            return retorno;

        } catch (SQLException e) {
            GravarLog.gravaErro(RelacObjetoDAO.class.getName() + ": erro durante a seleção do relacionamento: " + e.getSQLState() + " : " + e.getMessage());
            return null;
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
