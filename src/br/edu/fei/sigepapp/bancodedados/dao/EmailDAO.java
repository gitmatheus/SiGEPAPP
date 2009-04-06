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
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * |   Andrey    | 21/02/09    | Criação e elaboração inicial         |
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
import oracle.jdbc.OracleTypes;

/**
 * 
 * @author Andrey Masiero
 * @version 0.01 21 Fev 2009
 */
public class EmailDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexão com o banco de dados
     * @throws SQLException
     */
    public EmailDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public int insere(Email email) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_USER_EMAIL(?,?,?,?); end;");
            
            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setLong(1, email.getCd_user());
            cstmt.setString(2, email.getNm_email());
            cstmt.setString(3, email.getTp_email());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            //executa o comando e fecha a instancia do objeto
            cstmt.execute();

            long cResult = (long) cstmt.getLong(4);

            if (cResult == 1) {
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            } else if(cResult == -1){
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": Email já cadastrado");
                cstmt.close();
                return 2;
            }else{
                GravarLog.gravaAlerta(EmailDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return 3;
            }

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage() + " : " + e.getLocalizedMessage() + " : " + e.getSQLState());

            //Retorno da função como false em caso de erro
            return 3;
        }
    }

    public boolean deleta(Email email){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_EMAIL_USER(?,?,?,?); end;");

            cstmt.setLong(1, email.getCd_user());
            cstmt.setString(2, email.getNm_email());
            cstmt.setString(3, email.getTp_email());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(4);

            if (cResult == 1){
                GravarLog.gravaInformacao(EmailDAO.class.getName() + ": email removido com sucesso");
                cstmt.close();
                return true;
            }else{
                GravarLog.gravaAlerta(EmailDAO.class.getName() + ": problema durante a remoção: retorno " + cResult );
                cstmt.close();
                return false;
            }
        }catch(SQLException e){
            GravarLog.gravaErro(EmailDAO.class.getName() + ": erro na execucao do metodo delete: " + e.getSQLState() + " : " + e.getMessage());
            return false;
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
