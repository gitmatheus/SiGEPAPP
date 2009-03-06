/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.dao.CidadeDAO;
import br.edu.fei.sigepapp.bancodedados.model.Cidade;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class GetCidadeServlet extends HttpServlet{

    protected void doGet(HttpServletRequest request, HttpServletResponse response ) throws IOException{
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        HashMap paramsMap = new HashMap();
        Enumeration paramEnum = request.getParameterNames();

        while(paramEnum.hasMoreElements()){
            String paramName = (String)(paramEnum.nextElement());
            paramsMap.put(paramName, request.getParameter(paramName));
        }

        String pCD_ESTADO = (String)paramsMap.get("cd_estado");

        Cidade cidade = new Cidade();
        cidade.setCd_estado(Long.parseLong(pCD_ESTADO));

        CidadeDAO dao;
        List<Cidade> lcidade = null;

        try{
            dao = new CidadeDAO();
            lcidade = dao.APPP_SEL_CIDADE(cidade);
        }catch(SQLException e){
            GravarLog.gravaErro(GetCidadeServlet.class.getName()+": erro ao intanciar a classe DAO: " + e.getMessage());
        }

        writer.println("<cidade><![CDATA[" + lcidade + "]]></cidade>");

        writer.close();

    }

}
