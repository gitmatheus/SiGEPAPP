<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%        /**
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  30/03/09   | Criacao                              |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  31/03/09   | Criacao da Servlet e DAO             |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  01/04/09   | Cadastro de Pergunta funcionando     |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  08/04/09   | Combo para mostrar Perg. cadastradas |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  18/04/09   | Criacao das Wizards                  |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  19/04/09   | Reformulacao e Atualizacao das steps |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  20/04/09   | Atualizacao das Steps e criacao da   |
         * |             |             | Step4 como feeback do cadastro       |
         * |------------------------------------------------------------------|
         * | Guilherme   |  24/05/09   | Ajax async desativado                |
         * |------------------------------------------------------------------|
         **/
%>

<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadPergunta.js"></script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro&nbsp;do&nbsp;Questionário ::..</font> </td>
    </tr>

    <!--Menu de Navegacao do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            <a href="#">Passo 1: Cadastro de Perguntas</a>&nbsp;>&nbsp;
            Passo 2: Cadastro de Respostas&nbsp;>&nbsp;
            Passo 3: Confirma&ccedil;&atilde;o
        </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset title="Perguntas" style="width:90%">
                <legend class="legends">Cadastro de Perguntas</legend>
                <form name="frmCadPerg" method="post">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="justify" valign="middle" colspan="3" style="padding-top:5px;padding-bottom:15px">
                                Utilize o campo abaixo para cadastrar as perguntas que formar&aacute; o question&aacute;rio
                            </td>
                        </tr>
                        <tr>
                            <td width="35%" align="left">
                                <div class="labels">Cadastrar nova pergunta</div>
                            </td>
                            <td width="55%" align="center">
                                <div>
                                    <input id="frmCadQuestionarioDescPerg" name="frmCadQuestionarioDescPerg" type="text" class="edit" size="40" maxlength="100" title="Digite sua pergunta" />
                                </div>
                            </td>
                            <td width="10%" align="center">
                                <input id="frmCadQuestionarioEnviaPerg" name="frmCadQuestionarioEnviaPerg" class="botao" style="background-color:#3d414c;" type="button" value="Cadastrar">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center" style="padding-top:5px">
                                <select id="FrmCadQuestionarioComboPerg" size="10" style="width:100%" class="edit">
                                    <div></div>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
            </fieldset>
        </td>
    </tr>

 <!--Botoes de sequencia ao final da pagina-->
    <tr>
        <td>
            <table align="center" border="0" width="92%" style="background-color:#ffffff;">
                <tr>
                    <td align="right" style="padding-top:10px;padding-bottom:10px">
                        <div align="right" style="width:100%">
                            <a id="linkProximo" class="navProximo ui-widget-header" href="frmCadQuestionarioStep2.jsp">
                                <span>
                                    Pr&oacute;ximo
                                    <span class="ui-icon ui-icon-circle-arrow-e" style="display:inline-block;vertical-align:middle"></span>
                                </span>
                            </a>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!--Fim do formulário-->

<div style="display:block;" id="alertPadrao">

</div>


<%@include file="rodape.jsp"%>
