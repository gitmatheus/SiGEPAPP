package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.CodigoPostal;
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
 * @version 0.01 Mar 08, 2009
 */
public class CodigoPostalDAO {

    private Connection conn;

    public CodigoPostalDAO() throws SQLException {
        try {
            this.conn = ConnectionFactory.getConnection();
        } catch (SQLException e) {
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro ao tentar abrir uma conexão: " + e.getMessage());
        }
    }

    public int insere(CodigoPostal codigoPostal) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_CODIGO_POSTAL(?,?,?,?); end;");
            cstmt.setLong(1, codigoPostal.getCd_cep());
            cstmt.setString(2, codigoPostal.getNm_rua());
            cstmt.setLong(3, codigoPostal.getCd_cidade());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);
            cstmt.execute();

            long cResult = (long) cstmt.getLong(4);

            if (cResult == 1) {
                GravarLog.gravaInformacao(CodigoPostalDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            } else if (cResult == -1) {
                GravarLog.gravaInformacao(CodigoPostalDAO.class.getName() + ": Código Postal já existe.");
                cstmt.close();
                return 2;
            } else {
                GravarLog.gravaAlerta(CodigoPostalDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return 3;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());
            return 3;
        }
    }

    public boolean deleta(CodigoPostal codPostal) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_CODIGO_POSTAL(?,?,?,?); end;");

            cstmt.setLong(1, codPostal.getCd_cep());
            cstmt.setString(2, codPostal.getNm_rua());
            cstmt.setLong(3, codPostal.getCd_cidade());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(4);

            if (cResult == 1) {
                GravarLog.gravaInformacao(CodigoPostalDAO.class.getName() + ": CP excluido com sucesso.");
                cstmt.close();
                return true;
            } else {
                GravarLog.gravaAlerta(CodigoPostalDAO.class.getName() + ": erro na exclusão: retorno " + cResult);
                cstmt.close();
                return false;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro na execucao do metodo delete: " + e.getSQLState() + " : " + e.getMessage());
            return false;
        }

    }

    public List<CodigoPostal> seleciona(CodigoPostal cp) {
        List<CodigoPostal> cpostais = new ArrayList<CodigoPostal>();
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_CODIGO_POSTAL(?,?,?,?); end;");
            if (cp.getCd_cep() > 0) {
                cstmt.setLong(1, cp.getCd_cep());
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(2, cp.getNm_rua());
            if (cp.getCd_cidade() > 0) {
                cstmt.setLong(3, cp.getCd_cidade());
            } else {
                cstmt.setNull(3, OracleTypes.NULL);
            }
            cstmt.registerOutParameter(4, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(4);

            while (rs.next()) {
                CodigoPostal c = new CodigoPostal();

                c.setCd_cep(rs.getLong("CD_CEP"));
                c.setNm_rua(rs.getString("NM_RUA"));
                c.setCd_cidade(rs.getLong("CD_CIDADE"));

                cpostais.add(c);
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(CodigoPostalDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");
            return cpostais;
        } catch (SQLException e) {
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro na execucao do metodo seleciona: " + e.getSQLState() + " : " + e.getMessage());
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
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
