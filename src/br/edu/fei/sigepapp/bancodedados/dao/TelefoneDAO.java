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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
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
    public int insere(Telefone telefone) {
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
                return 1;
            }else if(cResult == -1){
                GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": Telefone já cadastrado.");
                cstmt.close();
                return 2;
            }else{
                GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": " + cResult + ": erro ao cadastrar novo usuário.");
                cstmt.close();
                return 3;
            }
        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return 3;
        }
    }

    public boolean deleta(Telefone telefone){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_USER_TELEFONE(?,?,?); end;");

            cstmt.setLong(1, telefone.getCd_user());
            cstmt.setString(2,telefone.getTp_telefone());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(3);

            if(cResult == 1){
                GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": telefone removido com sucesso.");
                cstmt.close();
                return true;
            }else{
                GravarLog.gravaAlerta(TelefoneDAO.class.getName() + ": problemas durante a remoção: retorno " + cResult);
                cstmt.close();
                return false;
            }
        }catch(SQLException e){
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro na execucao do metodo delete: " + e.getSQLState() + " : " + e.getMessage());
            return false;
        }
    }

    public List<Telefone> seleciona(Telefone telefone){
        List<Telefone> telefones = new ArrayList<Telefone>();
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_USER_TELEFONE(?,?,?,?,?,?); end;");

            if(telefone.getCd_user() > 0){
                cstmt.setLong(1, telefone.getCd_user());
            }else{
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            if(telefone.getNr_ddi() > 0){
                cstmt.setLong(2, telefone.getNr_ddi());
            }else{
                cstmt.setNull(2, OracleTypes.NUMBER);
            }

            if(telefone.getNr_ddd() > 0){
                cstmt.setLong(3, telefone.getNr_ddd());
            }else{
                cstmt.setNull(3, OracleTypes.NUMBER);
            }

            if(telefone.getNr_telefone() > 0){
                cstmt.setLong(4, telefone.getNr_telefone());
            }else{
                cstmt.setNull(4, OracleTypes.NUMBER);
            }

            cstmt.setString(5, telefone.getTp_telefone());
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(6);

            while(rs.next()){
                Telefone t = new Telefone();

                t.setCd_user(rs.getLong("CD_USER"));
                t.setNr_ddi(rs.getLong("NR_DDI"));
                t.setNr_ddd(rs.getLong("NR_DDD"));
                t.setNr_telefone(rs.getLong("NR_TELEFONE"));
                t.setTp_telefone(rs.getString("TP_TELEFONE"));

                telefones.add(t);
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return telefones;
        }catch(SQLException e){
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro na execucao do metodo seleciona: " + e.getSQLState() + " : " + e.getMessage());
            return null;
        }
    }

    public int atualiza(Telefone telefone){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_UPD_USER_TELEFONE(?,?,?,?,?,?); end;");

            cstmt.setLong(1, telefone.getCd_user());
            cstmt.setLong(2, telefone.getNr_ddi());
            cstmt.setLong(3, telefone.getNr_ddd());
            cstmt.setLong(4, telefone.getNr_telefone());
            cstmt.setString(5, telefone.getTp_telefone());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(6);

            if (cResult != 1) {
                GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro na atualização");
                return 0;
            } else {
                GravarLog.gravaInformacao(TelefoneDAO.class.getName() + ": atualizado com sucesso");
                return 1;
            }
        }catch(SQLException e){
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro na execucao do metodo atualiza: " + e.getSQLState() + " : " + e.getMessage());
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
            GravarLog.gravaErro(TelefoneDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
