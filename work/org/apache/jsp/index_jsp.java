package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(3);
    _jspx_dependants.add("/cabecalho.jsp");
    _jspx_dependants.add("/frmLogin.jsp");
    _jspx_dependants.add("/rodape.jsp");
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

        /**
         * @{#}cabecalho.jsp 0.01 09/01/18
         *
         * Copyright (c) 2009 Equipe SiGePAPP
         *
         * Este codigo apresenta os estilos de formatacao encontrados no sistema SiGePAPP
         * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
         * do Centro Universitario da FEI, sob orientacao do Prof. Dr. Plinio T. Aquino Jr.
         *
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/18   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/23   | Alteracao na formatacao do menu para |
         * |             |             | compatibilidade entre IE e Firefox.  |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/26   | Inclusao das formatacoes dos         |
         * |             |             | elementos body e table               |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Troca do menu (de lista para tabela) |
         * |             |             | para reparar o bug de largura no menu|
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Quebra do arquivo index em cabecalho |
         * |             |             | e rodape.                            |
         * |------------------------------------------------------------------|
         **/

      out.write('\r');
      out.write('\n');
        /**
         * @{#}cabecalho.jsp 0.01 09/01/18
         *
         * Copyright (c) 2009 Equipe SiGePAPP
         *
         * Este codigo apresenta os estilos de formatacao encontrados no sistema SiGePAPP
         * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
         * do Centro Universitario da FEI, sob orientacao do Prof. Dr. Plinio T. Aquino Jr.
         *
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/18   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/23   | Alteracao na formatacao do menu para |
         * |             |             | compatibilidade entre IE e Firefox.  |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/26   | Inclusao das formatacoes dos         |
         * |             |             | elementos body e table               |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Troca do menu (de lista para tabela) |
         * |             |             | para reparar o bug de largura no menu|
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Quebra do arquivo index em cabecalho |
         * |             |             | e rodape.                            |
         * |------------------------------------------------------------------|
         **/

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("\r\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
      out.write("    <!-- Inicio do cabecalho da pagina HTML -->\r\n");
      out.write("    <head>\r\n");
      out.write("\r\n");
      out.write("        <!-- Definicao das meta tags utilizadas pelo sistema -->\r\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("        <meta name=\"author\" content=\"Grupo SiGePAPP\" />\r\n");
      out.write("        <meta name=\"version\" content=\"0.01\" />\r\n");
      out.write("\r\n");
      out.write("        <!-- Definicao do titulo da pagina -->\r\n");
      out.write("        <title>SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas</title>\r\n");
      out.write("\r\n");
      out.write("        <!-- Link dos arquivos css necessarios para o sistema -->\r\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/appp_css.css\" />\r\n");
      out.write("\r\n");
      out.write("        <!-- Link dos scripts necessarios para o sistema -->\r\n");
      out.write("        <script type=\"text/javascript\" src=\"js/jquery-1.3.min.js\" ></script>\r\n");
      out.write("        <script type=\"text/javascript\" src=\"js/appp_funcoes.js\" ></script>\r\n");
      out.write("\r\n");
      out.write("        <!-- Codigo dos scripts utilizados apenas nesta pagina  -->\r\n");
      out.write("        <script type=\"text/javascript\" language=\"javascript\">\r\n");
      out.write("            /** Limpa os dois campos do formulario login */\r\n");
      out.write("            $(document).ready(function(){\r\n");
      out.write("                $(\"#limpar\").click(function(){\r\n");
      out.write("                    $(\"#usuario\").val(\"\");\r\n");
      out.write("                    $(\"#senha\").val(\"\");\r\n");
      out.write("                });\r\n");
      out.write("            });\r\n");
      out.write("        </script>\r\n");
      out.write("\r\n");
      out.write("        <!-- Termino do cabecalho da pagina -->\r\n");
      out.write("    </head>\r\n");
      out.write("\r\n");
      out.write("    <!-- Inicio do corpo da pagina HTML, o que estiver dentro desta TAG body sera exibido no browser para o usuario visualizar -->\r\n");
      out.write("    <body>\r\n");
      out.write("        <table width=\"750px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td>\r\n");
      out.write("                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td width=\"562\" class=\"top_td\">\r\n");
      out.write("                                <img title=\"SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas\" align=\"left\" src=\"images/logo.png\" style='display: block' />\r\n");
      out.write("                            </td>\r\n");
      out.write("                            <td width=\"188\" class=\"top_td\">\r\n");
      out.write("                                <form name=\"login\" type=\"get\" method=\"post\">\r\n");
      out.write("                                    <table>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td colspan=\"2\" valign=\"top\" align=\"right\">\r\n");
      out.write("                                                <div style=\"font-size: xx-small; margin-right: 5px;\">.: <script>Data();</script></div>\r\n");
      out.write("                                            </td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td colspan=\"2\">&nbsp;\r\n");
      out.write("\r\n");
      out.write("                                            </td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td colspan=\"2\">\r\n");
      out.write("                                                <div id=\"syslogin\">\r\n");
      out.write("                                                  ");
 if(request.getSession().getAttribute("usuario") == null || request.getSession().getAttribute("usuario") == "") { 
      out.write("\r\n");
      out.write("<fieldset style=\"background:#FFFFFF;\">\r\n");
      out.write("    <legend style=\"font-weight:bold\">\r\n");
      out.write("        Efetuar login:\r\n");
      out.write("    </legend>\r\n");
      out.write("    <br />\r\n");
      out.write("    <table align=\"right\">\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td align=\"right\">\r\n");
      out.write("                Usu&aacute;rio:\r\n");
      out.write("            </td>\r\n");
      out.write("            <td>\r\n");
      out.write("                <input id=\"usuario\" type=\"text\" name=\"usuario\" class=\"edit\" width=\"150px\" title=\"Digite seu usu&aacute;rio\" />\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td align=\"right\">\r\n");
      out.write("                Senha:\r\n");
      out.write("            </td>\r\n");
      out.write("            <td>\r\n");
      out.write("                <input id=\"senha\" type=\"password\" name=\"senha\" class=\"edit\" width=\"150px\" title=\"Digite sua senha\" />\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("        <tr>\r\n");
      out.write("            <td colspan=\"2\" align=\"center\">\r\n");
      out.write("                <table align=\"center\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td align=\"right\">\r\n");
      out.write("                            <input id=\"enviar_login\" type=\"button\" class=\"botao\" title=\"Confirmar login\" value=\"&nbsp;OK&nbsp;\" />\r\n");
      out.write("                        </td>\r\n");
      out.write("                        <td align=\"center\">\r\n");
      out.write("                            <input id=\"limpar\" type=\"button\" class=\"botao\" title=\"Limpar dados\" value=\"&nbsp;Limpar&nbsp;\"/>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                </table>\r\n");
      out.write("            </td>\r\n");
      out.write("        </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("</fieldset>\r\n");
      out.write("<table align=\"right\">\r\n");
      out.write("<tr>\r\n");
      out.write("\t<td align=\"right\">\r\n");
      out.write("\t\t<div style=\"margin-right: 5px;\">\r\n");
      out.write("\t\t\tCaso não possua senha, <a href=\"/sigepapp/frmCadUsuario.jsp\" style=\"color: #822007;\"> clique aqui</a> para registrar-se.\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</td>\r\n");
      out.write("</tr>\r\n");
      out.write("</table>\r\n");
} else { 
      out.write("\r\n");
      out.write("<h2>Seja bemvindo,<br /> ");
 out.print(request.getSession().getAttribute("usuario")); 
      out.write("</h2>\r\n");
      out.write("<div align='right' style='margin-right: 10px;'>|\r\n");
      out.write(" \t<a id='envia_logoff' href='#' class='painelcontrole' title='Sair do sistema' onclick='javascript:LogoffSigepapp();' >Sair</a> \r\n");
      out.write("</div> \r\n");
      out.write("<input type='hidden' id='status' value='logoff' />\r\n");
} 
      out.write(' ');
      out.write("\r\n");
      out.write("                                                </div>\r\n");
      out.write("                                            </td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                    </table>\r\n");
      out.write("                                </form>\r\n");
      out.write("                            </td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td>\r\n");
      out.write("                    <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td width=\"20%\" valign=\"top\">\r\n");
      out.write("                                <table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n");
      out.write("                                \t<tr class=\"menubv\"><td>\r\n");
      out.write("                                    <a id=\"menubv\" href=\"/sigepapp\" title=\"P&aacute;gina principal\" >Home</a></tr>\r\n");
      out.write("                                    <tr class=\"menubv\"><td>\r\n");
      out.write("                                    <a id=\"menubv\" href=\"/sigepapp/frmCadEstrutura.jsp\" title=\"Cadastro das Estruturas disponiveis no sistema\" >Cadastro de Estruturas</a></tr>\r\n");
      out.write("                                    <tr class=\"menubv\"><td>\r\n");
      out.write("                                    <a id=\"menubv\" href=\"#\" title=\"Cadastro de Patterns, Anti-Patterns e Personas\" >Cadastro dos APPP</a></tr>\r\n");
      out.write("                                    <tr class=\"menubv\"><td>\r\n");
      out.write("                                    <a id=\"menubv\" href=\"#\" title=\"Cadastro das Estruturas disponiveis no sistema\" >Cadastro de Estruturas</a></tr>\r\n");
      out.write("                                    <tr class=\"menubv\"><td>\r\n");
      out.write("                                    <a id=\"menubv\" href=\"#\" title=\"Sistema de busca de Patterns, Anti-Patterns e Personas\" >Busca de APPP</a></tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                                </table>\r\n");
      out.write("                            </td>\r\n");
      out.write("                            <td width=\"80%\" valign=\"top\" align=\"center\">\r\n");
      out.write("<!--Fim da inclusao do cabecalho-->");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" align=\"right\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("    \t<td class=\"titulo\" width=\"50%\">\r\n");
      out.write("        \t<div style=\"margin-left: 10px; text-align:left\">\r\n");
      out.write("            \t<font class=\"titulo\">.: Patterns</font>\r\n");
      out.write("            </div>\r\n");
      out.write("        </td>\r\n");
      out.write("        <td class=\"titulo\" width=\"50%\">\r\n");
      out.write("        \t<div style=\"margin-left: 10px; text-align:left\">\r\n");
      out.write("            \t<font class=\"titulo\">.: Anti-Patterns</font>\r\n");
      out.write("            </div>\r\n");
      out.write("        </td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("        <td width=\"50%\" style=\"border-right: 1px dotted #3d414c;\">\r\n");
      out.write("        \t<div style=\" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;\">\r\n");
      out.write("            \t<font class=\"texto\">\r\n");
      out.write("                \tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\n");
      out.write("                </font>\r\n");
      out.write("            </div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("        <td width=\"50%\">\r\n");
      out.write("        \t<div style=\" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;\">\r\n");
      out.write("            \t<font class=\"texto\">\r\n");
      out.write("                \tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\n");
      out.write("                </font>\r\n");
      out.write("            </div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t\t<td class=\"titulo\" width=\"50%\" style=\"border-right: 1px dotted #3d414c;\">\r\n");
      out.write("        \t<div style=\"margin-left: 10px; text-align:left;\">\r\n");
      out.write("            \t<font class=\"titulo\">.: Personas</font>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("        </td>\r\n");
      out.write("        <td class=\"titulo\" width=\"50%\">\r\n");
      out.write("        \t<div style=\"margin-left: 10px; text-align:left\">\r\n");
      out.write("            \t<font class=\"titulo\"> &nbsp;</font>\r\n");
      out.write("            </div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr>\r\n");
      out.write("        <td width=\"50%\" style=\"border-right: 1px dotted #3d414c;\">\r\n");
      out.write("        \t<div style=\" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;\">\r\n");
      out.write("            \t<font class=\"texto\">\r\n");
      out.write("                \tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\n");
      out.write("                </font>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t\t<td width=\"50%\">\r\n");
      out.write("        \t<div style=\" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;\">\r\n");
      out.write("            \t<font class=\"texto\">\r\n");
      out.write("                \t&nbsp;\r\n");
      out.write("\t\t\t\t</font>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("        </td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");

/**
         * @{#}rodape.jsp 0.01 09/01/18
         *
         * Copyright (c) 2009 Equipe SiGePAPP
         *
         * Este codigo apresenta os estilos de formatacao encontrados no sistema SiGePAPP
         * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
         * do Centro Universitario da FEI, sob orientacao do Prof. Dr. Plinio T. Aquino Jr.
         *
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/18   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/23   | Alteracao na formatacao do menu para |
         * |             |             | compatibilidade entre IE e Firefox.  |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/26   | Inclusao das formatacoes dos         |
         * |             |             | elementos body e table               |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Troca do menu (de lista para tabela) |
         * |             |             | para reparar o bug de largura no menu|
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Quebra do arquivo index em cabecalho |
         * |             |             | e rodape.                            |
         * |------------------------------------------------------------------|
         **/

      out.write("\r\n");
      out.write("         </td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td>&nbsp;\r\n");
      out.write("\r\n");
      out.write("                </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("            <tr>\r\n");
      out.write("                <td style=\"background: #3d414c; border: 1px dotted #000000;\">\r\n");
      out.write("                    <div style=\"margin-left: 10px; margin-bottom: 5px; margin-top: 5px; color: #FFFFFF;\">\r\n");
      out.write("                        <font style=\"font-size:xx-small;\">\r\n");
      out.write("                            SiGePAPP - Copyright&copy; 2009 - Todos os direitos reservados <br />\r\n");
      out.write("                            Projeto de Formatura do Curso de Ci&ecirc;ncia da Computa&ccedil;&atilde;o, apresentado no Centro Universit&aacute;rio da FEI.\r\n");
      out.write("                        </font>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </td>\r\n");
      out.write("            </tr>\r\n");
      out.write("        </table>\r\n");
      out.write("\r\n");
      out.write("    </body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
