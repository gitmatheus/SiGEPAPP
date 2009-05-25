package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)EmailDAO.java 0.01 21/02/09
 *
 * Este codigo e parte integrante do projeto de formatura,
 * do curso de ciencias da computacao, do Centro Universitario da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * |   Andrey    | 21/02/09    | Cria��o e elabora��o inicial         |
 * |------------------------------------------------------------------|
 * 
 */

//~-- JDK import --------------------------------------------------------------
import java.sql.Connection;
import java.sql.SQLException;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Email;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 * 
 * @author Andrey Masiero
 * @version 0.01 21 Fev 2009
 */
public class EmailDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conex�o com o banco de dados
     * @throws SQLException
     */
    public EmailDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public int insere(Email email) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inser��o do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_USER_EMAIL(?,?,?,?); end;");

            //Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            cstmt.setLong(1, email.getCd_user());
            cstmt.setString(2, email.getNm_email());
            cstmt.setString(3, email.getTp_email());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            //executa o comando e fecha a instancia do objeto
            cstmt.execute();

            long cResult = (long) cstmt.getLong(4);

            if (cResult == 1) {
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": inser��o no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            } else if (cResult == -1) {
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": Email j� cadastrado");
                cstmt.close();
                return 2;
            } else {
                GravarLog.gravaAlerta(EmailDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usu�rio.");
                cstmt.close();
                return 3;
            }

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execu��o do comando SQL
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na inser��o referente a uma exce��o de SQL: " + e.getMessage() + " : " + e.getLocalizedMessage() + " : " + e.getSQLState());

            //Retorno da fun��o como false em caso de erro
            return 3;
        }
    }

    public boolean deleta(Email email) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_USER_EMAIL(?,?,?,?); end;");

            cstmt.setLong(1, email.getCd_user());
            cstmt.setString(2, email.getNm_email());
            cstmt.setString(3, email.getTp_email());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(4);

            if (cResult == 1) {
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": email removido com sucesso");
                cstmt.close();
                return true;
            } else {
                GravarLog.gravaAlerta(EmailDAO.class.getName() + ": problema durante a remo��o: retorno " + cResult);
                cstmt.close();
                return false;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na execucao do metodo delete: " + e.getSQLState() + " : " + e.getMessage());
            return false;
        }
    }

    /**
     * Busca email cadastrado
     *
     * @param email
     * @return lista de emails
     */
    public List<Email> seliona(Email email) {
        List<Email> emails = new ArrayList<Email>();
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_USER_EMAIL(?,?,?,?); end;");

            if (email.getCd_user() > 0) {
                cstmt.setLong(1, email.getCd_user());
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(3, email.getNm_email());
            cstmt.setString(3, email.getTp_email());
            cstmt.registerOutParameter(4, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(4);

            while (rs.next()) {
                Email e = new Email();

                e.setCd_user(rs.getLong("CD_USER"));
                e.setNm_email(rs.getString("NM_EMAIL"));
                e.setTp_email(rs.getString("TP_EMAIL"));

                emails.add(e);
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(EmailDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return emails;
        } catch (SQLException e) {
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na execucao do metodo seleciona: " + e.getSQLState() + " : " + e.getMessage());
            return null;
        }

    }

    /**
     * Atualiza cadastro de email
     * @param email
     * @return 1 para Ok - 0 para NOk
     */
    public int atualiza(Email email) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_UPD_USER_EMAIL(?,?,?,?); end;");

            cstmt.setLong(1, email.getCd_user());
            cstmt.setString(2, email.getNm_email());
            cstmt.setString(3, email.getTp_email());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(4);

            if (cResult != 1) {
                GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na atualiza��o");
                return 0;
            } else {
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": atualizado com sucesso");
                return 1;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na execucao do metodo atualiza: " + e.getSQLState() + " : " + e.getMessage());
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
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
