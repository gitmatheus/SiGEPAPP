package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)UsuarioDAO.java 0.01 20/02/09
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
 * | Andrey      | 20/02/09    | Criação e elaboração inicial         |
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
import br.edu.fei.sigepapp.bancodedados.model.Usuario;
import br.edu.fei.sigepapp.interfaces.DAO;
import br.edu.fei.sigepapp.log.*;
import java.sql.CallableStatement;
import java.util.Date;
import oracle.jdbc.OracleTypes;


/**
 * 
 * Classe responsavel por acessar o banco de dados através do modelo Usuario
 * 
 * @author Andrey Masiero
 * @version 0.01 20 Fev 2009
 */
public class UsuarioDAO implements DAO<Usuario>{
	
	private Connection conn;
	
	/**
	 * Contrutor da classe:- cria uma conexão com o banco de dados
	 * 
	 * @throws SQLException
	 */
	public UsuarioDAO() throws SQLException{
		this.conn = ConnectionFactory.getConnection();
	}
	
	/**
	 * Metodo que adiciona um registro do Objeto Usuario no banco de dados
	 * 
	 * @see DAO#adiciona(Object) adiciona
	 */
	@Override
	public boolean adiciona(Usuario usuario){
        int vResult = 0;
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("APPP_INS_USER(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

			//Seta os valores para os pontos de interrogação indexados pela ordem deles na string
			stmt.setLong(1, usuario.getCd_user());
			stmt.setString(2, usuario.getNm_prim_nome());
			stmt.setString(3, usuario.getNm_ult_nome());
			stmt.setDate(4, usuario.getDt_nasc());
			stmt.setDouble(5, usuario.getNr_nota());
			stmt.setDate(6, usuario.getDt_cadastro());
			stmt.setString(7, usuario.getDs_area_interesse());
			stmt.setString(8, usuario.getNm_msn());
			stmt.setString(9, usuario.getNm_skype());
            stmt.setInt(10, vResult);
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();
			
			//Grava log com a informação de sucesso
            if(vResult==1)
			   GravarLog.gravaInformacao(Usuario.class.getName() + ": inserção no banco de dados realizada com sucesso");

            if(vResult==-99)
			  GravarLog.gravaInformacao(Usuario.class.getName() + ": erro ao cadastrar novo usuário.");
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//Retorno da função como true
			return true;
		
		}catch (SQLException e){
		
			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Usuario.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());
			
			//Retorno da função como false em caso de erro
			return false;			
		}
	}

	/**
	 * Metodo responsavel pela atualizacao no banco de dados de um registro do Objeto Usuario
	 * 
	 * @see DAO#atualiza(Object) atualiza
	 */
	@Override
	public boolean atualiza(Usuario usuario){
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para atualização do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("update appp_tb_user set nm_prim_nome=?," +
				"nm_ult_nome=?, dt_nasc=?, nr_nota=?, dt_cadastro=?, ds_area_interesse=?, nm_msn=?, nm_skype=? " +
				"where cd_user=?");
			
			//Seta os valores para os pontos de interrogação indexados pela ordem deles na string
			stmt.setString(1, usuario.getNm_prim_nome());
			stmt.setString(2, usuario.getNm_ult_nome());
			stmt.setDate(3, usuario.getDt_nasc());
			stmt.setDouble(4, usuario.getNr_nota());
			stmt.setDate(5, usuario.getDt_cadastro());
			stmt.setString(6, usuario.getDs_area_interesse());
			stmt.setString(7, usuario.getNm_msn());
			stmt.setString(8, usuario.getNm_skype());
			stmt.setLong(9, usuario.getCd_user());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();
			
			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Usuario.class.getName() + ": atualização no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorno da função como true
			return true;
			
		}catch (SQLException e){
			
			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Usuario.class.getName() + ": erro na atualização referente a uma exceção de SQL: " + e.getMessage());
			
			//Retorno da função como false em caso de erro
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
		try{
			//Instancia um objeto da classe PreparedStatement com o comando para remoção do registro no banco
			PreparedStatement stmt = this.conn.prepareStatement("delete from appp_tb_user where cod_user=?");
			
			//Seta os valores para os pontos de interrogação indexados pela ordem deles na string
			stmt.setLong(1, usuario.getCd_user());
			
			//executa o comando e fecha a instancia do objeto
			stmt.execute();
			stmt.close();

			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Usuario.class.getName() + ": remoção no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorno da função como true
			return true;
			
		}catch(SQLException e){

			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Usuario.class.getName() + ": erro na remoção referente a uma exceção de SQL: " + e.getMessage());			
			
			//Retorno da função como false em caso de erro
			return false;	
		}
	}

	/**
	 * Metodo responsavel pelas pesquisas realizadas no banco de dados com o objeto Usuario
	 * 
	 * @see DAO#seleciona(String) seleciona
	 */
	public List<Usuario> seleciona(String pLogin, String pSenha) {
		CallableStatement cstmt = null;
        ResultSet rs = null;
        try{
			//Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
			//PreparedStatement stmt = this.conn.prepareStatement(query);
            cstmt = conn.prepareCall("begin  APPP_SEL_LOGIN(?, ?, ?); end;");
			cstmt.setString(1, pLogin);
            cstmt.setString(2, pSenha);
            cstmt.registerOutParameter(3, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(3);
			
			//Cria um array do tipo Usuarios
			List<Usuario> usuarios = new ArrayList<Usuario>();
			
			
			//Enquando a pesquisa não chegar ao fim ele armazena no array os resultados e permanece no loop
			while(rs.next()){
				
				//Cria um objeto do tipo Usuario
				Usuario usuario = new Usuario();
				

				//armazena os valores do ResultSet no Usuario
				usuario.setCd_user(rs.getLong("cd_user"));
				usuario.setNm_prim_nome(rs.getString("nm_prim_nome"));
				usuario.setNm_ult_nome(rs.getString("nm_ult_nome"));
				usuario.setDt_nasc(rs.getDate("dt_nasc"));
				usuario.setNr_nota(rs.getDouble("nr_nota"));
				usuario.setDt_cadastro(rs.getDate("dt_cadastro"));
				usuario.setDs_area_interesse(rs.getString("ds_area_interesse"));
				usuario.setNm_msn(rs.getString("nm_msn"));
				usuario.setNm_skype(rs.getString("nm_skype"));
				
				//adiciona a lista de Usuarios encontrados
				usuarios.add(usuario);
			}
			
			//fecha a instancia dos objetos
			rs.close();
			cstmt.close();
			
			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Usuario.class.getName() + ": pesquisa no banco de dados realizada com sucesso");
			
			//Fecha conexao com o banco de dados
			this.conn.close();
			
			//retorna uma lista com os usuarios selecionados
			return usuarios;
			
		}catch (SQLException e){
			
			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Usuario.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());			
			
			//Retorno da função como null em caso de erro
			return null;
		}
	}
   public List<Usuario> selecionaUsers(long pCDUser, String pPrimNome, String pUltNome, Date pDtNascIni, Date pDtNascFim, long pNrNotaIni, long pNrNotaFim, Date pDtCadastroIni, Date pDtCadastroFim, String pDSInteresse, String pMSN, String pSkype) {
		CallableStatement cstmt = null;
        ResultSet rs = null;
        try{
			//Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
			//PreparedStatement stmt = this.conn.prepareStatement(query);
            cstmt = conn.prepareCall("begin  APPP_SEL_USERS(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); end;");
			cstmt.setLong(1, pCDUser);
            cstmt.setString(2, pPrimNome);
            cstmt.setString(3, pUltNome);
            cstmt.setDate(4,(java.sql.Date) pDtNascIni);
            cstmt.setDate(5,(java.sql.Date) pDtNascFim);
            cstmt.setLong(6, pNrNotaIni);
            cstmt.setLong(7, pNrNotaFim);
            cstmt.setDate(8,(java.sql.Date) pDtCadastroIni);
            cstmt.setDate(9,(java.sql.Date) pDtCadastroFim);
            cstmt.setString(10, pDSInteresse);
            cstmt.setString(11, pMSN);
            cstmt.setString(12, pSkype);
            cstmt.registerOutParameter(13, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(13);

			//Cria um array do tipo Usuarios
			List<Usuario> usuarios = new ArrayList<Usuario>();


			//Enquando a pesquisa não chegar ao fim ele armazena no array os resultados e permanece no loop
			while(rs.next()){

				//Cria um objeto do tipo Usuario
				Usuario usuario = new Usuario();


				//armazena os valores do ResultSet no Usuario
				usuario.setCd_user(rs.getLong("cd_user"));
				usuario.setNm_prim_nome(rs.getString("nm_prim_nome"));
				usuario.setNm_ult_nome(rs.getString("nm_ult_nome"));
				usuario.setDt_nasc(rs.getDate("dt_nasc"));
				usuario.setNr_nota(rs.getDouble("nr_nota"));
				usuario.setDt_cadastro(rs.getDate("dt_cadastro"));
				usuario.setDs_area_interesse(rs.getString("ds_area_interesse"));
				usuario.setNm_msn(rs.getString("nm_msn"));
				usuario.setNm_skype(rs.getString("nm_skype"));

				//adiciona a lista de Usuarios encontrados
				usuarios.add(usuario);
			}

			//fecha a instancia dos objetos
			rs.close();
			cstmt.close();

			//Grava log com a informação de sucesso
			GravarLog.gravaInformacao(Usuario.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

			//Fecha conexao com o banco de dados
			this.conn.close();

			//retorna uma lista com os usuarios selecionados
			return usuarios;

		}catch (SQLException e){

			//Grava log com o erro que ocorreu durante a execução do comando SQL
			GravarLog.gravaErro(Usuario.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

			//Retorno da função como null em caso de erro
			return null;
		}
	}
    public List<Usuario> seleciona(String query) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}
