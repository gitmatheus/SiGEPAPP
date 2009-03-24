package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.CodigoPostal;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
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
            } else if (cResult == -1){
                GravarLog.gravaInformacao(CodigoPostalDAO.class.getName() + ": Código Postal já existe.");
                cstmt.close();
                return 2;
            }else{
                GravarLog.gravaAlerta(CodigoPostalDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return 3;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());
            return 3;
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
