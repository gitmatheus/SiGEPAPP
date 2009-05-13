<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro&nbsp;do&nbsp;Questionário ::..</font> </td>
    </tr>

    <!--Menu de Navegacao do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            <a href="frmCadQuestionarioStep2.jsp">Passo 1: Cadastro de Perguntas</a>&nbsp;>&nbsp;
            <a href="frmCadQuestionarioStep3.jsp">Passo 2: Cadastro de Respostas</a>&nbsp;>&nbsp;
            <a href="#">Passo 3: Confirma&ccedil;&atilde;o</a>
        </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:30px;">
            <h1>Cadastro de estrutura concluído com sucesso</h1>
        </td>
    </tr>

    <!--Botao de Pagina Principal-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <div align="center" style="width:93%">
                <a id="linkRetorna" class="navProximo ui-widget-header" href="index.jsp">
                    <span>
                        <span style="display:inline-block;vertical-align:middle"></span>
                        Retornar a Página Inicial
                    </span>
                </a>
            </div>
        </td>
    </tr>
</table>

<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
