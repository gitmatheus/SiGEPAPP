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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//~-- SIGEPAPP import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Email;
import br.edu.fei.sigepapp.interfaces.DAO;
import br.edu.fei.sigepapp.log.GravarLog;

/**
 * 
 * @author Andrey Masiero
 * @version 0.01 21 Fev 2009
 */
public class EmailDAO implements DAO<Email> {
	
private Connection conn;
	
	/**
	 * Construtor da classe:- cria uma conexão com o banco de dados
	 * @throws SQLException
	 */
	public EmailDAO() throws SQLException{
		this.conn = ConnectionFactory.getConnection();
	}

	/**
	 * Metodo que adiciona um registro do Objeto Email no banco de dados
	 * 
	 * @see DAO#adiciona(Object) adiciona	
	 */
	@Override
	public boolean adiciona(Email email) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("insert into appp_tb_user_email (cd_user, nm_email, tp_email) values( ?, ?, ?)");
			
			//Seta os valores para os pontos de interrogação indexados pela ordem deles na string
			stmt.setLong(1, email.getCd_user());
			stmt.setString(2, email.getNm_email());
			stmt.setString(3, email.getTp_email());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();
			
			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Email.class.getName() + ": inserção no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//Retorno da função como true
			return true;
			
		}catch (SQLException e){
			
			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Email.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());
			
			//Retorno da função como false em caso de erro
			return false;
		}
	}

	/**
	 * Metodo responsavel pela atualizacao no banco de dados de um registro do Objeto Email
	 * 
	 * @see DAO#atualiza(Object) atualiza
	 */
	@Override
	public boolean atualiza(Email email) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para atualização do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("update appp_tb_user_email set nm_email=?, tp_email=? where cd_user=?)");
			
			//Seta os valores para os pontos de interrogação indexados pela ordem deles na string
			stmt.setString(1, email.getNm_email());
			stmt.setString(2, email.getTp_email());
			stmt.setLong(3, email.getCd_user());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();
			
			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Email.class.getName() + ": atualização no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorno da função como true
			return true;
			
		}catch(SQLException e){
			
			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Email.class.getName() + ": erro na atualização referente a uma exceção de SQL: " + e.getMessage());
			
			//Retorno da função como false em caso de erro
			return false;
			
		}
	}

	/**
	 * Metodo responsavel por remover do banco de dados um registro do Objeto Email
	 * 
	 * @see DAO#deleta(Object) deleta
	 */
	@Override
	public boolean deleta(Email email) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para remoção do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("delete from appp_tb_user_email where cod_user=?");
			
			//Seta os valores para os pontos de interrogação indexados pela ordem deles na string
			stmt.setLong(1, email.getCd_user());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();

			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Email.class.getName() + ": remoção no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorno da função como true
			return true;
			
		}catch(SQLException e){

			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Email.class.getName() + ": erro na remoção referente a uma exceção de SQL: " + e.getMessage());			
			
			//Retorno da função como false em caso de erro
			return false;	
		}
	}

	/**
	 * Metodo responsavel pelas pesquisas realizadas no banco de dados com o objeto Email
	 * 
	 * @see DAO#seleciona(String) seleciona
	 */
	@Override
	public List<Email> seleciona(String query) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
			PreparedStatement stmt = this.conn.prepareStatement(query);
			
			//Executa a query e armazenando em um Objeto ResultSet
			ResultSet rs = stmt.executeQuery();
			
			//Cria um array do tipo Usuarios
			List<Email> emails = new ArrayList<Email>();
			
			//Enquando a pesquisa não chegar ao fim ele armazena no array os resultados e permanece no loop
			while(rs.next()){
				//Cria um objeto do tipo Email
				Email email = new Email();

				//armazena os valores do ResultSet no Usuario
				email.setCd_user(rs.getLong("cd_user"));
				email.setNm_email(rs.getString("nm_email"));
				email.setTp_email(rs.getString("tp_email"));
				
				//adiciona a lista de Emails os encontrados
				emails.add(email);
			}
			
			//fecha a instancia dos objetos
			rs.close();
			stmt.close();

			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Email.class.getName() + ": pesquisa no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorna uma lista com os usuarios selecionados
			return emails;
			
		}catch(SQLException e){

			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Email.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());			
			
			//Retorno da função como null em caso de erro
			return null;
		}
	}

}
