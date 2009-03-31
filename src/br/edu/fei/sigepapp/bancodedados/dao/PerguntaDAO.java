package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)perguntaDAO.java 0.01 20/02/09
 *
 * Este c�digo � parte integrante do projeto de formatura,
 * do curso de ci�ncias da computa��o, do Centro Universit�rio da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * | Tom Mix     | 30/03/09    | Cria��o         |
 * |------------------------------------------------------------------|
 *
 */

//~-- JDK import --------------------------------------------------------------
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Pergunta;
import br.edu.fei.sigepapp.log.GravarLog;

/**
 *
 * Classe responsavel por acessar o banco de dados atrav�s do modelo pergunta
 *
 * @author Tom Mix
 * @version 0.01 31 Mar 2009
 */
public class PerguntaDAO {

    private Connection conn;

    /**
     * Contrutor da classe:- cria uma conex�o com o banco de dados
     *
     * @throws SQLException
     */
    public PerguntaDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    /**
     * Metodo de inser��o de pergunta no banco de dados
     * @param pergunta
     * @return 1 = Cadastrado / 2 = Existente no BD / 3 = Erro
     */
    
    public int inserePergunta(Pergunta pergunta) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inser��o do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_PERGUNTA(?, ?, ?); end;");

            //Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            cstmt.setLong(1, pergunta.getCd_pergunta());
            cstmt.setString(2, pergunta.getDs_pergunta());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            //executa o comando e fecha a instancia do objeto
            cstmt.execute();

            int cResult = (int) cstmt.getInt(3);

            //Grava log com a informa��o de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(PerguntaDAO.class.getName() + ": inser��o no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            }else if(cResult == -1){
                GravarLog.gravaInformacao(PerguntaDAO.class.getName() + ": Pergunta j� cadastrada");
                cstmt.close();
                return 2;
            }else{
                GravarLog.gravaInformacao(PerguntaDAO.class.getName() + ": " + cResult + ": erro ao cadastrar nova pergunta.");
                cstmt.close();
                return 3;
            }

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execu��o do comando SQL
            GravarLog.gravaErro(PerguntaDAO.class.getName() + ": erro na inser��o referente a uma exce��o de SQL: " + e.getMessage());

            //Retorno da fun��o como false em caso de erro
            return 3;
        }
    }

    public boolean deletaPergunta(Pergunta pergunta){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_PERGUNTA(?,?,?); end;");

            cstmt.setLong(1, pergunta.getCd_pergunta());
            cstmt.setString(2, pergunta.getDs_pergunta());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(13);

            return true;
        }catch(SQLException e){
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
            GravarLog.gravaErro(PerguntaDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }



}
