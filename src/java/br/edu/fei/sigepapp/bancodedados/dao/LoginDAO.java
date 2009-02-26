package br.edu.fei.sigepapp.bancodedados.dao;

//~--- non-JDK imports --------------------------------------------------------

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Login;
import br.edu.fei.sigepapp.interfaces.DAO;
import br.edu.fei.sigepapp.log.*;

//~--- JDK imports ------------------------------------------------------------

/*
* @(#)LoginDAO.java 0.01 21/02/09
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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Andrey Masiero
 * @version 0.01 21 Fev 2009
 */
public class LoginDAO implements DAO<Login> {
    private Connection conn;

    /**
     * Construtor da classe:- cria uma conex�o com o banco de dados
     * @throws SQLException
     */
    public LoginDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    /**
     * Metodo que adiciona um registro do Objeto Login no banco de dados
     *
     * @see DAO#adiciona(Object) adiciona
     */
    @Override
    public boolean adiciona(Login login) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para insercao do registro no banco
            PreparedStatement stmt =
                this.conn.prepareStatement("insert into appp_tb_login (cd_user, nm_login, pw_senha) values( ?, ?, ?)");

            // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string
            stmt.setLong(1, login.getCd_user());
            stmt.setString(2, login.getNm_login());
            stmt.setString(3, login.getPw_senha());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informacao de sucesso
            GravarLog.gravaInformacao(Login.class.getName() + ": insercao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // Retorno da funcao como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Login.class.getName() + ": erro na insercao referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da funcao como false em caso de erro
            return false;
        }
    }

    /**
     * Metodo responsavel pela atualizacao no banco de dados de um registro do Objeto Login
     *
     * @see DAO#atualiza(Object) atualiza
     */
    @Override
    public boolean atualiza(Login login) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para atualizacao do registro no banco
            PreparedStatement stmt =
                this.conn.prepareStatement("update appp_tb_login set nm_login=?, pw_senha=? where cd_user=?");

            // Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            stmt.setString(1, login.getNm_login());
            stmt.setString(2, login.getPw_senha());
            stmt.setLong(3, login.getCd_user());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Login.class.getName() + ": atualizacao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da fun��o como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Login.class.getName() + ": erro na atualizacao referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da fun��o como false em caso de erro
            return false;
        }
    }

    /**
     * Metodo responsavel por remover do banco de dados um registro do Objeto Login
     *
     * @see DAO#deleta(Object) deleta
     */
    @Override
    public boolean deleta(Login login) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para remocao do registro no banco
            PreparedStatement stmt = this.conn.prepareStatement("delete from appp_tb_login where cod_user=?");

            // Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
            stmt.setLong(1, login.getCd_user());

            // executa o comando e fecha a instancia do objeto
            stmt.execute();
            stmt.close();

            // Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Login.class.getName() + ": remocao no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorno da fun��o como true
            return true;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Login.class.getName() + ": erro na remocao referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da fun��o como false em caso de erro
            return false;
        }
    }

    /**
     * Metodo responsavel pelas pesquisas realizadas no banco de dados com o objeto Login
     *
     * @see DAO#seleciona(String) seleciona
     */
    @Override
    public List<Login> seleciona(String query) {
        try {

            // Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            PreparedStatement stmt = this.conn.prepareStatement(query);

            // Executa a query e armazenando em um Objeto ResultSet
            ResultSet rs = stmt.executeQuery();

            // Cria um array do tipo Usuarios
            List<Login> logins = new ArrayList<Login>();

            // Enquando a pesquisa n�o chegar ao fim ele armazena no array os resultados e permanece no loop
            while (rs.next()) {

                // Cria um objeto do tipo Login
                Login login = new Login();

                // armazena os valores do ResultSet no Usuario
                login.setCd_user(rs.getLong("cd_user"));
                login.setNm_login(rs.getString("nm_login"));
                login.setPw_senha(rs.getString("pw_senha"));

                // adiciona a lista de Logins os encontrados
                logins.add(login);
            }

            // fecha a instancia dos objetos
            rs.close();
            stmt.close();

            // Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Login.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            // Fecha conexao com o banco de dados
            this.conn.close();

            // retorna uma lista com os usuarios selecionados
            return logins;
        } catch (SQLException e) {

            // Grava log com o erro que ocorreu durante a execucao do comando SQL
            GravarLog.gravaErro(Login.class.getName() + ": erro na pesquisa referente a uma excecao de SQL: "
                                + e.getMessage());

            // Retorno da fun��o como null em caso de erro
            return null;
        }
    }
}