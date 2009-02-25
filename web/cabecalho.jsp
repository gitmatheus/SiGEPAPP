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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

    <!-- Inicio do cabecalho da pagina HTML -->
    <head>

        <!-- Definicao das meta tags utilizadas pelo sistema -->
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="author" content="Grupo SiGePAPP" />
        <meta name="version" content="0.01" />

        <!-- Definicao do titulo da pagina -->
        <title>SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas</title>

        <!-- Link dos arquivos css necessarios para o sistema -->
        <link rel="stylesheet" type="text/css" href="css/appp_css.css" />

        <!-- Link dos scripts necessarios para o sistema -->
        <script type="text/javascript" src="js/jquery-1.3.min.js" ></script>
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
                            <td width="562" class="top_td">
                                <img title="SiGePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas" align="left" src="images/logo.png" style='display: block' />
                            </td>
                            <td width="188" class="top_td">
                                <form action="LoginServlet" name="login" method="post">
                                    <table>
                                        <tr>
                                            <td colspan="2" valign="top" align="right">
                                                <font style="font-size: x-small;">.: <script>Data();</script></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;

                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div id="syslogin">
                                                    <fieldset style="background:#FFFFFF;">
                                                        <legend style="font-weight:bold">
                                                            Efetuar login:
                                                        </legend>
                                                        <br />
                                                        <table align="right">
                                                            <tr>
                                                                <td align="right">
                                                                    Usu&aacute;rio:
                                                                </td>
                                                                <td>
                                                                    <input id="usuario" type="text" name="usuario" class="edit" width="150px" title="Digite seu usu&aacute;rio" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    Senha:
                                                                </td>
                                                                <td>
                                                                    <input id="senha" type="password" name="senha" class="edit" width="150px" title="Digite sua senha" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <table align="center">
                                                                        <tr>
                                                                            <td align="right">
                                                                                <input id="enviar" type="submit" class="botao" title="Confirmar login" value="&nbsp;OK&nbsp;" />
                                                                            </td>
                                                                            <td align="center">
                                                                                <input id="limpar" type="button" class="botao" title="Limpar dados" value="&nbsp;Limpar&nbsp;"/>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <input type="hidden" name="acao" value="login" />
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
                                    <tr class="menubv"><td>
                                    <a id="menubv" href="#" title="Cadastro das Estruturas disponiveis no sistema" >Cadastro de Estruturas</a>                                  </tr>
                                    <tr class="menubv"><td>
                                    <a id="menubv" href="#" title="Cadastro de Patterns, Anti-Patterns e Personas" >Cadastro dos APPP</a>                                  </tr>
                                    <tr class="menubv"><td>
                                    <a id="menubv" href="#" title="Cadastro das Estruturas disponiveis no sistema" >Cadastro de Estruturas</a>                                  </tr>
                                    <tr class="menubv"><td>
                                    <a id="menubv" href="#" title="Sistema de busca de Patterns, Anti-Patterns e Personas" >Busca de APPP</a>                                  </tr>


                                </table>
                            </td>
                            <td width="80%" valign="top" align="center">
<!--Fim da inclusao do cabecalho-->