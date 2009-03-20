package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)TelefoneDAO.java 0.01 21/02/09
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
import br.edu.fei.sigepapp.bancodedados.model.Telefone;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import oracle.jdbc.OracleTypes;

/**
 * 
 * @author Andrey Masiero
 * @version 0.01 21 Fev 2009
 *
 */
public class TelefoneDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexão com o banco de dados
     * @throws SQLException
     */
    public TelefoneDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    /**
     * Metodo que adiciona um registro do Objeto Telefone no banco de dados
     *
     * @see DAO#adiciona(Object) adiciona
     */
    public boolean insere(Telefone telefone) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_USER_TELEFONE(?,?,?,?,?,?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setLong(1, telefone.getCd_user());
            cstmt.setLong(2, telefone.getNr_ddi());
            cstmt.setLong(3, telefone.getNr_ddd());
            cstmt.setLong(4, telefone.getNr_telefone());
            cstmt.setString(5, telefone.getTp_telefone());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            //executa o comando e fecha a instancia do objeto
            cstmt.execute();
           
            int cResult = (int) cstmt.getInt(6);

            //Grava log com a informação de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return true;
            }else{
                GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return false;
            }
        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
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
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
