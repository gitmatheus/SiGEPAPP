package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import br.edu.fei.sigepapp.bancodedados.dao.*;
import br.edu.fei.sigepapp.bancodedados.model.*;
import java.util.*;

public final class frmCadEstrutura_jsp extends org.apache.jasper.runtime.HttpJspBase
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
         * |  Tom e Gui  |  09/02/25   | Definicao do Cadastro                |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/26   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  09/02/27   |                                      |
         * |------------------------------------------------------------------|
         **/
        AtributoDAO atributoDAO = new AtributoDAO();
        Collection<Atributo> atributos;
        atributos = atributoDAO.seleciona("select * from APPP_TB_ATRIBUTO_OBJ");

      out.write("\r\n");
      out.write("\r\n");
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
      out.write("        <script type=\"text/javascript\" src=\"js/jquery-1.3.1.min.js\" ></script>\r\n");
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
      out.write("                            <td width=\"530px\" class=\"top_td\">\r\n");
      out.write("                                <img title=\"SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas\" align=\"left\" src=\"images/logo.png\" style='display: block' />\r\n");
      out.write("                            </td>\r\n");
      out.write("                            <td width=\"220px\" class=\"top_td\" align=\"right\">\r\n");
      out.write("                                <form name=\"login\" method=\"post\">\r\n");
      out.write("                                    <table>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td colspan=\"2\" valign=\"top\" align=\"right\">\r\n");
      out.write("                                                <div style=\"font-size: 11px; margin-right: 5px;\">.: <script>Data();</script></div>\r\n");
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
 if(request.getSession().getAttribute("codigo_usuario") == null || request.getSession().getAttribute("codigo_usuario") == "0") { 
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
      out.write("\t\t\tVocê não possui registro? <br /> <a href=\"/sigepapp/frmCadUsuario.jsp\" style=\"color: #822007;\"> Clique aqui</a> para registrar-se.\r\n");
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
      out.write("<style>\r\n");
      out.write("    .formulario input, .select_uma_linha{\r\n");
      out.write("        height: 20px;\r\n");
      out.write("        font-size:small;\r\n");
      out.write("        background-color: #CCCCCC;\r\n");
      out.write("\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .select_varias_linhas, .select_varias_linhas option{\r\n");
      out.write("        font-size:small;\r\n");
      out.write("        background-color: #CCCCCC;\r\n");
      out.write("\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .atributoAdicional{\r\n");
      out.write("        height: 2em;\r\n");
      out.write("        font-weight:bold;\r\n");
      out.write("\r\n");
      out.write("        vertical-align:middle;\r\n");
      out.write("    }\r\n");
      out.write("    .atributoAdicional img{\r\n");
      out.write("        vertical-align:middle;\r\n");
      out.write("    }\r\n");
      out.write("    .atributoMinimo{\r\n");
      out.write("\r\n");
      out.write("    }\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\" language=\"javascript\">\r\n");
      out.write("    var nro_atributos;\r\n");
      out.write("    $(document).ready(function(){\r\n");
      out.write("        $(\"#formEscolheAtributos\").hide();\r\n");
      out.write("        nro_atributos=0;\r\n");
      out.write("    });\r\n");
      out.write("\r\n");
      out.write("    function func_incluiAtributo(){\r\n");
      out.write("        //Armazena na variavel selecao o objeto selecionado no combo box do formulario.\r\n");
      out.write("        var selecao=$(\"#cmbSelecionaAtributo option:selected\");\r\n");
      out.write("        //Adiciona na tabela de atributos o atributo selecionado no combo.O id da\r\n");
      out.write("        $(\"#tabAtributos\").append(\"<tr id=\\\"atributo_\"+selecao.val()+\"\\\">\\n\\\r\n");
      out.write("            <td width=\\\"50%\\\" class=\\\"atributoAdicional\\\" align=\\\"right\\\">\\n\\\r\n");
      out.write("                <input type=\\\"hidden\\\" name=\\\"atributos_ids\\\" value=\\\"\"+\r\n");
      out.write("            selecao.val()+\"\\\">\"+\r\n");
      out.write("            selecao.text()+\r\n");
      out.write("            \"</td><td width=\\\"50%\\\" align=\\\"left\\\"><a href=\\\"javascript:func_removeAtributo(\\'\"+selecao.val()+\"\\')\\\">\\\r\n");
      out.write("            <img src=\\\"images/remover.gif\\\" border=\\\"none\\\" ></a></td></tr>\");\r\n");
      out.write("        selecao.hide();\r\n");
      out.write("        selecao.attr(\"disabled\",\"disabled\");\r\n");
      out.write("        selecao.removeAttr(\"selected\");\r\n");
      out.write("        nro_atributos++;\r\n");
      out.write("        guardaOption(\"teste\");\r\n");
      out.write("        guardaOption(\"tteste2\");\r\n");
      out.write("    };\r\n");
      out.write("    var objetos=new Array;\r\n");
      out.write("    var i=0;\r\n");
      out.write("    function guardaOption(id){\r\n");
      out.write("        objetos.push(id);\r\n");
      out.write("        i++;\r\n");
      out.write("    }\r\n");
      out.write("    function retornaOption(id){\r\n");
      out.write("        objetos.slice(id, 1);\r\n");
      out.write("        return \"paseei\";\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    function func_removeAtributo(cod_atrib){\r\n");
      out.write("\r\n");
      out.write("        //$(\"#atributo_\"+cod_atrib).hide()\r\n");
      out.write("        $(\"#atributo_\"+cod_atrib).remove();\r\n");
      out.write("\r\n");
      out.write("        $(\"#cmbSelecionaAtributo option[value='\"+cod_atrib+\"']\").show(\"normal\").removeAttr(\"selected\").removeAttr(\"disabled\");\r\n");
      out.write("        nro_atributos--;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    function filtraCombo(){\r\n");
      out.write("\r\n");
      out.write("        var texto=$(\"#txtBusca\").val().toLowerCase();\r\n");
      out.write("        $(\"#cmbSelecionaAtributo option:enabled\").hide();\r\n");
      out.write("        $(\"#cmbSelecionaAtributo option:enabled\").each(function(index,elemento){\r\n");
      out.write("            if($(elemento).text().toUpperCase().indexOf($(\"#txtBusca\").val().toUpperCase(), 0)>=0){\r\n");
      out.write("                $(elemento).show();\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("    }\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" align=\"right\" class=\"formulario\">\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td align=\"center\" class=\"titulo\" style=\"height: 25px; vertical-align: middle;\"> <font class=\"titulo\">..:: Cadastro&nbsp;de&nbsp;Estruturas APPP ::..</font> </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("    <tr>\r\n");
      out.write("        <td align=\"center\">\r\n");
      out.write("            <br>\r\n");
      out.write("            <fieldset style=\"width: 500px\">\r\n");
      out.write("                <legend><b>Escolha da estrutura:</b></legend>\r\n");
      out.write("                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td width=\"30%\" align=\"right\">\r\n");
      out.write("                            <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                Nome da estrutura:\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </td>\r\n");
      out.write("                        <td width=\"70%\" align=\"left\">\r\n");
      out.write("                            <div  style=\"margin-left: 5px;\">\r\n");
      out.write("                                <input class=\"edit\" type=\"text\" size=\"20\"/>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>&nbsp;</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td width=\"30%\" align=\"right\">\r\n");
      out.write("                            <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                Descri&ccedil;&atilde;o:\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </td>\r\n");
      out.write("                        <td width=\"70%\" align=\"left\">\r\n");
      out.write("                            <div  style=\"margin-left: 5px;\">\r\n");
      out.write("                                <input class=\"edit\" type=\"text\" size=\"20\"/>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td>&nbsp;</td>\r\n");
      out.write("                        <td></td>\r\n");
      out.write("                    </tr>\r\n");
      out.write("\r\n");
      out.write("                    <tr>\r\n");
      out.write("                        <td width=\"30%\" align=\"right\">\r\n");
      out.write("                            <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                Tipo de Estrutura:\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </td>\r\n");
      out.write("                        <td width=\"70%\" align=\"left\">\r\n");
      out.write("                            <div  style=\"margin-left: 5px;\">\r\n");
      out.write("                                <select class=\"select_uma_linha\" id=\"frmCadEstrTipo\" name=\"frmCadEstrTipo\" style=\"height: 1.5em;\" width=\"150px\" maxlength=\"30\" title=\"Escolha o tipo de Estrutura\">\r\n");
      out.write("                                    <option label=\"\" >Pattern</option>\r\n");
      out.write("                                    <option label=\"\" >Anti-Pattern</option>\r\n");
      out.write("                                    <option label=\"\" >Persona</option>\r\n");
      out.write("                                    <option label=\"\" style=\"background: #EEEEEE\" onclick=\"alert('Aqui abre janela para procurar por estruturas existentes')\" >Importar de Estrutura Existente...</option>\r\n");
      out.write("                                </select>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </td>\r\n");
      out.write("\r\n");
      out.write("                    </tr>\r\n");
      out.write("\r\n");
      out.write("                </table>\r\n");
      out.write("            </fieldset>\r\n");
      out.write("\r\n");
      out.write("            <!-- Inicio da customizacao de atributos -->\r\n");
      out.write("            <fieldset style=\"width: 500px;\">\r\n");
      out.write("                <legend><b>Escolha dos atributos:</b></legend>\r\n");
      out.write("                <form action=\"frmCadEstrutura.jsp\" method=\"get\">\r\n");
      out.write("                    <table  id=\"tabAtributos\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"500\">\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td colspan=\"2\" width=\"30%\" align=\"center\">\r\n");
      out.write("                                <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                    Nome\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td>&nbsp;</td>\r\n");
      out.write("                            <td></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td colspan=\"2\" width=\"30%\" align=\"center\">\r\n");
      out.write("                                <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                    Contexto\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </td>\r\n");
      out.write("\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td>&nbsp;</td>\r\n");
      out.write("                            <td></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td colspan=\"2\" width=\"30%\" align=\"center\">\r\n");
      out.write("                            <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                Problema\r\n");
      out.write("                            </div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td>&nbsp;</td>\r\n");
      out.write("                            <td></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td colspan=\"2\" width=\"30%\" align=\"center\">\r\n");
      out.write("                            <div style=\"margin-right: 10px;\">\r\n");
      out.write("                                Solu&ccedil;&atilde;o\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"500\">\r\n");
      out.write("                        <tr id=\"linhaDoSeletor\">\r\n");
      out.write("                            <td colspan=\"2\" width=\"30%\" align=\"center\">\r\n");
      out.write("                            <div style=\"margin-right: 10px;\">\r\n");
      out.write("\r\n");
      out.write("                                <br>\r\n");
      out.write("                                <fieldset style=\"background-color:#eeeeee;\">\r\n");
      out.write("                                    <legend>Selecionar atributos:</legend>\r\n");
      out.write("                                    <table width=\"300\" style=\"background-color:#eeeeee;\">\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td align=\"right\">\r\n");
      out.write("                                                Busca de Atributo:\r\n");
      out.write("                                            </td>\r\n");
      out.write("                                            <td>\r\n");
      out.write("                                                <input id=\"txtBusca\" type=\"text\" style=\"width: 145px\" onkeyup=\"filtraCombo();\"></input>\r\n");
      out.write("                                            </td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                        <tr>\r\n");
      out.write("                                            <td align=\"right\">Atributo:</td><td>\r\n");
      out.write("                                                <select class=\"select_varias_linhas\" size=\"8\" style=\"width: 150px\" id=\"cmbSelecionaAtributo\" ondblclick=\"func_incluiAtributo();\">\r\n");
      out.write("                                                    ");
for (Atributo t : atributos) {
      out.write("\r\n");
      out.write("                                                    <option label=\"\" value=\"");
      out.print(t.getCd_atributo_obj());
      out.write("\" title=\"");
      out.print(t.getDs_atributo_obj());
      out.write('"');
      out.write(' ');
      out.write('>');
      out.print(t.getNm_atributo_obj());
      out.write("</option>\r\n");
      out.write("                                                    ");
}
      out.write("\r\n");
      out.write("                                                </select>\r\n");
      out.write("                                        </td></tr>\r\n");
      out.write("                                        <tr><td colspan=\"2\" align=\"center\">\r\n");
      out.write("                                                <a onclick=\"\" href=\"javascript:if($('#cmbSelecionaAtributo option:selected').length>0){func_incluiAtributo();}\"><img src=\"images/add.gif\" border=\"none\">Adicionar</a>\r\n");
      out.write("                                        </td></tr>\r\n");
      out.write("                                        <tr><td colspan=\"2\"></td>\r\n");
      out.write("                                        </tr>\r\n");
      out.write("                                    </table>\r\n");
      out.write("                                </fieldset>\r\n");
      out.write("                            </div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                        </tr>\r\n");
      out.write("                        <tr>\r\n");
      out.write("                            <td colspan=\"2\"><a href=\"#\" onclick=\"javascript: $('#formEscolheAtributos').show('normal');\"><img src=\"images/add.gif\" border=\"none\">Adicionar novo atributo</a></td>\r\n");
      out.write("                        </tr>\r\n");
      out.write("                    </table>\r\n");
      out.write("                    <input type=\"submit\" value=\"enviar\">Enviar\r\n");
      out.write("                </form>\r\n");
      out.write("            </fieldset>\r\n");
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("    </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<div id=\"formEscolheAtributos\" style=\"position: absolute; left: 50%; top: 50%; background-color:silver; width: auto;\">\r\n");
      out.write("    <div align=\"right\" style=\"background-color:#3d414c\"><a style=\"height:5px\" onclick=\"$('#formEscolheAtributos').hide();\" href=\"#\"><img border=\"nome\" src=\"images/fechar.gif\"/></a></div>\r\n");
      out.write("    <br>\r\n");
      out.write("    <fieldset>\r\n");
      out.write("        <legend>Selecionar atributos:</legend>\r\n");
      out.write("        <table width=\"300\">\r\n");
      out.write("            <tr><td align=\"center\">Busca de Atributo:</td><td><input type=\"text\" style=\"width: 145px\"></input></td></tr>\r\n");
      out.write("            <tr><td>Atributo:</td><td>\r\n");
      out.write("                    <select size=\"8\" style=\"width: 150px\">\r\n");
      out.write("                        <option>At1</option>\r\n");
      out.write("                        <option>At2</option>\r\n");
      out.write("                        <option>At3</option>\r\n");
      out.write("                        <option>At4</option>\r\n");
      out.write("                    </select>\r\n");
      out.write("            </td></tr>\r\n");
      out.write("\r\n");
      out.write("            <tr><td colspan=\"2\" align=\"center\">Ou crie um atributo novo:</td></tr>\r\n");
      out.write("            <tr><td>Nome:</td><td><input type=\"text\"></input></td></tr>\r\n");
      out.write("            <tr><td>Descri&cedil;&atilde;o:</td><td><input type=\"text\"></input></td></tr>\r\n");
      out.write("            <tr><td>Tipo:</td>\r\n");
      out.write("                <td><select id=\"frmCadAtribTipo\" name=\"frmCadAtribTipo\" class=\"edit\" width=\"100px\" maxlength=\"50\" title=\"Escolha o tipo de dados do atributo\">\r\n");
      out.write("                        <option label=\"\" >data</option>\r\n");
      out.write("                        <option label=\"\" >numero</option>\r\n");
      out.write("                        <option label=\"\" >texto</option>\r\n");
      out.write("                        <option label=\"\" style=\"background: #EEEEEE\" onclick=\"alert('Aqui abre janela para procurar por estruturas existentes')\" >Novo atributo</option>\r\n");
      out.write("                    </select>\r\n");
      out.write("                    <a onclick=\"alert('Adiciona o novo atributo e inclui')\" href=\"#\"><img src=\"images/add.gif\" border=\"none\">Adicionar</a>\r\n");
      out.write("            </td></tr>\r\n");
      out.write("            <tr><td colspan=\"2\"></td>\r\n");
      out.write("            </tr>\r\n");
      out.write("        </table>\r\n");
      out.write("    </fieldset>\r\n");
      out.write("</div>\r\n");

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
      out.write("                        <font style=\"font-size:small;\">\r\n");
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
      out.write('\r');
      out.write('\n');
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
