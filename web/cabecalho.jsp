<%        /**
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
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<!-- Inicio do cabecalho da pagina HTML -->
<head>

    <!-- Definicao das meta tags utilizadas pelo sistema -->
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <meta name="author" content="Grupo SiGePAPP" />
    <meta name="version" content="0.01" />

    <!-- Definicao do titulo da pagina -->
    <title>SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas</title>

    <!-- Link dos arquivos css necessarios para o sistema -->
    <link rel="stylesheet" type="text/css" href="css/appp_css.css" />
    <link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">

    <!-- Link dos scripts necessarios para o sistema -->
    <script type="text/javascript" src="js/jquery-1.3.2.js" ></script>
    <script type="text/javascript" src="js/appp_funcoes.js" ></script>

    <!-- Codigo dos scripts utilizados apenas nesta pagina  -->
    <script type="text/javascript" language="javascript">
        /** Limpa os dois campos do formulario login */
        $(document).ready(function(){
            $("#limpar").click(function(){
                $("#usuario").val("");
                $("#senha").val("");
            });
        });
    </script>

    <!-- Termino do cabecalho da pagina -->
</head>

<!-- Inicio do corpo da pagina HTML, o que estiver dentro desta TAG body sera exibido no browser para o usuario visualizar -->
<body>
<table width="750px" align="center" border="0" cellpadding="0" cellspacing="0">
<tr>
    <td>
        <table border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td width="530px" class="top_td" valign="bottom">
                    <a href="/sigepapp/"> <img border="0" title="SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas" align="left" src="images/logo.png" style='display: block; vertical-align: bottom;' /> </a>
                </td>
                <td width="220px" class="top_td" align="right" valign="middle">
                    <font class="texto" style="vertical-align:middle;">Ajuste da fonte:&nbsp;</font><a href="#" id="link_aumenta_fonte" title="Aumentar fonte"><img border="0" alt="Aumentar fonte" src="images/amais.gif" style="vertical-align:middle;"></a>&nbsp;|<a id="link_diminui_fonte" href="#" title="Diminuir fonte"><img border="0" alt="Diminuir fonte" src="images/amenos.gif" style="vertical-align:middle;"></a>
                    <form name="login" method="post">
                        <table>
                            <tr><td colspan="2" valign="top" align="right"><hr /></td></tr>
                            <tr>
                                <td colspan="2" valign="top" align="right">
                                    <div style="font-size: 11px; margin-right: 5px;">.: <script>Data();</script></div>
                                </td>
                            </tr>
                            <% if (request.getSession().getAttribute("codigo_usuario") != null && request.getSession().getAttribute("codigo_usuario") != "0") {%>
                            <tr>
                                <td colspan="2">&nbsp;

                                </td>
                            </tr>
                            <% }%>
                            <tr>
                                <td colspan="2">
                                    <div id="syslogin">
                                        <%@include file="frmLogin.jsp" %>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
    </td>
</tr>
<tr>
<td>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="20%" valign="top">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr class="menubv">
            <td>
                <a id="menubv" href="/sigepapp" title="P&aacute;gina principal" >Home</a>
            </td>
        </tr>
        <tr class="menubv">
            <td>
                <a id="menubv2" href="/sigepapp/" title="Cadastros disponiveis no sistema" >Cadastro</a>
            </td>
        </tr>
        <tr>
            <td>
                <div style="z-index:1" id="divSubMenu">
                    <table class="menubv submenu" border="0" bgcolor="#EEEEEE" cellpadding="0" cellspacing="0" width="90%" id="tableSubMenu" align="right">
                        <tr class="menubv submenu">
                            <td>
                                <a id="menubv submenu" href="/sigepapp/frmCadEstruturaStep1.jsp" title="Cadastro das Estruturas dos Patterns, Anti-Patterns e Personas" >Estrutura</a>
                            </td>
                        </tr>
                        <tr class="menubv submenu">
                            <td>
                                <a id="menubv submenu" href="/sigepapp/frmCadAPPP.jsp" title="Cadastro do conte&uacute; dos Patterns, Anti-Patterns e Personas" >Conte&uacute;do</a>
                            </td>
                        </tr>
                        <%
        try {
            Long user = new Long("11111111111");
            if (Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()) == user) {
                        %>
                        <tr class="menubv submenu">
                            <td>
                                <a id="menubv submenu" href="/sigepapp/frmCadQuestionarioStep1.jsp" title="Cadastro do question&aacute;rio" >Question&aacute;rio</a>
                            </td>
                        </tr>
                        <%            }
        } catch (Exception e) {
        }%>
                    </table>
                </div>
            </td>
        </tr>
        <!--<tr class="menubv"><td>
        <a id="menubv" href="/sigepapp/frmCadUsuario.jsp" title="Cadastro das Estruturas disponiveis no sistema" >Cadastro de Usu�rio</a></tr>-->
        <tr class="menubv">
            <td>
                <a id="menubv3" href="/sigepapp/frmBuscaAPPP.jsp" title="Sistema de busca para Patterns, Anti-Patterns e Personas" >Busca de Conte&uacute;do</a>
            </td>
        </tr>
        <tr class="menubv"><td>
        <a id="menubv" href="/sigepapp/frmCadUsuario.jsp" title="Cadastro e Edi��o de perfil dos usu&aacute;rios" >Registre-se</a></tr>
        <tr class="menubv"><td>
        <a id="menubv" href="/sigepapp/help.jsp" title="FAQ do SiGePAPP" >Ajuda</a></tr>
        <!--<tr class="menubv"><td>
        <a id="menubv" href="/sigepapp/frmCadQuestionarioStep1.jsp" title="Cadastro das Perguntas e Respostas do question�rio" >Question&aacute;rio</a></tr>-->

    </table>
</td>
<td width="80%" valign="top" align="center">

<!--Fim da inclusao do cabecalho-->
