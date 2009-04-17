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

        pattern.setCd_Estrutura(Long.parseLong(request.getParameter("cd_Estrutura")));
        // CHECAR COMO OBTER O CODIGO DE USUARIO
        pattern.setCd_User_Criador(Long.parseLong("30150215835")); 
        pattern.setDs_Objeto(request.getParameter("ds_Objeto"));
        pattern.setDs_Pat_problema(request.getParameter("ds_Pat_problema"));
        pattern.setDs_Pat_solucao(request.getParameter("ds_Pat_solucao"));
        pattern.setNm_Objeto(request.getParameter("nm_Objeto"));
        
        try {
            PatternDAO patternDao = new PatternDAO();
            long c = patternDao.APPP_CREATE_PATTERN(pattern);
            
            if (c <= 0) {
                GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no cadastro do Código Postal");
                erro = true;
                inserido = !erro;
                cadastrado = !erro;
            }
            patternDao.fechaConexao();
            
            
        } catch (Exception e) {
            GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro durante o cadastro do usuario: " + e.getMessage());
        }

        if (inserido) {
            writer.println("<sucesso>inserido</sucesso>");
        } else {
            if(cadastrado){
                writer.println("<sucesso>existente</sucesso>");
            }else{
                writer.println("<sucesso>erro</sucesso>");
            }
        }

        writer.flush();
        writer.close();
    }

  
}
