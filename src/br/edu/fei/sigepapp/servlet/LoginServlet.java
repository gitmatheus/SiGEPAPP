package br.edu.fei.sigepapp.servlet;

/**
 * @(#)LoginServlet.java 0.04 09/02/28
 * 
 * Copyright (c) 2009 Equipe SiGePAPP
 * 
 * Este código é parte integrante do projeto de formatura,
 * do curso de ciências da computação, do Centro Universitário da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 * 
 * 
 * 
 * 
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * |   Andrey    |   16/02/09  |   Criação do programa.               |
 * |------------------------------------------------------------------|
 * |   Andrey    |   23/02/09  |   Implementação da função para login |
 * |             |             | utilizando ajax.                     |
 * |------------------------------------------------------------------|
 * |   Andrey    |  25/02/09   |   Adequação da classe para efetuar o |
 * |             |             | Login e o Logout                     |
 * |------------------------------------------------------------------|
 * |   Andrey    |  28/02/09   |   Tratamento de excecao para quando o|
 * |             |             | banco de dados estiver inativo       |
 * |------------------------------------------------------------------|
 * 
 */

/** Import dos packages necessários para o funcionamento da classe */
import java.io.IOException;
import java.io.PrintWriter;
//import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.servlet.http.HttpSession;

import br.edu.fei.sigepapp.bancodedados.dao.LoginDAO;
//import br.edu.fei.sigepapp.bancodedados.dao.UsuarioDAO;
import br.edu.fei.sigepapp.bancodedados.model.Usuario;
import br.edu.fei.sigepapp.log.GravarLog;

/**
 * Classe reponsavel pela validação do login dos usuarios do sistema
 * 
 * @version 0.04 28 Fev 2009
 * @author Andrey Masiero
 * 
 */

public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	/**  
	 *  Atributo que passa o nome do usuario para a pagina. 
	 */
	private String user;
	private long cod_user;
	
	/** Metodos getters and setters */
	public void setUser(String user) {
		this.user = user;
	}

	public String getUser() {
		return user;
	}

	public Long getCod_user() {
		return cod_user;
	}

	public void setCod_user(long cod_user) {
		this.cod_user = cod_user;
	}

	/**
	 * Construtor da classe
	 * Chama o construtor da superclasse()
	 * 
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet(){
		super();
	}
	
	/**
	 * Metodo responsavel pelo tratamento do metodo get pertencente ao http
	 * 
	 * @see HttpServelt#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
	}

	/**
	 * Metodo responsavel pelo tratamento do metodo post pertencente ao http
	 * 
	 * @see HttpServelt#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		try {
			LoginDAO dao = new LoginDAO();
			List<Usuario> user_list = dao.validaLogin(request.getParameter("usuario"), request.getParameter("senha"));
			if (user_list.size() == 1){
				setCod_user(user_list.get(0).getCd_user());
				setUser(user_list.get(0).getNm_prim_nome() + " " + user_list.get(0).getNm_ult_nome());
			}else{
				setCod_user(0);
				setUser("");
			}
		} catch (Exception e) {
			GravarLog.gravaErro(LoginServlet.class.getName() + ": erro na validação do login: " + e.getMessage() +" : "+ e.getCause() +" : "+ e.getStackTrace());
		}
		
		System.out.println(getUser());
		
		if (request.getParameter("logoff").equals("") && getCod_user() != 0 && getCod_user() != null){
			HttpSession sessao = request.getSession(); // Nao cria a sessao
			sessao.setAttribute("usuario", getUser()); // Seta o nome do usuario na sessao
			sessao.setAttribute("codigo_usuario", getCod_user());
		}else if (request.getParameter("logoff").equals("logoff") || getCod_user() == 0){ // Se houver solicitacao
			HttpSession sessao = request.getSession(); // Pega a sessao
			sessao.invalidate(); // Mata a sessao
			setUser("");
			setCod_user(0);
		}
		
		response.setContentType("text/xml"); // informa o tipo de resposta que será gerada pela servlet, no caso arquivo xml
		PrintWriter out = response.getWriter(); // Inicia a gravacao do arquivo xml
		out.println("<login><codigo>" + getCod_user() + "</codigo><usuario>"+ getUser() +"</usuario></login>"); //conteudo do arquivo
		out.flush(); // atualiza o conteudo do arquivo
		out.close(); // fecha o arquivo
		 
		/** Atributos auxiliares 
		String cfm = new String();
		String strNome = new String();

		try {
			// Retorna o usuario encontrado no cadastro do banco. Retorna null se nao for encontrado.
			strNome = retornaUsuario(request.getParameter("usuario"), request.getParameter("senha"));
		} catch (SQLException e) {
			// Grava log de erro no sistema.
			GravarLog.gravaErro(LoginServlet.class.getName() + "erro de SQL ao efetuar login no sistema: " + e.getMessage());
		}
		// Verifica se o nome e null para acionar o flag de confirmacao para a funcao ajax
		if (strNome.equals("")){
			cfm = "0"; // Flag desligado
		}else{
			cfm = "1"; // Flag ligado
		}
		
		// Verifica se existe a solicitacao de logoff
		if (request.getParameter("logoff").equals("")){
			HttpSession sessao = request.getSession(); // Nao cria a sessao
			sessao.setAttribute("usuario", strNome); // Seta o nome do usuario na sessao
		}else if (request.getParameter("logoff").equals("logoff") || cfm.equals("0")){ // Se houver solicitacao
			HttpSession sessao = request.getSession(); // Pega a sessao
			sessao.invalidate(); // Mata a sessao
		}
		
		response.setContentType("text/xml"); // informa o tipo de resposta que será gerada pela servlet, no caso arquivo xml
		PrintWriter out = response.getWriter(); // Inicia a gravacao do arquivo xml
		out.println("<login><usuario>" + strNome + "</usuario><confirma>"+ cfm +"</confirma></login>"); //conteudo do arquivo
		out.flush(); // atualiza o conteudo do arquivo
		out.close(); // fecha o arquivo
		*/
	}
	
	/**
	 * Metodo de busca de usuario e verificacao do login no sistema
	 * 
	 * @param login
	 * @param senha
	 * @return O usuario encontrado do sistema ou nulo caso nao encontre o usuario
	 * @throws SQLException
	 
	private String retornaUsuario(String login, String senha) throws SQLException{
		try{
			//Cria um objeto dao da classe usuario
			UsuarioDAO dao = new UsuarioDAO();
		
	
		// Cria um lista de registros encontrados, neste caso nao pode ser maior do que 1 por se tratar do login
		List<Usuario> user_list = dao.seleciona(login,senha);
		
			//Verifica se o tamanho da lista é realmente 1
			if(user_list.size() == 1){
				this.setUser(user_list.get(0).getNm_prim_nome() + " " + user_list.get(0).getNm_ult_nome()); // Caso positivo retorna os Nome e Ultimo Nome do usuario
			}else{
				this.setUser(""); // Caso contrario retorna vazio
			}
		
			return this.getUser(); // Retorna o valor de usuario
		}catch(Exception e){
			this.setUser("");
			GravarLog.gravaErro(LoginServlet.class.getName() + ": erro de consulta no sql: " + e.getMessage());
			return this.getUser();
		}
	}*/
}
	
