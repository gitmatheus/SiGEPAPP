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
         **/
%>

<%@include file="cabecalho.jsp"%>

<link type="text/css" rel="stylesheet" href="css/appp_css.css">
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link rel="stylesheet" type="text/css" href="css/ui.all.css"/>

<script type="text/javascript" language="javascript" src="js/appp_frmCadPergunta.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.5.3.js" ></script>
<script type="text/javascript" src="js/jquery.maskedinput-1.2.1.js"></script>

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
                        <input id="frmCadPergRespDescPerg" name="frmCadPergRespDescPerg" type="text" class="edit" style="width: 320px;" maxlength="100" title="Digite sua pergunta" />
                    </div>
                </td>
                <td width="10%" align="center">
                    <input id="envia_cad_pergunta" name="envia_cad_pergunta" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
                </td>
            </tr>
            <tr>
                <td colspan="3" align="center" style="padding-top:5px">
                    <select id="FrmCadPergRespComboPerg" size="10" style="width:100%" class="edit">

                    </select>
                </td>
            </tr>
        </table>
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
                        <input id="frmCadPergRespDescResp" name="frmCadPergRespDescResp" type="text" class="edit" style="width: 320px;" maxlength="100" title="Digite sua resposta" />
                    </div>
                </td>
                <td width="10%" align="center">
                    <input id="envia_cad_resposta" name="envia_cad_resposta" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
                </td>
            </tr>
        </table>
    </form>
</fieldset>

<%@include file="rodape.jsp"%>
