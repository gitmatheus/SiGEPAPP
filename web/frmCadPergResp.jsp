<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%@include file="cabecalho.jsp"%>

<link type="text/css" rel="stylesheet" href="css/appp_css.css">
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link rel="stylesheet" type="text/css" href="css/ui.all.css"/>

<script type="text/javascript" src="js/jquery-ui-1.5.3.js" ></script>
<script type="text/javascript" src="js/jquery.maskedinput-1.2.1.js"></script>
<script type="text/javascript" language="javascript" src="js/i18n/ui.datepicker-pt-BR.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadPergunta.js"></script>

<fieldset title="Perguntas">
<legend><b>Perguntas</b></legend>
    <form name="frmCadPerg" method="post">
            <table border="0" cellspacing="0" width="100%">
                <tr>
                        <td width="25%" align="left">
                            <div style="margin-right: 10px;">
                                <font class="texto">Digite sua Pergunta</font>
                            </div>
                        </td>
                        <td width="65%" align="center">
                            <div style="margin-right: 10px;">
                                <input id="frmCadPergRespDescPerg" type="text" name="frmCadPergRespDescPerg" class="edit" style="width: 320px;" maxlength="100" title="Digite sua pergunta" />
                            </div>
                        </td>
                        <td width="10%" align="center">
                            <input id="frmCadPergRespBotaoEnviaPerg" name="frmCadPergRespEnviaPerg" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
                        </td>
                </tr>
            </table
    </form>
</fieldset>

<br>

<fieldset title="Respostas">
<legend><b>Resposta</b></legend>
    <form name="frmCadResp" method="post">
            <table border="0" cellspacing="0" width="100%">
                <tr>
                        <td width="25%" align="left">
                            <div style="margin-right: 10px;">
                                <font class="texto">Digite sua Resposta</font>
                            </div>
                        </td>
                        <td width="65%" align="center">
                            <div style="margin-right: 10px;">
                                <input id="frmCadPergRespDescResp" type="text" name="frmCadPergRespDescResp" class="edit" style="width: 320px;" maxlength="100" title="Digite sua resposta" />
                            </div>
                        </td>
                        <td width="10%" align="center">
                            <input id="frmCadPergRespBotaoEnviaResp" name="frmCadPergRespEnviaResp" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
                        </td>
                </tr>
            </table>
    </form>
</fieldset>

<%@include file="rodape.jsp"%>
