package br.edu.fei.sigepapp.servlet;

/**
 * @(#)LoginServlet.java 0.01 09/02/16
 * 
 * Copyright (c) 2009 Equipe SiGePAPP
 * 
 * Este c�digo � parte integrante do projeto de formatura,
 * do curso de ci�ncias da computa��o, do Centro Universit�rio da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 * 
 * 
 * 
 * 
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * |   Andrey    |   16/02/09  |   Cria��o do programa.               |
 * |------------------------------------------------------------------|
 * 
 */

/** Import dos packages necess�rios para o funcionamento da classe */
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Classe reponsav�l pela valida��o do login dos usu�rios do sistema
 * 
 * @version 0.01 16 Fev 2009
 * @author Andrey Masiero
 * 
 */

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	/** Atributo url que indica o caminho da pagina que ser� direcionada a pagina ap�s valida��o. 
	 *  Por default passarei o erro como 1, dizendo que ocorreu um erro na validacao do login. 
	 */
	private String url;
	
	/** Metodos getters and setters */
	public String getUrl() {
		return url;
		
	}

	public void setUrl(String url) {
		this.url = url;
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
		processRequest(request, response);
	}

	/**
	 * Metodo responsavel pelo tratamento do metodo post pertencente ao http
	 * 
	 * @see HttpServelt#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		processRequest(request, response);
	}
	
	/**
	 * Metodo responsavel pela validacao do login e senha do usuario
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * 
	 */
	private void processRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		
		setUrl("index.jsp?e=1");
		
		if(request.getParameter("acao").equals("login")){
			if(request.getParameter("usuario").equals("admin")){
				if(request.getParameter("senha").equals("admin")){
					HttpSession sessao = request.getSession();
					sessao.setAttribute("login", request.getParameter("login"));
					setUrl("index.jsp?e=0");
				}
			}
		}else if(request.getParameter("acao").equals("logout")){
			HttpSession sessao = request.getSession();
			sessao.invalidate();
			setUrl("index.jsp");
		}
		
		response.sendRedirect(getUrl());
	}
}

