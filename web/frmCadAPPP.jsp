<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%@include file="cabecalho.jsp"%>
<% if (request.getSession().getAttribute("codigo_usuario") != null && request.getSession().getAttribute("codigo_usuario") != "0") {%>
<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.7.js" ></script>
<script type="text/javascript" language="javascript" src="js/i18n/ui.datepicker-pt-BR.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript">
    var cod_estrutura, pos, tam = 0, flag_relacionado = false, erroCampoVazio = false;
    var codigos_atrib = new Array();
    var valores = new Array();
    var atribtemp = new Array();
    var atributos = new Array();
    var cod_atrib_relac = new Array();
    var cod_appp_relac = new Array();
    var vlr_relacao = new Array();
    var arrayVisiveis = new Array();
    var relacionados = new Array();

    $(document).ready(function(){
        $.ajaxSetup({
            async: false
        });

        var frm = document.frmCadAPPP;
        //arrayVisiveis=$.makeArray($("#frmRelacionaSelAPPP option"));
        selecionaTpEstrutura(1);

        $("#cadastrado").show();
        $("#alertaSelectEstrut").show();
        $("#naoLogado").show();
        $("#erroCadastro").show();
        $("#divfrmRelaciona").show();
        $("#botoes").show();
        $("#alertConfirma").show();
        $("#alertVazio").show();

        $("#frmCadAPPPChkPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
            $("#corpo").html("");
            $("#botoes").hide();
            inicializaArrays();
        });

        $("#frmCadAPPPChkAntiPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
            $("#corpo").html("");
            $("#botoes").hide();
            inicializaArrays();
        });

        $("#frmCadAPPPChkPersona").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
            $("#corpo").html("");
            $("#botoes").hide();
            inicializaArrays();
        });

        $("#frmTxtBuscaEstrutura").focus(function(){
            $("#frmTxtBuscaEstrutura").val("");
            //selecionaTpEstrutura(1);
            $("#corpo").html("");
            $("#botoes").hide();
            inicializaArrays();
        });

        $("#botoes").hide();

        $("#frmCadAPPPBtnCadastrar").click(function(){
            erroCampoVazio = false;
            for(i = 0; i < atribtemp.length && !erroCampoVazio; i++){
                if($("#" + atribtemp[i]).val() == ""){
                    erroCampoVazio = true;
                }
            }
            if(erroCampoVazio){
                $("#alertVazio").dialog('open');
            }else{
                $("#alertConfirma").dialog('open');
            }
        });

        $("#alertConfirma").dialog({
            width: 300,
            modal: true,
            autoOpen: false,
            show: 'slide',
            hide: 'slide',
            draggable: false,
            buttons: {
                Nao: function(){
                    $("#alertConfirma").dialog('close');

                },
                Sim: function(){
                    $("#alertConfirma").dialog('close');
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

                }
            }});
        
        $("#frmCadAPPPBtnCancelar").click(function(){
            window.location = "/sigepapp";
        });

        frm.frmCadAPPPChkPattern.checked = true;
        frm.frmCadAPPPChkAntiPattern.checked = true;
        frm.frmCadAPPPChkPersona.checked = true;

        $("#divfrmRelaciona").dialog({
            width: 550,
            modal: true,
            autoOpen: false,
            buttons: {
                Cancelar: function() {
                    $(this).dialog('close');
                },
                Relacionar: function() {
                    if ($("#frmRelacionaSelAPPP>option:selected").text() != ""){
                        cod_atrib_relac[tam] = codigos_atrib[pos];
                        cod_appp_relac[tam] = $("#frmRelacionaSelAPPP").val();
                        if ($("#frmRelacionaTxtValor").val() != ""){
                            vlr_relacao[tam] = $("#frmRelacionaTxtValor").val();
                        }else{
                            vlr_relacao[tam] = " ";
                        }
                        tam++;
                        flag_relacionado = true;
                        $("#" + atribtemp[pos]).val($("#" + atribtemp[pos]).val() + $("#frmRelacionaSelAPPP>option:selected").text() + ";");
                    }
                    $(this).dialog('close');
                }
            },
            close: function(){
                arrayVisiveis=$.makeArray($("#frmCadAPPPEstrutura option"));
                $("#frmRelacionaTxtBusca").val("");
                $("#frmRelacionaTxtValor").val("");
                $("#frmRelacionaSelAPPP:selected").removeAttr("selected");
                $("#frmRelacionaSelAPPP:first").attr("selected","selected");
                $("frmCadAtributoSelTipo").removeAttr("checked");
            },
            open: function(){
                getObjetos();
            }
        });


    });

    function filtraCombo(combo, txtbusca){
        $(combo + " option").remove();
        $(arrayVisiveis).each(function(indice, elemento){
            if($(elemento).text().toUpperCase().indexOf($(txtbusca).val().toUpperCase(), 0)>=0){
                $(combo).append(elemento);
            }
        });
        ordenarCombo();
    }

    function ordenarCombo(combo){
        //Ordena as tags "option" dentro do combo seleciona atributo.
        $(combo + ">option").tsort();

    }

    function getObjetos(){
        $("#frmRelacionaSelAPPP option").remove();
        $.post('GetObjetoServlet',null,function(xml){
            $(xml).find("Objeto").each(function(indice, item){
                $("#frmRelacionaSelAPPP").append("<option value='"+
                    $(item).find("Codigo_Objeto").text()+"'>"+
                    $(item).find("Nome_Objeto").text()+
                    "</option>");
            });
            arrayVisiveis=$.makeArray($("#frmRelacionaSelAPPP option"));
        });
    }

    function inicializaArrays(){
        codigos_atrib = new Array();
        valores = new Array();
        atribtemp = new Array();
        atributos = new Array();
        cod_atrib_relac = new Array();
        cod_appp_relac = new Array();
        vlr_relacao = new Array();
        tam = 0;
    }

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
        "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='select_varias_linhas' size='5' style='width: 300px;'></select>" +
            "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>");

        $.get("BuscaEstrutCadAPPPServlet",{
            tipos_requisitados:requisicao
        },function(xml){
            var qtd = parseInt($("qtd",xml).text());
            var strCombo = "";
            if (qtd > 0){
                strCombo += "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='select_varias_linhas' size='5' style='width: 300px;'>";
                strCombo += "<option value=''>Escolha a estrutura do documento...</option>";
                $(xml).find("estrutura").each(function(indice /* indice de interacao utilizado pelo each() */,
                elemento /* a estrutura atual do each */){
                    strCombo += "<option value='" + $(elemento).find("cod_est").text()+ "'>[" +
                        $(elemento).find("tp_est").text() + "]\t" +
                        $(elemento).find("nm_est").text() + "</option>";
                });
                strCombo +="</select>";
            }else{
                $("#alertaSelectEstrut").dialog('open');
                strCombo += "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='select_varias_linhas' size='5' style='width: 300px;'>";
                strCombo += "<option value=''>Escolha a estrutura do documento...</option>";
                strCombo +="</select>";
            }
            $("#SelectEstrutura").html(strCombo);
        });

        arrayVisiveis=$.makeArray($("#frmCadAPPPEstrutura option"));

        $("#frmCadAPPPEstrutura").change(function(){
            var cd = $("#frmCadAPPPEstrutura").val();
            cod_estrutura = $("#frmCadAPPPEstrutura").val();
            inicializaArrays();

            if (cd != "" && cd != null){
                buscaAtributos(cd);
            }else{
                $("#corpo").html("");
                $("#botoes").hide();
            }
        });
    }

    function relacionaAPPP(posicao){
        pos = posicao;
        $(document).scrollTop(0);
        $("#divfrmRelaciona").dialog('open');
    }

    function buscaAtributos(codigo){

        $.post("GetAtribDeEstrutServlet", {codestr:codigo}, function(xml){
            $("#corpo").html("<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>carregando...</font>");
            var strHtml = "";
            var nome = "";
            strHtml += "<table border='0' cellpadding='0' cellspacing='0' width='100%;'>";
            $(xml).find("atributo").each(function(indice,elemento){
                atributos[indice] = $(elemento).find("oracletype").text();
                codigos_atrib[indice] = $(elemento).find("id").text();
                strHtml += "<tr><td width='30%' align='right'>";
                strHtml += "<font class='texto'>" + $(elemento).find("nome").text() + ":&nbsp;&nbsp;</font>";
                if($(elemento).find("coluna").text() != "" && $(elemento).find("coluna").text() != "null"){
                    nome = $(elemento).find("coluna").text();
                }else{
                    nome = $(elemento).find("nome").text();
                }
                atribtemp[indice] = nome
                relacionavel = "</td><td width='20%' align='center' valign='middle'><a class='navProximo ui-widget-header' href='javascript:relacionaAPPP(" + indice +
                    ")'><div class='ui-icon ui-icon-document' style='display:inline-block;vertical-align:middle'>" +
                    "</div>Relacionar</a>";

                switch($(elemento).find("oracletype").text()){
                    case "VARCHAR":
                    case "VARCHAR2":
                        strHtml += "</td><td width='50%' align='left' valign='middle'>";
                        strHtml += "<textarea name='" + nome +
                            "' id='" + nome + "' class='edit' cols='55' title='" + $(elemento).find("descricao").text() + "'";
                        if($(elemento).find("flagexpreg").text() == "S"){
                            strHtml += " onblur='javascript:validaCampo(\"" + $(elemento).find("nome").text() + "\",\"" + nome + "\"," + $(elemento).find("expreg").text() + ")'></textarea>"
                        }else{
                            strHtml += "></textarea>";
                        }
                        if($(elemento).find("flag_relaciona").text() == "S"){
                            strHtml += relacionavel;
                        }else{
                            strHtml += "</td><td width='20%' align='center' valign='middle'>";
                        }
                        break;
                    case "NUMBER":
                        strHtml += "</td><td width='50%' align='left' valign='middle'>";
                        strHtml += "<input id='" + nome + "' name='" + nome + "' type='text' class='edit' title='" + $(elemento).find("descricao").text() + "'";
                        if($(elemento).find("flagexpreg").text() == "S"){
                            strHtml += " onblur='javascript:validaCampo(\"" + $(elemento).find("nome").text() + "\",\"" + nome + "\"," + $(elemento).find("expreg").text() + ")'/>"
                        }else{
                            strHtml += "/>";
                        }
                        strHtml += "</td><td width='20%' align='center' valign='middle'>";
                        break;
                    case "DATE":
                        strHtml += "</td><td width='50%' align='left' valign='middle'>";
                        strHtml += "<input id='" + nome + "' name='" + nome + "' type='text' class='edit' title='" + $(elemento).find("descricao").text() + "'";
                        if($(elemento).find("flagexpreg").text() == "S"){
                            strHtml += " onblur='javascript:validaCampo(\"" + $(elemento).find("nome").text() + "\",\"" + nome + "\"," + $(elemento).find("expreg").text() + ")'/>"
                        }else{
                            strHtml += "/>";
                        }
                        strHtml += "</td><td width='20%' align='center' valign='middle'>";
                        break;
                }



                strHtml += "</td></tr>";

            });
            strHtml += "</table>";
            $("#corpo").html(strHtml);
            $("#botoes").show();
        });

    }
    function validaCampo(nm,campo,exp){
        try{
            var txtExp = new RegExp(exp);
            var txtTest=$("#" + campo).val();
            if(!txtTest.match(txtExp)){
                $("#msgErroExpr").html("<img src='images/m2brerro.png' style='vertical-align:middle;'/> O atributo " + nm +
                    " não atende as regras de validação.");
                $("#" + campo).addClass("erro");
                $("#alertErroExpr").dialog('open');
            }else{
                $("#" + campo).removeClass("erro");
            }
        }catch(e){
            $("#" + campo).addClass("erro");
        }
    }

    function cadastraPattern(){
        for(i = 0; i < atribtemp.length; i++){
            valores[i] = $("#" + atribtemp[i]).val();
        }
        $.post("CadPatternServlet", {valores:valores, estrutura:cod_estrutura}, function(xml){
            if(parseInt($("sucesso",xml).text()) > 0){
                if(flag_relacionado){
                    cadastraRelacionamento($("sucesso",xml).text());
                }else{
                    $("#cadastrado").dialog('open');
                }
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
            if(parseInt($("sucesso",xml).text()) > 0){
                if(flag_relacionado){
                    cadastraRelacionamento($("sucesso",xml).text());
                }else{
                    $("#cadastrado").dialog('open');
                }
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
            if(parseInt($("sucesso",xml).text()) > 0){
                if(flag_relacionado){
                    cadastraRelacionamento($("sucesso",xml).text());
                }else{
                    $("#cadastrado").dialog('open');
                }
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
            if(parseInt($("sucesso",xml).text()) > 0){
                if(flag_relacionado){
                    cadastraRelacionamento($("sucesso",xml).text());
                }else{
                    $("#cadastrado").dialog('open');
                }
            }else{
                $("#erroCadastro").dialog('open');
            }
        });

    }

    function cadastraRelacionamento(cd_objeto){
        $.post("CadRelacAPPPServlet",{cd_objeto: cd_objeto, cod_atrib_relac: cod_atrib_relac, cod_appp_relac: cod_appp_relac,vlr_relacao:vlr_relacao},
        function(xml){
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

        $("#alertVazio").dialog({
            width: 300,
            modal: true,
            autoOpen: false,
            show: 'slide',
            hide: 'slide',
            draggable: false,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                }
            }
        });
        
        $("#alertErroExpr").dialog({
            width: 300,
            modal: true,
            autoOpen: false,
            show: 'slide',
            hide: 'slide',
            draggable: false,
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
                        <tr>
                            <td colspan="2" align="center">
                                <fieldset style="width:400px;">
                                    <legend style="font-weight: bold;">Filtros de busca de estruturas:</legend>
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="right">
                                                <font class="texto">Por nome:&nbsp;&nbsp;</font>
                                            </td>
                                            <td>
                                                <input id="frmTxtBuscaEstrutura" type="text" class="edit" style="width: 250px" onkeyup="filtraCombo('#frmCadAPPPEstrutura','#frmTxtBuscaEstrutura');"></input>
                                            </td>
                                        </tr>
                                        <td colspan="2" align="center">
                                            <br /><font class="texto">Por tipo:</font>&nbsp;&nbsp;
                                            <input id="frmCadAPPPChkPattern" name="frmCadAPPPChkPattern" type="checkbox" class="edit" value="PA" checked>
                                            <font class="texto"> Patterns </font> &nbsp;&nbsp;
                                            <input id="frmCadAPPPChkAntiPattern" name="frmCadAPPPChkAntiPattern" type="checkbox" class="edit" value="AP" checked>
                                            <font class="texto"> Anti-Patterns </font> &nbsp;&nbsp;
                                            <input id="frmCadAPPPChkPersona" name="frmCadAPPPChkPersona" type="checkbox" class="edit" value="PE" checked>
                                            <font class="texto"> Personas </font>
                                        </td>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" valign="middle">
                            <br />
                            <font class="texto">O preenchimento de todos os campos &eacute; obrigat&oacute;rio.</font>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Estruturas de <br />documentos: </font>
                            </div>
                        </td>
                        <td width="70%" align="left" valign="middle">
                            <br />
                            <div id="SelectEstrutura" style="margin-left: 5px;">
                                <select id="frmCadAPPPEstrutura" name="frmCadAPPPEstrutura" class="select_varias_linhas" size="5" style="width: 300px;">
                                    <option value="">Escolha a estrutura do documento...</option>
                                </select>
                            </div>
                            <div id="alertaSelectEstrut" title="Estruturas não encontradas">
                               <img src="images/m2brerro.png" style="vertical-align:middle;"/> Por favor, selecione um tipo de estrutura.<br />
                            </div>
                            <script type="text/javascript">$("#alertaSelectEstrut").hide();</script>
                            <div id="cadastrado" title="Parab&eacute;ns">
                               <img src="images/m2brinfo.png" style="vertical-align:middle;"/> Documento cadastrado com sucesso.<br />
                            </div>
                            <script type="text/javascript">$("#cadastrado").hide();</script>
                            <div id="naoLogado" title="Aviso">
                                Por favor, efetue o login antes e cadastrar um Documento.<br />
                            </div>
                            <script type="text/javascript">$("#naoLogado").hide();</script>
                            <div id="erroCadastro" title="Aviso">
                                <img src="images/m2brerro.png" style="vertical-align:middle;"/>Desculpe-nos, ocorreu um erro durante o cadastro do objeto.<br />
                                Verifique os campos preenchidos e tente novamente.<br />
                                Obrigado, Equipe SiGePAPP.<br />
                            </div>
                            <script type="text/javascript">$("#erroCadastro").hide();</script>
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
                <script type="text/javascript">$("#botoes").hide();</script>
            </td>
        </tr>
    </table>
</form>

<!-- Janela para relacionamento de APPP -->
<div id="divfrmRelaciona" title="Relacionar outro Documento">
    <form id="frmRelaciona">
        <table width="500">
            <tr>
                <td align="right">
                    Buscar documento:
                </td>
                <td>
                    <input id="frmRelacionaTxtBusca" type="text" class="edit" style="width: 250px" onkeyup="filtraCombo('#frmRelacionaSelAPPP','#frmRelacionaTxtBusca');"></input>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Selecione o documento:
                </td>
                <td>
                    <select class="select_varias_linhas" size="8" style="width: 250px" id="frmRelacionaSelAPPP">
                        <option value=""></option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <font class="texto">Descrição para o relacionado:</font>
                </td>
                <td>
                    <textarea id="frmRelacionaTxtValor" class="edit" cols="35"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                </td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">$("#divfrmRelaciona").hide();</script>
<div style="display:block;" id="alertConfirma" title="Cadastro de Documentos">
    <img src="images/m2brpergunta.png" style="vertical-align:middle;"/> Confima cadastro do documento?
</div>
<script type="text/javascript">$("#alertConfirma").hide();</script>
<div style="display:block;" id="alertVazio" title="Alerta">
    <img src="images/m2bralerta.png" style="vertical-align:middle;"/> Por favor, preencher todos os campos.
</div>
<script type="text/javascript">$("#alertVazio").hide();</script>
<div style="display:block;" id="alertErroExpr">
    <div id="msgErroExpr"></div>
</div>
<% } else {%>
<center>
    <h2>Cadastro de APPP</h2>
    <font class="texto">Neste m&oacute;dulo &eacute; poss&iacute;vel efetuar o cadastro de Patterns, Anti-Patterns e Personas.</font>
    <p><small><font class="texto">Por favor, efetue o login no canto superior direito da p&aacute;gina</font></small></p>
</center>
<%}%>
<%@include file="rodape.jsp"%>
