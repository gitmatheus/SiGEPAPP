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
        selecionaTpEstrutura(1);
    });

    function selecionaTpEstrutura(requisicao){
        $("#SelectEstrutura").html(
            "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='edit' style='width: auto;'></select>" +
            "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>"
        );
        $.get("BuscaEstrutCadAPPPServlet",{
            tipos_requisitados:requisicao
        },function(xml){
            
           $(xml).find("estrutura").each(function(indice, elemento){
               $(elemento).find("cd_estr").text();
               $(elemento).find("nm_estr").text();
               $(elemento).find("dc_estr").text();
           });

            /*
            var qtd = parseInt($("qtd",xml).text());
            var strCombo = "";
            if (qtd != 0){
                strCombo += "<select id='frmCadAPPPEstrutura' name='frmCadAPPPEstrutura' class='edit' style='width: auto;'>";
                for (i = 0; i < qtd; i++){
                    strCombo += "<option value='" + $(xml).find("cd_est").each(text()) + "'>[" + $("tp_est",xml).text() + "]\t" + $("nm_est",xml).text() + "</option>";
                }
                strCombo +="</select>";
            }else{
                alert("Ocorreu um erro!");
            }
            $("#SelectEstrutura").html(strCombo);
            */
        });
    }
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
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>

<%@include file="rodape.jsp"%>
