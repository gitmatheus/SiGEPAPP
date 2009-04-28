package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.model.Pattern;
import br.edu.fei.sigepapp.bancodedados.dao.PatternDAO;
import br.edu.fei.sigepapp.log.GravarLog;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 * @version 0.01 Mar 11, 2009
 */
public class CadPatternServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        boolean inserido = false;
        boolean erro = false;
        boolean cadastrado = false;

        Pattern pattern = new Pattern();

        /*while(request.getParameterNames().hasMoreElements()){
            request.getParameterNames().nextElement().toString()
        }*/


        pattern.setCd_Estrutura(1);
        //pattern.setCd_User_Criador(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()));
        pattern.setCd_User_Criador(Long.parseLong("30150215835"));
        pattern.setDs_Objeto(request.getParameter("frmCadAPPPDescricaoPA"));
        pattern.setDs_Pat_problema(request.getParameter("frmCadAPPPProblemaPA"));
        pattern.setDs_Pat_solucao(request.getParameter("frmCadAPPPSolucaoPA"));
        pattern.setNm_Objeto(request.getParameter("frmCadAPPPNomePA"));
        
        try {
            PatternDAO patternDao = new PatternDAO();
            long c = patternDao.APPP_CREATE_PATTERN(pattern);

            if (c <= 0) {
                GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no cadastro do Código Postal");
                erro = true;
                inserido = !erro;
                cadastrado = !erro;
            }
            else{
                erro = false;
                inserido = !erro;

            }

            patternDao.fechaConexao();


        } catch (Exception e) {
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro durante o cadastro do usuario: " + e.getMessage());
        }

        if (inserido) {
            writer.println("<sucesso>inserido</sucesso>");
        } else
        {
              response.sendRedirect("frmCadAPPP.jsp?msg=Cadastrado%20Com%20Sucesso");
         }
        

        writer.flush();
        writer.close();
    }
}
