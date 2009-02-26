package br.edu.fei.sigepapp.bancodedados.dao;

//~--- non-JDK imports --------------------------------------------------------

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Usuario;
import br.edu.fei.sigepapp.interfaces.DAO;
import br.edu.fei.sigepapp.log.*;

//~--- JDK imports ------------------------------------------------------------

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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * Classe responsavel por acessar o banco de dados atrav�s do modelo Usuario
 *
 * @author Andrey Masiero
 * @version 0.01 20 Fev 2009
 */
public class UsuarioDAO implements DAO<Usuario> {
    private Connection conn;

    /**
     * Contrutor da classe:- cria uma conex�o com o banco de dados
     *
     * @throws SQLException
     */
    public UsuarioDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    /**
     * Metodo que adiciona um registro do Objeto Usuario no banco de dados
     *
     * @see DAO#adiciona(Object) adiciona
     */
    @Override
    public boolean adiciona(Usuario usuario) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para insercao do registro no banco
            PreparedStatement stmt =
                this.conn.prepareStatement(
                    "insert into appp_tb_user (cd_user, nm_prim_nome,"
                    + "nm_ult_nome, dt_nasc, nr_nota, dt_cadastro, ds_area_interesse, nm_msn, nm_skype) "
                    + "values (?, ?, ?, ?, ?, ?, ?, ?, ?)");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string
            stmt.setLong(1, usuario.getCd_user());
            stmt.setString(2, usuario.getNm_prim_nome());
            stmt.setString(3, usuario.getNm_ult_nome());
            stmt.setDate(4, usuario.getDt_nasc());
            stmt.setDouble(5, usuario.getNr_nota());
            stmt.setDate(6, usuario.getDt_cadastro());
            stmt.setString(7, usuario.getDs_area_interesse());
            stmt.setString(8, usuario.getNm_msn());
            stmt.setString(9, usuario.getNm_skype());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Usuario.class.getName() + ": insercao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // Retorno da fun��o como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Usuario.class.getName() + ": erro na insercao referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da fun��o como false em caso de erro
            return false;
        }
    }

    /**
     * Metodo responsavel pela atualizacao no banco de dados de um registro do Objeto Usuario
     *
     * @see DAO#atualiza(Object) atualiza
     */
    @Override
    public boolean atualiza(Usuario usuario) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para atualizacao do registro no banco
            PreparedStatement stmt =
                this.conn.prepareStatement(
                    "update appp_tb_user set nm_prim_nome=?,"
                    + "nm_ult_nome=?, dt_nasc=?, nr_nota=?, dt_cadastro=?, ds_area_interesse=?, nm_msn=?, nm_skype=? "
                    + "where cd_user=?");

            // Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            stmt.setString(1, usuario.getNm_prim_nome());
            stmt.setString(2, usuario.getNm_ult_nome());
            stmt.setDate(3, usuario.getDt_nasc());
            stmt.setDouble(4, usuario.getNr_nota());
            stmt.setDate(5, usuario.getDt_cadastro());
            stmt.setString(6, usuario.getDs_area_interesse());
            stmt.setString(7, usuario.getNm_msn());
            stmt.setString(8, usuario.getNm_skype());
            stmt.setLong(9, usuario.getCd_user());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Usuario.class.getName()
                                      + ": atualizacao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da fun��o como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Usuario.class.getName()
                                + ": erro na atualizacao referente a uma excecao de SQL: " + e.getMessage());

            // Retorno da fun��o como false em caso de erro
            return false;
        }
    }

    /**
     * Metodo responsavel por remover do banco de dados um registro do Objeto Usuario
     *
     * @see DAO#deleta(Object) deleta
     */
    @Override
    public boolean deleta(Usuario usuario) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para remocao do registro no banco
            PreparedStatement stmt = this.conn.prepareStatement("delete from appp_tb_user where cod_user=?");

            // Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            stmt.setLong(1, usuario.getCd_user());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Usuario.class.getName()
                                      + ": remocao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da fun��o como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Usuario.class.getName() + ": erro na remocao referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da fun��o como false em caso de erro
            return false;
        }
    }

    /**
     * Metodo responsavel pelas pesquisas realizadas no banco de dados com o objeto Usuario
     *
     * @see DAO#seleciona(String) seleciona
     */
    @Override
    public List<Usuario> seleciona(String query) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            PreparedStatement stmt = this.conn.prepareStatement(query);

            // Executa a query e armazenando em um Objeto ResultSet
            ResultSet rs = stmt.executeQuery();

            // Cria um array do tipo Usuarios
            List<Usuario> usuarios = new ArrayList<Usuario>();

            // Enquando a pesquisa n�o chegar ao fim ele armazena no array os resultados e permanece no loop
            while (rs.next()) {

                // Cria um objeto do tipo Usuario
                Usuario usuario = new Usuario();

                // armazena os valores do ResultSet no Usuario
                usuario.setCd_user(rs.getLong("CD_USER"));
                usuario.setNm_prim_nome(rs.getString("NM_PRIM_NOME"));
                usuario.setNm_ult_nome(rs.getString("NM_ULT_NOME"));
                usuario.setDt_nasc(rs.getDate("DT_NASC"));
                usuario.setNr_nota(rs.getDouble("NR_NOTA"));
                usuario.setDt_cadastro(rs.getDate("DT_CADASTRO"));
                usuario.setDs_area_interesse(rs.getString("DS_AREA_INTERESSE"));
                usuario.setNm_msn(rs.getString("NM_MSN"));
                usuario.setNm_skype(rs.getString("NM_SKYPE"));

                // adiciona a lista de Usuarios encontrados
                usuarios.add(usuario);
            }

            // fecha a instancia dos objetos
            rs.close();
            stmt.close();

            // Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Usuario.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorna uma lista com os usuarios selecionados
            return usuarios;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Usuario.class.getName() + ": erro na pesquisa referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da fun��o como null em caso de erro
            return null;
        }
    }
}


//~ Formatted by Jindent --- http://www.jindent.com
