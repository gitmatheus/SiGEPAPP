package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)UsuarioDAO.java 0.01 20/02/09
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
 * | Andrey      | 20/02/09    | Cria��o e elabora��o inicial         |
 * |------------------------------------------------------------------|
 * 
 */

//~-- JDK import --------------------------------------------------------------
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Usuario;
import br.edu.fei.sigepapp.log.GravarLog;

/**
 * 
 * Classe responsavel por acessar o banco de dados atrav�s do modelo Usuario
 * 
 * @author Andrey Masiero
 * @version 0.01 20 Fev 2009
 */
public class UsuarioDAO {

    private Connection conn;

    /**
     * Contrutor da classe:- cria uma conex�o com o banco de dados
     *
     * @throws SQLException
     */
    public UsuarioDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public boolean insere(Usuario usuario) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inser��o do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_USER(?, ?, ?, ?, ?, ?, ?, ?, ?); end;");

            //Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            cstmt.setLong(1, usuario.getCd_user());
            cstmt.setString(2, usuario.getNm_prim_nome());
            cstmt.setString(3, usuario.getNm_ult_nome());
            cstmt.setDate(4, usuario.getDt_nasc());
            cstmt.setDouble(5, usuario.getNr_nota());
            cstmt.setString(6, usuario.getDs_area_interesse());
            cstmt.setString(7, usuario.getNm_msn());
            cstmt.setString(8, usuario.getNm_skype());
            cstmt.registerOutParameter(9, OracleTypes.NUMBER);

            GravarLog.gravaAlerta("Preparou CSTMT");

            //executa o comando e fecha a instancia do objeto
            cstmt.execute();

            GravarLog.gravaAlerta("Executou SQL");

            int cResult = (int) cstmt.getInt(9);
            GravarLog.gravaAlerta("cResult: " + cResult);

            //Grava log com a informa��o de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(UsuarioDAO.class.getName() + ": inser��o no banco de dados realizada com sucesso");
                cstmt.close();
                return true;
            }else{
                GravarLog.gravaInformacao(UsuarioDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usu�rio.");
                cstmt.close();
                return false;
            }
            
        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execu��o do comando SQL
            GravarLog.gravaErro(UsuarioDAO.class.getName() + ": erro na inser��o referente a uma exce��o de SQL: " + e.getMessage());

            //Retorno da fun��o como false em caso de erro
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
            GravarLog.gravaErro(UsuarioDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
