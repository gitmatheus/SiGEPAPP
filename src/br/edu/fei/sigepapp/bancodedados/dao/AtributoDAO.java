/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Atributo;
import br.edu.fei.sigepapp.interfaces.DAO;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author lopespt
 */
public class AtributoDAO implements DAO<Atributo> {

    private Connection conn;

    public AtributoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Atributo> seleciona(String query) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            PreparedStatement stmt = this.conn.prepareStatement(query);

            // Executa a query e armazenando em um Objeto ResultSet
            ResultSet rs = stmt.executeQuery();

            // Cria um array do tipo atributo
            List<Atributo> atributos = new ArrayList<Atributo>();

            // Enquando a pesquisa nao chegar ao fim ele armazena no array os resultados e permanece no loop
            while (rs.next()) {

                // Cria um objeto do tipo Atributo
                Atributo atributoNovo = new Atributo(rs.getLong("CD_ATRIBUTO_OBJ"), rs.getString("NM_ATRIBUTO_OBJ"), rs.getString("DS_ATRIBUTO_OBJ"), rs.getString("DS_TAM_ATRIB"), rs.getLong("CD_TIPO"), rs.getString("FL_ATRIB_RELAC"));

                atributos.add(atributoNovo);
            }

            // fecha a instancia dos objetos
            rs.close();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Atributo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorna uma lista com os atributo selecionados
            return atributos;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na pesquisa referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como null em caso de erro
            return null;
        }

    }

    public boolean adiciona(Atributo atributoAdicionar) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para insercao do registro no banco
            PreparedStatement stmt =
                    this.conn.prepareStatement(
                    "insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ, NM_ATRIBUTO_OBJ, DS_ATRIBUTO_OBJ, DS_TAM_ATRIB," + "CD_TIPO, FL_ATRIB_RELAC)" + "values (?, ?, ?, ?, ?, ?)");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string
            stmt.setLong(1, atributoAdicionar.getCd_atributo_obj());
            stmt.setString(2, atributoAdicionar.getNm_atributo_obj());
            stmt.setString(3, atributoAdicionar.getDs_atributo_obj());
            stmt.setString(4, atributoAdicionar.getDs_tam_atrib());
            stmt.setLong(5, atributoAdicionar.getCd_tipo());
            stmt.setString(6, atributoAdicionar.getFl_atrib_relac());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Atributo.class.getName() + ": insercao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // Retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }

    }

    public boolean deleta(Atributo atributoDeletar) {
        try {
            this.conn = ConnectionFactory.getConnection();
            PreparedStatement stmt = conn.prepareStatement("delete from APPP_TB_ATRIBUTO_OBJ where CD_ATRIBUTO_OBJ=?");
            stmt.setLong(1, atributoDeletar.getCd_atributo_obj());
            stmt.execute();
            stmt.close();

            this.conn.close();

            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }
    }

    public boolean atualiza(Atributo atributoAtualizar) {
        try {
            this.conn = ConnectionFactory.getConnection();
            // Instancia um objeto da classe PreparedStatement com o comando para atualizacao do registro no banco
            PreparedStatement stmt =
                    this.conn.prepareStatement(
                    "update APPP_TB_ATRIBUTO_OBJ set NM_ATRIBUTO_OBJ=?, DS_ATRIBUTO_OBJ=?, DS_TAM_ATRIB=?," + "CD_TIPO=?, FL_ATRIB_RELAC=? where CD_ATRIBUTO_OBJ=?");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string

            stmt.setString(1, atributoAtualizar.getNm_atributo_obj());
            stmt.setString(2, atributoAtualizar.getDs_atributo_obj());
            stmt.setString(3, atributoAtualizar.getDs_tam_atrib());
            stmt.setLong(4, atributoAtualizar.getCd_tipo());
            stmt.setString(5, atributoAtualizar.getFl_atrib_relac());

            stmt.setLong(6, atributoAtualizar.getCd_atributo_obj());
            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Atributo.class.getName() + ": atualizacao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na atualizacao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }
    }
}
