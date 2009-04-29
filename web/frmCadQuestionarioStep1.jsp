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
         **/
%>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <!--Menu de Navegacao do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            Passos: <a href="frmCadQuestionarioStep1.jsp">Dados do Formulario</a>&nbsp;>&nbsp;<a href="frmCadQuestionarioStep2.jsp">Cadastro de Perguntas</a>&nbsp;>&nbsp;<a href="frmCadQuestionarioStep3.jsp">Cadastro de Respostas</a>&nbsp;>&nbsp;
        </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset title="Perguntas" style="width:90%">
                <legend class="legend">Dados Gerais</legend>
                <form name="frmCadPerg" method="post">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td width="30%" align="left">
                                <div class="labels">Nome do Questionário</div>
                            </td>
                            <td width="70%" align="center">
                                <div>
                                    <input id="frmCadQuestionarioNomeQuest" name="frmCadQuestionarioNomeQuest" type="text" class="edit" size="60" maxlength="100" title="Digite sua pergunta" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td width="27%" align="left">
                                <div class="labels">Descrição do Question&aacute;rio</div>
                            </td>
                            <td width="70%" align="center">
                                <div>
                                    <textarea type="text" id="frmCadQuestionarioNomeQuest" rows="8" cols="70" name="frmCadQuestionarioNomeQuest" class="edit" title="Digite sua pergunta"></textarea>

                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </fieldset>
        </td>
    </tr>

    <!--Botao de Proximo-->
    <tr>
        <td align="center" style="padding-top:10px;">
            <div align="right" style="width:92%">
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

<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
