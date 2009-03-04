/*
 * @(#)Estrutura_ObjDAO.java 0.01 21/02/09
 *
 * Este código é parte integrante do projeto de formatura,
 * do curso de ciências da computação, do Centro Universitário da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 21/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 *
 */

//~-- JDK import --------------------------------------------------------------
package br.edu.fei.sigepapp.bancodedados.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura_Obj;
import br.edu.fei.sigepapp.log.GravarLog;

/**
 *
 * @author lopespt
 */
public class Estrutura_ObjDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexao com o banco de dados
     * @throws SQLException
     */
    public Estrutura_ObjDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Estrutura_Obj> seleciona(String query) {
        try {

            PreparedStatement stmt = this.conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            List<Estrutura_Obj> estruturas = new ArrayList<Estrutura_Obj>();

            while (rs.next()) {
                Estrutura_Obj novaEstrutura = new Estrutura_Obj(rs.getLong("CD_ESTRUTURA"), rs.getString("NM_ESTRUTURA"), rs.getString("DS_ESTRUTURA"), rs.getDate("DT_CRIACAO"), rs.getLong("CD_USER"), rs.getString("TP_ESTRUTURA"));
                estruturas.add(novaEstrutura);
            }

            stmt.close();
            rs.close();

            this.conn.close();
            this.conn.commit();

            return estruturas;

        } catch (SQLException ex) {
            GravarLog.gravaErro(Estrutura_Obj.class.getName() + ": erro na pesquisa referente a uma excecao de SQL: " + ex.getMessage());

            return null;
        }
    }

    public boolean adiciona(Estrutura_Obj estruturaAdicionar) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para insercao do registro no banco
            PreparedStatement stmt =
                    this.conn.prepareStatement(
                    "insert into appp_tb_estrut_obj (cd_estrutura, cd_user, ds_estrutura, dt_criacao," + "nm_estrutura, tp_estrutura)" + "values (?, ?, ?, ?, ?, ?)");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string
            stmt.setLong(1, estruturaAdicionar.getCd_estrutura());
            stmt.setLong(2, estruturaAdicionar.getCod_user());
            stmt.setString(3, estruturaAdicionar.getDs_estrutura());
            stmt.setDate(4, estruturaAdicionar.getDt_criacao());
            stmt.setString(5, estruturaAdicionar.getNm_estrutura());
            stmt.setString(6, estruturaAdicionar.getTp_estrutura());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Estrutura_Obj.class.getName() + ": insercao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();
            this.conn.commit();

            // Retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Estrutura_Obj.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }

    }

    public boolean deleta(Estrutura_Obj objDeletar) {
        try {

            PreparedStatement stmt = conn.prepareStatement("delete from APPP_TB_ESTRUT_OBJ where CD_ESTRUTURA=?");
            stmt.setLong(1, objDeletar.getCd_estrutura());
            stmt.execute();
            stmt.close();

            this.conn.close();
            this.conn.commit();

            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Estrutura_Obj.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }
    }

    public boolean atualiza(Estrutura_Obj estruturaAtualizar) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para atualizacao do registro no banco
            PreparedStatement stmt =
                    this.conn.prepareStatement(
                    "update APPP_TB_ESTRUT_OBJ set cd_user=?, ds_estrutura=?, dt_criacao=?," + "nm_estrutura=?, tp_estrutura=? where CD_ESTRUTURA=?");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string

            stmt.setLong(1, estruturaAtualizar.getCod_user());
            stmt.setString(2, estruturaAtualizar.getDs_estrutura());
            stmt.setDate(3, estruturaAtualizar.getDt_criacao());
            stmt.setString(4, estruturaAtualizar.getNm_estrutura());
            stmt.setString(5, estruturaAtualizar.getTp_estrutura());

            stmt.setLong(6, estruturaAtualizar.getCd_estrutura());
            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Estrutura_Obj.class.getName() + ": atualizacao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();
            this.conn.commit();

            // retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Estrutura_Obj.class.getName() + ": erro na atualizacao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
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
            GravarLog.gravaErro(Estrutura_ObjDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
