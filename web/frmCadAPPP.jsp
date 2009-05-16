<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.js" ></script>
<script type="text/javascript" language="javascript" src="js/i18n/ui.datepicker-pt-BR.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript">
    var cod_estrutura, pos, tam;
    var codigos_atrib = new Array();
    var valores = new Array();
    var atribtemp = new Array();
    var atributos = new Array();
    var relacoes = new Array();
    var linha_relacoes = new Array();

    $(document).ready(function(){
        $.ajaxSetup({
            async: false
        });
        
        var frm = document.frmCadAPPP;
        selecionaTpEstrutura(1);
        $("#erroCadastro").show();

        $("#frmCadAPPPChkPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
            $("#corpo").html("");
            $("#botoes").hide();
            atributos = new Array();
            valores = new Array();
            atribtemp = new Array();
        });
        
        $("#frmCadAPPPChkAntiPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
            $("#corpo").html("");
            $("#botoes").hide();
            atributos = new Array();
            valores = new Array();
            atribtemp = new Array();
        });

        $("#frmCadAPPPChkPersona").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
            $("#corpo").html("");
            $("#botoes").hide();
            atributos = new Array();
            valores = new Array();
            atribtemp = new Array();
        });

        $("#botoes").hide();

        $("#frmCadAPPPBtnCadastrar").click(function(){
            switch(parseInt(cod_estrutura)){
                case 1:
                    cadastraPattern();
                    break;
                case 2:
                    cadastraAntiPattern();
                    break;
                case 3:
                    cadastraPersona();
                    break;
                default:
                    cadastraObjeto();
                    break;
            }
        });

        $("#frmCadAPPPBtnCancelar").click(function(){
            window.location = "/sigepapp";
        });

        frm.frmCadAPPPChkPattern.checked = true;
        frm.frmCadAPPPChkAntiPattern.checked = true;
        frm.frmCadAPPPChkPersona.checked = true;
    });

    function verificaChkBox(){
        frm = document.frmCadAPPP;
        if (frm.frmCadAPPPChkPattern.checked == true && frm.frmCadAPPPChkAntiPattern.checked == true && frm.frmCadAPPPChkPersona.checked == true){
            return 1;
        }else if(frm.frmCadAPPPChkPattern.checked == false && frm.frmCadAPPPChkAntiPattern.checked == true && frm.frmCadAPPPChkPersona.checked == true){
            return 2;
        }else if(frm.frmCadAPPPChkPattern.checked == true && frm.frmCadAPPPChkAntiPattern.checked == false && frm.frmCadAPPPChkPersona.checked == true){
            return 3;
        }else if(frm.frmCadAPPPChkPattern.checked == true && frm.frmCadAPPPChkAntiPattern.checked == true && frm.frmCadAPPPChkPersona.checked == false){
            return 4;
        }else if(frm.frmCadAPPPChkPattern.checked == true && frm.frmCadAPPPChkAntiPattern.checked == false && frm.frmCadAPPPChkPersona.checked == false){
            return 5;
        }else if(frm.frmCadAPPPChkPattern.checked == false && frm.frmCadAPPPChkAntiPattern.checked == true && frm.frmCadAPPPChkPersona.checked == false){
            return 6;
        }else if(frm.frmCadAPPPChkPattern.checked == false && frm.frmCadAPPPChkAntiPattern.checked == false && frm.frmCadAPPPChkPersona.checked == true){
            return 7;
        }else{
            return 0;
        }
    }

    function selecionaTpEstrutura(requisicao){
        $("#SelectEstrutura").html(
        "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='edit' style='width: auto;'></select>" +
            "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>"
    );

        $.get("BuscaEstrutCadAPPPServlet",{
            tipos_requisitados:requisicao
        },function(xml){
            var qtd = parseInt($("qtd",xml).text());
            var strCombo = "";
            if (qtd > 0){
                strCombo += "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='edit' style='width: auto;'>";
                strCombo += "<option value=''>Escolha a estrutura desejada...</option>";
                $(xml).find("estrutura").each(function(indice /* indice de interacao utilizado pelo each() */,
                elemento /* a estrutura atual do each */){
                    strCombo += "<option value='" + $(elemento).find("cod_est").text()+ "'>[" +
                        $(elemento).find("tp_est").text() + "]\t" +
                        $(elemento).find("nm_est").text() + "</option>";
                });
                strCombo +="</select>";
            }else{
                $("#alertaSelectEstrut").dialog('open');
                strCombo += "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='edit' style='width: auto;'>";
                strCombo += "<option value=''>Escolha a estrutura desejada...</option>";
                strCombo +="</select>";
            }
            $("#SelectEstrutura").html(strCombo);
        });

        $("#frmCadAPPPEstrutura").change(function(){
            var cd = $("#frmCadAPPPEstrutura").val();
            cod_estrutura = $("#frmCadAPPPEstrutura").val();
            atributos = new Array();
            valores = new Array();
            atribtemp = new Array();

            if (cd != "" && cd != null){
                buscaAtributos(cd);
            }else{
                $("#corpo").html("");
                $("#botoes").hide();
            }
        });
    }

    function buscaAtributos(codigo){

        $.post("GetAtribDeEstrutServlet", {codestr:codigo}, function(xml){
            $("#corpo").html("<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>carregando...</font>");
            var strHtml = "";
            var nome = "";
            strHtml += "<table border='0' cellpadding='0' cellspacing='0' width='100%;'>";
            $(xml).find("atributo").each(function(indice,elemento){
                atributos[indice] = $(elemento).find("oracletype").text();
                strHtml += "<tr><td width='30%' align='right'>";
                strHtml += "<font class='texto'>" + $(elemento).find("nome").text() + ":&nbsp;&nbsp;</font>";
                if($(elemento).find("coluna").text() != "" && $(elemento).find("coluna").text() != "null"){
                    nome = $(elemento).find("coluna").text();
                }else{
                    nome = $(elemento).find("nome").text();
                }
                atribtemp[indice] = nome;
                switch($(elemento).find("oracletype").text()){
                    case "VARCHAR":
                    case "VARCHAR2":
                        strHtml += "</td><td width='70%' align='left' valign='middle'>";
                        strHtml += "<textarea name='" + nome +
                            "' id='" + nome + "' class='edit' cols='60'></textarea>";
                        break;
                    case "NUMBER":
                        strHtml += "</td><td width='70%' align='left' valign='middle' nowrap>";
                        strHtml += "<input id='" + nome + "' name='" + nome + "' type='text' class='edit' />";
                        break;
                    case "DATE":
                        strHtml += "</td><td width='70%' align='left' valign='middle'>";
                        strHtml += "<input id='" + nome + "' name='" + nome + "' type='text' class='edit' />";
                        break;
                }
                
                strHtml += "</td></tr>";

            });
            strHtml += "</table>";
            $("#corpo").html(strHtml);
            $("#botoes").show();
        });

    }

    function cadastraPattern(){
        for(i = 0; i < atribtemp.length; i++){
            valores[i] = $("#" + atribtemp[i]).val();
        }
        $.post("CadPatternServlet", {valores:valores, estrutura:cod_estrutura}, function(xml){
            if($("sucesso",xml).text() == "1"){
                $("#cadastrado").dialog('open');
            }else{
                $("#erroCadastro").dialog('open');
            }
        });

    }

    function cadastraAntiPattern(){
        for(i = 0; i < atribtemp.length; i++){
            valores[i] = $("#" + atribtemp[i]).val();
        }
        $.post("CadAntiPatternServlet", {valores:valores, estrutura:cod_estrutura}, function(xml){
            if($("sucesso",xml).text() == "1"){
                $("#cadastrado").dialog('open');
            }else{
                $("#erroCadastro").dialog('open');
            }
        });

    }

    function cadastraPersona(){
        for(i = 0; i < atribtemp.length; i++){
            valores[i] = $("#" + atribtemp[i]).val();
        }
        $.post("CadPersonaServlet", {valores:valores, estrutura:cod_estrutura}, function(xml){
            if($("sucesso",xml).text() == "1"){
                $("#cadastrado").dialog('open');
            }else{
                $("#erroCadastro").dialog('open');
            }
        });

    }

    function cadastraObjeto(){
        for(i = 0; i < atribtemp.length; i++){
            valores[i] = $("#" + atribtemp[i]).val();
        }
        $.post("CadAPPPServlet", {valores:valores, estrutura:cod_estrutura, atributos: atributos, colunas: atribtemp}, function(xml){
            if($("sucesso",xml).text() == "1"){
                $("#cadastrado").dialog('open');
            }else{
                $("#erroCadastro").dialog('open');
            }
        });

    }

    $(function(){
        $("#alertaSelectEstrut").dialog({
            autoOpen: false,
            width: 'auto',
            height: 100,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                }
            }
        });

        $("#cadastrado").dialog({
            autoOpen: false,
            width: 'auto',
            height: 100,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                    window.location = "/sigepapp/frmCadAPPP.jsp";
                }
            }
        });

        $("#erroCadastro").dialog({
            autoOpen: false,
            width: 'auto',
            height: 130,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                }
            }
        });

        $("#naoLogado").dialog({
            autoOpen: false,
            width: 'auto',
            height: 100,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                }
            }
        });
    });
</script>
<form name="frmCadAPPP" method="post">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
        <tr>
            <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro de Patterns, Anti-Patterns ou Personas ::..</font> </td>
        </tr>
        <tr>
            <td align="center">
                <br />
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Estruturas: </font>
                            </div>
                        </td>
                        <td width="70%" align="left" valign="middle">
                            <div id="SelectEstrutura" style="margin-left: 5px;">
                                <select id="frmCadAPPPEstrutura" name="frmCadAPPPEstrutura" class="edit" style="width: auto;">
                                    <option value="">Escolha a estrutura desejada...</option>
                                </select>
                            </div>
                            <div id="alertaSelectEstrut" title="Estruturas não encontradas">
                                Por favor, selecione um tipo de estrutura.<br />
                            </div>
                            <script type="text/javascript">$("#alertaSelectEstrut").hide();</script>
                            <div id="cadastrado" title="Parab&eacute;ns">
                                Objeto cadastrado com sucesso.<br />
                            </div>
                            <script type="text/javascript">$("#cadastrado").hide();</script>
                            <div id="naoLogado" title="Aviso">
                                Por favor, efetue o login antes e cadastrar um APPP.<br />
                            </div>
                            <script type="text/javascript">$("#naoLogado").hide();</script>
                            <div id="erroCadastro" title="Aviso">
                                Desculpe-nos, ocorreu um erro durante o cadastro do objeto.<br />
                                Verifique os campos preenchidos e tente novamente.<br />
                                Obrigado, Equipe SiGePAPP.<br />
                            </div>
                            <script type="text/javascript">$("#erroCadastro").hide();</script>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <br />
                            <input id="frmCadAPPPChkPattern" name="frmCadAPPPChkPattern" type="checkbox" class="edit" value="PA" checked>
                            <font class="texto"> Patterns </font> &nbsp;&nbsp;
                            <input id="frmCadAPPPChkAntiPattern" name="frmCadAPPPChkAntiPattern" type="checkbox" class="edit" value="AP" checked>
                            <font class="texto"> Anti-Patterns </font> &nbsp;&nbsp;
                            <input id="frmCadAPPPChkPersona" name="frmCadAPPPChkPersona" type="checkbox" class="edit" value="PE" checked>
                            <font class="texto"> Personas </font>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <br />
                <div id="corpo"></div>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <br />
                <div id="botoes">
                    <input type="button" name="frmCadAPPPBtnCadastrar" id="frmCadAPPPBtnCadastrar" value="&nbsp;Cadastrar&nbsp;" class="botao" title="Enviar cadastro de APPP"/>
                    &nbsp;&nbsp;
                    <input type="button" name="frmCadAPPPBtnCancelar" id="frmCadAPPPBtnCancelar" value="&nbsp;Cancelar&nbsp;" class="botao" title="Cancelar cadastro de APPP"/>
                </div>
            </td>
        </tr>
    </table>
</form>

<%@include file="rodape.jsp"%>
