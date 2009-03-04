package br.edu.fei.sigepapp.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.edu.fei.sigepapp.bancodedados.dao.LoginDAO;
import br.edu.fei.sigepapp.log.GravarLog;

public class ExisteLoginServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private String liberado = new String("nao");

	public ExisteLoginServlet(){
		super();
	}
	
	public String getLiberado() {
		return liberado;
	}

	public void setLiberado(String liberado) {
		this.liberado = liberado;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			LoginDAO dao = new LoginDAO();
			if(!dao.existeLogin(request.getParameter("login"))){
				setLiberado("sim"); 
			}else{
				setLiberado("nao");
			}
			response.setContentType("text/xml");
			PrintWriter out = response.getWriter();
			out.println("<liberado>" + getLiberado() + "</liberado>");
			out.flush();
			out.close();
			dao.fechaConexao();
		}catch(Exception e){
			GravarLog.gravaErro(ExisteLoginServlet.class.getName() + ": erro na verificacao de existencia de um login igual: " + e.getMessage());
		}
	}

}
