package br.edu.fei.sigepapp.servlet;

import br.edu.fei.sigepapp.bancodedados.model.Pattern;
import br.edu.fei.sigepapp.bancodedados.dao.PatternDAO;
import br.edu.fei.sigepapp.log.GravarLog;
import com.sun.net.ssl.internal.ssl.Debug;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 11, 2009
 */
public class CadPatternServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        response.setContentType("text/xml; charset: ISO-8859-1");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter writer = response.getWriter();

        String[] valores = request.getParameterValues("valores");

        for(String i : valores){
            Debug.println("Saida: ", i);
        }
        writer.println("<xml><sucesso>1</sucesso></xml>");
        writer.flush();
        writer.close();
    }
}
