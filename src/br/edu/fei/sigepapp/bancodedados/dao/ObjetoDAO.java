package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
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
 * @version 0.01 Mai 11, 2009
 */
public class ObjetoDAO {

    private Connection conn;

    public ObjetoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public long insereObjeto(Objeto obj) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_OBJETO(?,?,?,?,?,?,?); end;");

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.setString(2, obj.getNm_objeto());
            cstmt.setLong(3, obj.getCd_estrutura());
            cstmt.setString(4, obj.getDs_objeto());
            cstmt.setLong(5, obj.getCd_user_criacao());
            cstmt.setLong(6, obj.getFl_ativo());
            cstmt.registerOutParameter(7, OracleTypes.NUMBER);

            cstmt.execute();

            int cd_obj = (int) cstmt.getLong(1);
            int cResult = (int) cstmt.getLong(7);

            cstmt.close();

            if (cResult != 1) {
                GravarLog.gravaErro(ObjetoDAO.class.getName() + ": ocorreu um erro durante a inserção no banco: " + cResult);
                return 0;
            } else {
                GravarLog.gravaInformacao(ObjetoDAO.class.getName() + ": inserido com sucesso");
                return cd_obj;
            }

        } catch (SQLException e) {
            GravarLog.gravaErro(ObjetoDAO.class.getName() + ": ocorreu um erro durante a execução: " + e.getSQLState() + " : " + e.getMessage());
            return 0;
        }
    }

    public void apagaObjeto(long cd_objeto) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_OBJETO(?,?,?,?,?,?,?,?,?); end;");

            cstmt.setLong(1, cd_objeto);
            cstmt.setNull(2, OracleTypes.VARCHAR);
            cstmt.setNull(3, OracleTypes.NUMBER);
            cstmt.setNull(4, OracleTypes.VARCHAR);
            cstmt.setNull(5, OracleTypes.DATE);
            cstmt.setNull(6, OracleTypes.DATE);
            cstmt.setNull(7, OracleTypes.NUMBER);
            cstmt.setNull(8, OracleTypes.NUMBER);

            cstmt.registerOutParameter(9, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(9);

            cstmt.close();

            if (cResult != 1) {
                GravarLog.gravaErro(ObjetoDAO.class.getName() + ": ocorreu um erro durante a remoção no banco: " + cResult);
            } else {
                GravarLog.gravaInformacao(ObjetoDAO.class.getName() + ": removido com sucesso");
            }

        } catch (SQLException e) {
            GravarLog.gravaErro(ObjetoDAO.class.getName() + ": ocorreu um erro durante a execução: " + e.getSQLState() + " : " + e.getMessage());
        }
    }

    public List<Objeto> pesquisaObjetoAtivos(Objeto objeto) {
        long pCD_OBJETO = 0;
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_OBJETO(?,?,?,?,?,?,?,?,?); end;");
            pCD_OBJETO = objeto.getCd_objeto();

            if (pCD_OBJETO > 0) {
                cstmt.setLong(1, pCD_OBJETO);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            cstmt.setString(2, objeto.getNm_objeto());

            if (objeto.getCd_estrutura() > 0) {
                cstmt.setLong(3, objeto.getCd_estrutura());
            } else {
                cstmt.setNull(3, OracleTypes.NUMBER);
            }

            cstmt.setString(4, objeto.getDs_objeto());
            cstmt.setNull(5, OracleTypes.DATE);
            cstmt.setNull(6, OracleTypes.DATE);

            if (objeto.getCd_user_criacao() > 0) {
                cstmt.setLong(7, objeto.getCd_user_criacao());
            } else {
                cstmt.setNull(7, OracleTypes.NUMBER);
            }

            cstmt.setNull(8, OracleTypes.NUMBER);
            cstmt.registerOutParameter(9, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(9);

            List<Objeto> objetos = new ArrayList<Objeto>();

            while (rs.next()) {
                if (rs.getLong("FL_ATIVO") == 1) {
                    Objeto o = new Objeto();

                    o.setCd_objeto(rs.getLong("CD_OBJETO"));
                    o.setNm_objeto(rs.getString("NM_OBJETO"));
                    o.setCd_estrutura(rs.getLong("CD_ESTRUTURA"));
                    o.setDs_objeto(rs.getString("DS_OBJETO"));
                    o.setDt_criacao(rs.getDate("DT_CRIACAO"));
                    o.setCd_user_criacao(rs.getLong("CD_USER_CRIADOR"));
                    o.setFl_ativo(rs.getLong("FL_ATIVO"));

                    objetos.add(o);
                }
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(ObjetoDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return objetos;
        } catch (SQLException e) {
            GravarLog.gravaErro(ObjetoDAO.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage() + " : " + e.getSQLState());
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
