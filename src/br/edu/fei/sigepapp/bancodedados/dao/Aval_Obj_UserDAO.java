/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.AvalObjUser;
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
 * @author lopespt
 */
public class Aval_Obj_UserDAO {

    private Connection conn;

    public Aval_Obj_UserDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<AvalObjUser> APPP_SEL_AvalObjUser(AvalObjUser selecionar) {

        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_AVAL_OBJ_USER(? ,? ,? ); end;");


            if (selecionar.getCd_user() != 0) {
                cstmt.setLong(1, selecionar.getCd_user());
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            if (selecionar.getCd_obj() != 0) {
                cstmt.setLong(2, selecionar.getCd_obj());
            } else {
                cstmt.setNull(2, OracleTypes.NUMBER);
            }
            cstmt.registerOutParameter(3, OracleTypes.CURSOR);
            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(3);

            List<AvalObjUser> retorno = new ArrayList<AvalObjUser>();

            while (rs.next()) {
                retorno.add(new AvalObjUser(rs.getLong(1), rs.getLong(2)));
            }
            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Aval_Obj_UserDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return retorno;

        } catch (SQLException e) {
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Aval_Obj_UserDAO.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public boolean APPP_INS_AvalObjUser(AvalObjUser inserir) {

        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_AvalObjUser(? ,? ,? ); end;");


            if (inserir.getCd_user() != 0) {
                cstmt.setLong(1, inserir.getCd_user());
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            if (inserir.getCd_obj() != 0) {
                cstmt.setLong(2, inserir.getCd_obj());
            } else {
                cstmt.setNull(2, OracleTypes.NUMBER);
            }
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);
            cstmt.execute();

            long retorno = cstmt.getLong(3);

            //fecha a instancia dos objetos

            cstmt.close();

            if (retorno == 1) {
                //Grava log com a informação de sucesso
                GravarLog.gravaInformacao(Aval_Obj_UserDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                return true;
            } else {
                GravarLog.gravaErro(Aval_Obj_UserDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL");
                return false;
            }

        } catch (SQLException e) {
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Aval_Obj_UserDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return false;
        }
    }

    public void fechaConexao() {
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(Aval_Obj_UserDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
