<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%@include file="cabecalho.jsp"%>

<link type="text/css" rel="stylesheet" href="css/appp_css.css">
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">

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
                                <input id="frmCadPergRespNomePergunta" type="text" name="frmCadPergRespNomePergunta" class="edit" style="width: 320px;" maxlength="100" title="Digite sua pergunta" />
                            </div>
                        </td>
                        <td width="10%" align="center">
                            <input id="frmCadPergRespEnviaPerg" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
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
                                <input id="frmCadPergRespNomePerguntas" type="text" name="frmCadPergRespNomePerguntas" class="edit" style="width: 320px;" maxlength="100" title="Digite sua pergunta" />
                            </div>
                        </td>
                        <td width="10%" align="center">
                            <input id="frmCadPergRespEnviaResp" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
                        </td>
                </tr>
            </table>
    </form>
</fieldset>

<%@include file="rodape.jsp"%>
