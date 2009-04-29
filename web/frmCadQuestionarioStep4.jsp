<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <!--Menu de Navegacao do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            <b>Passos:</b>
            <a href="frmCadQuestionarioStep1.jsp">Dados do Question&aacute;rio</a>&nbsp;>&nbsp;
            <a href="frmCadQuestionarioStep2.jsp">Cadastro de Perguntas</a>&nbsp;>&nbsp;
            <a href="frmCadQuestionarioStep3.jsp">Cadastro de Respostas</a>&nbsp;>&nbsp;
            <a href="#">Confirma&ccedil;&atilde;o</a>
        </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset title="Perguntas" style="width:90%">
                <legend class="legend">Confirma&ccedil;&atilde;o</legend>
                    Cadastro do Question&aacute;rio realizado com sucesso !!!
                <table width="100%">
                </table>

            </fieldset>
        </td>
    </tr>

    <!--Botao de Proximo-->
    <tr>
        <td align="center" style="padding-top:10px;">
            <div align="left" style="width:93%">
                <a id="linkRetorna" class="navProximo ui-widget-header" href="frmCadQuestionarioStep3.jsp">
                    <span>
                        <span class="ui-icon ui-icon-circle-arrow-w" style="display:inline-block;vertical-align:middle"></span>
                        Retornar
                    </span>
                </a>
            </div>
        </td>
    </tr>
</table>

<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
