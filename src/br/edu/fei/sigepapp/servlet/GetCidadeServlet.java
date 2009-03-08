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
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 */
public class GetCidadeServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response ) throws IOException{
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        Cidade cidade = new Cidade();
        cidade.setCd_cidade(0);
        cidade.setCd_estado(Long.parseLong(request.getParameter("cdestado")));
        cidade.setNm_cidade("");
        cidade.setNm_abrev("");


        CidadeDAO dao;
        List<Cidade> lcidade = null;
        int cont = 0;

        try{
            dao = new CidadeDAO();
            lcidade = dao.APPP_SEL_CIDADE(cidade);
            dao.fechaConexao();
        }catch(SQLException e){
            GravarLog.gravaErro(GetCidadeServlet.class.getName()+": erro ao intanciar a classe DAO: " + e.getMessage());
        }

        writer.println("<cidades>");

        for(Cidade c : lcidade){
            writer.println(
                    "<cd_cidade" + cont + ">" + c.getCd_cidade() + "</cd_cidade" + cont + ">" +
                    "<nm_cidade" + cont + ">" + c.getNm_cidade() + "</nm_cidade" + cont + ">"
                    );
            cont++;
        }
        writer.println("<nro_cidades>" + lcidade.size() + "</nro_cidades>");
        writer.println("</cidades>");

        writer.close();

    }

}
