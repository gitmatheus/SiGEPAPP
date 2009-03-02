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
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * |   Andrey    | 21/02/09    | Cria��o e elabora��o inicial         |
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

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Telefone;
import br.edu.fei.sigepapp.log.GravarLog;

/**
 * 
 * @author Andrey Masiero
 * @version 0.01 21 Fev 2009
 *
 */
public class TelefoneDAO{
	
	private Connection conn;
	
	/**
	 * Construtor da classe:- cria uma conex�o com o banco de dados
	 * @throws SQLException
	 */
	public TelefoneDAO() throws SQLException{
		this.conn = ConnectionFactory.getConnection();
	}
	
	/**
	 * Metodo que adiciona um registro do Objeto Telefone no banco de dados
	 * 
	 * @see DAO#adiciona(Object) adiciona	
	 */
	public boolean adiciona(Telefone telefone) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para inser��o do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("insert into appp_tb_user_telefone (cd_user, nr_ddi, nr_ddd," +
					" nr_telefone, tp_telefone) values( ?, ?, ?, ?, ?)");
			
			//Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
			stmt.setLong(1, telefone.getCd_user());
			stmt.setLong(2, telefone.getNr_ddi());
			stmt.setLong(3, telefone.getNr_ddd());
			stmt.setLong(4, telefone.getNr_telefone());
			stmt.setString(5, telefone.getTp_telefone());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();
			
			//Grava log com a informa��o de sucesso
			GravarLog.gravaInformacao(Telefone.class.getName() + ": inser��o no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//Retorno da fun��o como true
			return true;
			
		}catch (SQLException e){
			
			//Grava log com o erro que ocorreu durante a execu��o do comando SQL
			GravarLog.gravaErro(Telefone.class.getName() + ": erro na inser��o referente a uma exce��o de SQL: " + e.getMessage());
			
			//Retorno da fun��o como false em caso de erro
			return false;
		}
	}

	/**
	 * Metodo responsavel pela atualizacao no banco de dados de um registro do Objeto Telefone
	 * 
	 * @see DAO#atualiza(Object) atualiza
	 */
	public boolean atualiza(Telefone telefone) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para atualiza��o do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("update appp_tb_user_telefone set nr_ddi=?, nr_ddd=?, nr_telefone=?," +
					"tp_telefone=? where cd_user=?)");
			
			//Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
			stmt.setLong(1, telefone.getNr_ddi());
			stmt.setLong(2, telefone.getNr_ddd());
			stmt.setLong(3, telefone.getNr_telefone());
			stmt.setString(4, telefone.getTp_telefone());
			stmt.setLong(5, telefone.getCd_user());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();
			
			//Grava log com a informa��o de sucesso
			GravarLog.gravaInformacao(Telefone.class.getName() + ": atualiza��o no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorno da fun��o como true
			return true;
			
		}catch(SQLException e){
			
			//Grava log com o erro que ocorreu durante a execu��o do comando SQL
			GravarLog.gravaErro(Telefone.class.getName() + ": erro na atualiza��o referente a uma exce��o de SQL: " + e.getMessage());
			
			//Retorno da fun��o como false em caso de erro
			return false;
		}
	}

	/**
	 * Metodo responsavel por remover do banco de dados um registro do Objeto Telefone
	 * 
	 * @see DAO#deleta(Object) deleta
	 */
	public boolean deleta(Telefone telefone) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para remo��o do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("delete from appp_tb_user_telefone where cod_user=?");
			
			//Seta os valores para os pontos de interroga��o indexados pela ordem deles na string
			stmt.setLong(1, telefone.getCd_user());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();

			//Grava log com a informa��o de sucesso
			GravarLog.gravaInformacao(Telefone.class.getName() + ": remo��o no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorno da fun��o como true
			return true;
			
		}catch(SQLException e){

			//Grava log com o erro que ocorreu durante a execu��o do comando SQL
			GravarLog.gravaErro(Telefone.class.getName() + ": erro na remo��o referente a uma exce��o de SQL: " + e.getMessage());			
			
			//Retorno da fun��o como false em caso de erro
			return false;	
		}
	}

	/**
	 * Metodo responsavel pelas pesquisas realizadas no banco de dados com o objeto Telefone
	 * 
	 * @see DAO#seleciona(String) seleciona
	 */
	public List<Telefone> seleciona(String query) {
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
			PreparedStatement stmt = this.conn.prepareStatement(query);
			
			//Executa a query e armazenando em um Objeto ResultSet
			ResultSet rs = stmt.executeQuery();
			
			//Cria um array do tipo Usuarios
			List<Telefone> telefones = new ArrayList<Telefone>();
			
			//Enquando a pesquisa n�o chegar ao fim ele armazena no array os resultados e permanece no loop
			while(rs.next()){
				//Cria um objeto do tipo Telefone
				Telefone telefone = new Telefone();

				//armazena os valores do ResultSet no Usuario
				telefone.setCd_user(rs.getLong("cd_user"));
				telefone.setNr_ddi(rs.getLong("nr_ddi"));
				telefone.setNr_ddd(rs.getLong("nr_ddd"));
				telefone.setNr_telefone(rs.getLong("nr_telefone"));
				telefone.setTp_telefone(rs.getString("tp_telefone"));
				
				//adiciona a lista de Telefones os encontrados
				telefones.add(telefone);
			}
			
			//fecha a instancia dos objetos
			rs.close();
			stmt.close();

			//Grava log com a informa��o de sucesso
			GravarLog.gravaInformacao(Telefone.class.getName() + ": pesquisa no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorna uma lista com os usuarios selecionados
			return telefones;
			
		}catch(SQLException e){

			//Grava log com o erro que ocorreu durante a execu��o do comando SQL
			GravarLog.gravaErro(Telefone.class.getName() + ": erro na pesquisa referente a uma exce��o de SQL: " + e.getMessage());			
			
			//Retorno da fun��o como null em caso de erro
			return null;
		}
	}

}
