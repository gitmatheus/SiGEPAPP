package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Endereco;
import br.edu.fei.sigepapp.log.GravarLog;
import com.sun.net.ssl.internal.ssl.Debug;
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
 * @version 0.01 Mar, 09 2009
 */
public class EnderecoDAO {

    Connection conn;

    public EnderecoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public int insere(Endereco endereco) {
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
                return 1;
            } else if (cResult == -1) {
                GravarLog.gravaInformacao(EnderecoDAO.class.getName() + ": Endereço já cadastrado.");
                cstmt.close();
                return 2;
            } else {
                GravarLog.gravaAlerta(EnderecoDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return 3;
            }
        } catch (SQLException e) {
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return 3;
        }
    }

    public boolean deleta(Endereco endereco) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_USER_ENDERECO(?,?,?); end;");

            cstmt.setLong(1, endereco.getCd_user());
            cstmt.setString(2, endereco.getTp_endereco());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(3);

            if (cResult == 1) {
                GravarLog.gravaInformacao(EnderecoDAO.class.getName() + ": endereco removido com sucesso.");
                cstmt.close();
                return true;
            } else {
                GravarLog.gravaAlerta(EnderecoDAO.class.getName() + ": problemas durante a remoção: retorno " + cResult);
                cstmt.close();
                return false;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro na execucao do metodo delete: " + e.getSQLState() + " : " + e.getMessage());
            return false;
        }
    }

    public List<Endereco> seleciona(Endereco endereco) {
        List<Endereco> enderecos = new ArrayList<Endereco>();
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_USER_ENDERECO(?,?,?,?,?,?); end;");

            if (endereco.getCd_user() > 0) {
                cstmt.setLong(1, endereco.getCd_user());
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            if (endereco.getNr_cep() > 0) {
                cstmt.setLong(2, endereco.getNr_cep());
            } else {
                cstmt.setNull(2, OracleTypes.NUMBER);
            }

            if (endereco.getNr_numero() > 0) {
                cstmt.setLong(3, endereco.getNr_numero());
            } else {
                cstmt.setNull(3, OracleTypes.NUMBER);
            }

            cstmt.setString(4, endereco.getDs_complemento());
            cstmt.setString(5, endereco.getTp_endereco());
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(6);

            while (rs.next()) {
                Endereco e = new Endereco();

                e.setCd_user(rs.getLong("CD_USER"));
                e.setNr_cep(rs.getLong("NR_CEP"));
                e.setNr_numero(rs.getLong("NR_NUMERO"));
                e.setDs_complemento(rs.getString("DS_COMPLEMENTO"));
                e.setTp_endereco(rs.getString("TP_ENDERECO"));

                enderecos.add(e);
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(EnderecoDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return enderecos;
        } catch (SQLException e) {
            GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro na execucao do metodo seleciona: " + e.getSQLState() + " : " + e.getMessage());
            return null;
        }
    }

    public int atualiza(Endereco endereco){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_UPD_USER_ENDERECO(?,?,?,?,?,?); end;");

            cstmt.setLong(1,endereco.getCd_user());
            cstmt.setLong(2, endereco.getNr_cep());
            cstmt.setLong(3, endereco.getNr_numero());
            cstmt.setString(4, endereco.getDs_complemento());
            cstmt.setString(5, endereco.getTp_endereco());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(6);

            if (cResult != 1) {
                GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro na atualização");
                return 0;
            } else {
                GravarLog.gravaInformacao(EnderecoDAO.class.getName() + ": atualizado com sucesso");
                return 1;
            }
        }catch(SQLException e){
            GravarLog.gravaErro(EnderecoDAO.class.getName() + ": erro na execucao do metodo atualiza: " + e.getSQLState() + " : " + e.getMessage());
            return 0;
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
