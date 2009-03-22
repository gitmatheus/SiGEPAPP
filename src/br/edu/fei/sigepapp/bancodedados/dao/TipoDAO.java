/*
 * @(#)TipoDAO.java 0.01 21/02/09
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
 * | Guillherme  | 21/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 *
 */



package br.edu.fei.sigepapp.bancodedados.dao;
//~-- JDK import --------------------------------------------------------------
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Tipo;
import br.edu.fei.sigepapp.log.GravarLog;
/**
 *
 * @author lopespt
 */
public class TipoDAO {

    private Connection conn;

    public TipoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Tipo> seleciona(String query) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            PreparedStatement stmt = this.conn.prepareStatement(query);

            // Executa a query e armazenando em um Objeto ResultSet
            ResultSet rs = stmt.executeQuery();

            // Cria um array do tipo Usuarios
            List<Tipo> tipos = new ArrayList<Tipo>();

            // Enquando a pesquisa nao chegar ao fim ele armazena no array os resultados e permanece no loop
            while (rs.next()) {

                // Cria um objeto do tipo Tipo
                Tipo tipoNovo = new Tipo();

                // armazena os valores do ResultSet no Usuario
                tipoNovo.setCd_tipo(rs.getLong("CD_TIPO"));
                tipoNovo.setNm_tipo(rs.getString("NM_TIPO"));
                tipoNovo.setDs_exp_regular(rs.getString("DS_TIPO"));

                // adiciona a lista de Tipos os encontrados
                tipos.add(tipoNovo);
            }

            // fecha a instancia dos objetos
            rs.close();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Tipo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            // retorna uma lista com os usuarios selecionados
            return tipos;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Tipo.class.getName() + ": erro na pesquisa referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como null em caso de erro
            return null;
        }

    }

    public boolean adiciona(Tipo tipoAdicionar) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para insercao do registro no banco
            PreparedStatement stmt =
                    this.conn.prepareStatement("insert into APPP_TB_TIPO (CD_TIPO, NM_TIPO, DS_EXP_REGULAR) values( ?, ?, ?)");



            // Seta os valores para os pontos de interrogaï¿½ï¿½o indexados pela ordem deles na string
            stmt.setLong(1, tipoAdicionar.getCd_tipo());
            stmt.setString(2, tipoAdicionar.getNm_tipo());
            stmt.setString(3, tipoAdicionar.getDs_exp_regular());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Tipo.class.getName() + ": insercao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // Retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Tipo.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }
    }

    public boolean deleta(Tipo tipoDeletar) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para remocao do registro no banco
            PreparedStatement stmt = this.conn.prepareStatement("delete from APPP_TB_TIPO where cd_tipo=?");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string
            stmt.setLong(1, tipoDeletar.getCd_tipo());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Tipo.class.getName() + ": remocao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Tipo.class.getName() + ": erro na remocao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }
    }

    public boolean atualiza(Tipo tipoAtualizar) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para atualizacao do registro no banco
            PreparedStatement stmt =
                    this.conn.prepareStatement(
                    "update APPP_TB_TIPO set NM_TIPO=?, DS_EXP_REGULAR=? where CD_TIPO=?");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string

            stmt.setString(1, tipoAtualizar.getNm_tipo());
            stmt.setString(2, tipoAtualizar.getDs_exp_regular());

            stmt.setLong(3, tipoAtualizar.getCd_tipo());
            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Tipo.class.getName() + ": atualizacao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Tipo.class.getName() + ": erro na atualizacao referente a uma excecao de SQL: " + e.getMessage());

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
            GravarLog.gravaErro(TipoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
