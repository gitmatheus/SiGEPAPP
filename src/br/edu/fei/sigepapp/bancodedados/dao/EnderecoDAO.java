package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Endereco;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Andrey
 * @version 0.01 Mar, 09 2009
 */
public class EnderecoDAO {

    Connection conn;

    public EnderecoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public boolean insere(Endereco endereco) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_USER_ENDERECO(?,?,?,?,?,?); end;");

            cstmt.setLong(1, endereco.getCd_user());
            cstmt.setLong(2, endereco.getNr_cep());
            cstmt.setLong(3, endereco.getNr_numero());
            cstmt.setString(4, endereco.getDs_complemento());
            cstmt.setString(5, endereco.getTp_endereco());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getInt(6);

            if (cResult == 1) {
                GravarLog.gravaInformacao(EnderecoDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return true;
            } else {
                GravarLog.gravaAlerta(EnderecoDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return false;
            }
        } catch (SQLException e) {
             //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return false;
        }
    }

    public void fechaConexao() {
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
