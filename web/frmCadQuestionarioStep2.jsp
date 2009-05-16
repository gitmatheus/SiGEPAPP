<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadPergunta.js"></script>

<!--Inicio do formul�rio-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro&nbsp;do&nbsp;Question�rio ::..</font> </td>
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
                    <!--Botao Retornar Passo-->
                    <td align="left" style="padding-top:10px;padding-bottom:10px">
                        <div align="left" style="width:100%">
                            <a id="linkRetorna" class="navProximo ui-widget-header" href="frmCadQuestionarioStep1.jsp">
                                <span>
                                    <span class="ui-icon ui-icon-circle-arrow-w" style="display:inline-block;vertical-align:middle"></span>
                                    Retornar
                                </span>
                            </a>
                        </div>
                    </td>
                    <!--Botao Avan�ar Passo-->
                    <td align="right" style="padding-top:10px;padding-bottom:10px">
                        <div align="right" style="width:100%">
                            <a id="linkProximo" class="navProximo ui-widget-header" href="frmCadQuestionarioStep3.jsp">
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

<!--Fim do formul�rio-->
<%@include file="rodape.jsp"%>
