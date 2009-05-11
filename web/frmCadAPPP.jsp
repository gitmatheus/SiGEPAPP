<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%@include file="cabecalho.jsp"%>
<link type="text/css" href="css/ui.all.css" rel="Stylesheet" />
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.5.3.js" ></script>
<script type="text/javascript" language="javascript" src="js/i18n/ui.datepicker-pt-BR.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $.ajaxSetup({
            async: false
        });

        var frm = document.frmCadAPPP;
        selecionaTpEstrutura(1);

        $("#frmCadAPPPChkPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
        });
        $("#frmCadAPPPChkAntiPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
        });
        $("#frmCadAPPPChkPersona").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);
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
            if (cd != "" && cd != null){
                buscaAtributos(cd);
            }
        });
    }

    function buscaAtributos(codigo){

        $.post("GetAtribDeEstrutServlet", {codestr:codigo}, function(xml){
            $("#corpo").html("<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>carregando...</font>");
           /* var strHtml = "";
            strHtml += "<table border='0' cellpadding='0' cellspacing='0' width='100%;'>";
            $(xml).find("atributo").each(function(indice,elemento){
                strHtml += "<tr><td width='30%' align='right'>";
                strHtml += "<font class='texto'>" + $(elemento).find("nome").text() + ":</font>";
                switch($(elemento).find("oracletype").text()){
                    case "VARCHAR2":
                        strHtml += "</td><td width='70%' align='left' valign='middle'>";
                        strHtml += "<textarea name='" + $(elemento).find("nome").text() +
                                   "' id='" + $(elemento).find("nome").text() + "' class='edit'></textarea>";
                        break;
                    case "NUMBER":
                        strHtml += "<br>numero";
                        break;
                    case "DATE":
                        strHtml += "<br>data";
                        break;
                }
                strHtml += "</td></tr>";
            });
            strHtml += "</table>";
            $("#corpo").html(strHtml);*/
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
                                Por favor, selecione um tipo de estrutura.
                            </div>
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
                <div id="corpo"></div>
            </td>
        </tr>
    </table>
</form>

<%@include file="rodape.jsp"%>
