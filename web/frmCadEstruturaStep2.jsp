<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%        /**
         * @{#}cabecalho.jsp 0.01 09/01/18
         *
         * Copyright (c) 2009 Equipe SiGePAPP
         *
         * Este codigo apresenta os estilos de formatacao encontrados no sistema SiGePAPP
         * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
         * do Centro Universitario da FEI, sob orientacao do Prof. Dr. Plinio T. Aquino Jr.
         *
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Tom e Gui  |  25/02/09   | Definicao do Cadastro                |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  26/02/09   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  27/02/09   | Criacao do Layout                                     |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  27/02/09   | Bug entre FIREFOX E IE:              |
         * |             |             | IE nao aceita hidden em option field |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  05/03/09   | FIXED: BUG IE X FIREFOX acima.       |
         * |             |             | Inicio de funcoes AJAX               |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  10/04/09   | Import de estrutura j� existente.    |
         * |             |             | Comunica��o com Servlet              |
         * |------------------------------------------------------------------|
         **/
        AtributoDAO atributoDAO = new AtributoDAO();
        Collection<Atributo> atributos;
        atributos = atributoDAO.APPP_SEL_ATRIBUTO_OBJ(new Atributo());
        atributoDAO.fechaConexao();

        List<Estrutura> pattern;
        List<Estrutura> antiPattern;
        List<Estrutura> persona;
        long patternID;
        long antiPatternID;
        long personaID;

        Estrutura_ObjDAO pesqEstrutDAO = new Estrutura_ObjDAO();


//Pesquisa o ID da Estrutura default Pattern
        pattern = pesqEstrutDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(0, "Pattern", null, null, 0, null), null);
        patternID = pattern.size() > 0 ? pattern.get(0).getCd_estrutura() : 0;

//Pesquisa o ID da Estrutura default Anti-Pattern
        antiPattern = pesqEstrutDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(0, "Anti-Pattern", null, null, 0, null), null);
        antiPatternID = antiPattern.size() > 0 ? antiPattern.get(0).getCd_estrutura() : 0;

//Pesquisa o ID da Estrutura default Persona
        persona = pesqEstrutDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(0, "Persona", null, null, 0, null), null);
        personaID = persona.size() > 0 ? persona.get(0).getCd_estrutura() : 0;
//Fecha conex�o
        pesqEstrutDAO.fechaConexao();

%>
<%@include file="cabecalho.jsp"%>


<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript">

    var carregandoXML=false;

    function valida_selecao(){

        if($("input[name='codEstrutura']:checked").val()>0){
            return true;
        }else{
            $("#divMsgSelecao").attr("style", "color: #822007;display:inline-block;background-color: #ee957f;width:100%;");
            $("#divMsgSelecao").html("Erro:<br><h3><img src='images/uncheck.png'>Selecione um estrutura como base</h3>");
            return false;
        }
    }

    function clickFieldSet(objetoClicado){
        $(objetoClicado).children("legend").andSelf().children("input").attr("checked","checked")

        if($(objetoClicado).attr("id")=="fieldSet1"){
            $("#fieldSet2").fadeTo('slow', 0.5);
            $("#fieldSet1").fadeTo('slow', 1);
            $("#fieldSet2 input[name='codEstrutura']:checked").removeAttr("checked");

        }else{
            $("#fieldSet1").fadeTo('slow', 0.5);
            $("#fieldSet2").fadeTo('slow', 1);
            $("#fieldSet1 input[name='codEstrutura']:checked").removeAttr("checked");
        }
    }

    function pesqEstruturas(codEstr){
        $("#frmPesqEstruturasTabResult").empty();

        if(codEstr==null){
            codEstr=0;
        }

        $.post("GetEstruturasServlet", {codEstr: codEstr, nome: $("#frmPesqEstruturasTxtNome").val()}, function(texto,estado){
            if(estado=="success"){

                $(texto).find("Estrutura").each(function(indice,elemento){

                    $("#frmPesqEstruturasTabResult").append("<tr align='left' onmouseout='escondeEstrutura();' style='cursor:pointer' onmouseover='mostraEstrutura("+$(elemento).find("Cod").text()+")'>"+
                        "<td style='width:auto;vertical-align:top'>"+
                        "<input name='codEstrutura' style='vertical-align:middle;' type='radio' value='"+$(elemento).find("Cod").text()+"' id='frmPesqEstruturasRadio'>"+
                        $(elemento).find("Nome").text()+
                        "</td>"+
                        "<td>"+

                        "<div class='ui-icon ui-icon-circlesmall-plus' />"+
                        "</td>"+
                        "</tr>");

                    $("#frmPesqEstruturasTabResult input:radio:eq("+indice+")").data("Tipo",$(elemento).find("Tipo").text());

                });

            }
        },"xml");
    }

    function clickFiltro(){

        $("#frmPesqEstruturasTabResult tr").hide();
        var chkPA=$("#divfrmPesqEstrutura input:checkbox[value='PA']").attr("checked");
        var chkAP=$("#divfrmPesqEstrutura input:checkbox[value='AP']").attr("checked");
        var chkPE=$("#divfrmPesqEstrutura input:checkbox[value='PE']").attr("checked");


        $("#frmPesqEstruturasTabResult input:radio").each(function(indice,elemento){
            //alert($(elemento).data("Tipo"));

            if(chkPA==true){
                if($(elemento).data("Tipo")=="PA"){
                    $(elemento).parents("tr:first").show();
                }
            }
            if(chkAP==true){
                if($(elemento).data("Tipo")=="AP"){
                    $(elemento).parents("tr:first").show();
                }
            }
            if(chkPE==true){
                if($(elemento).data("Tipo")=="PE"){
                    $(elemento).parents("tr:first").show();
                }
            }
        });

    }

    function mostraEstrutura(codEstr){
        $("#frmAlert").html("<table></table>");
        $.post("GetAtribDeEstrutServlet", {codestr: codEstr}, function(texto, estado){
            if(estado=="success"){

                $(texto).find("atributo").each(function(indice, elemento){
                    $("#frmAlert table:first").append("<tr>"+
                        "<td>"+
                        $(elemento).find("nome").text()+
                        "</td>"+
                        "</tr>"
                );
                });
            }
        }, "xml");
        $("#frmAlert").dialog();
        $("#frmAlert").dialog('open');
        $("#frmAlert").dialog('option','position',[600 ,'center']);
        $("#frmAlert").dialog('option','title',"Estrututura de: <i>"+$("#frmPesqEstruturasTabResult td:has(input[value="+codEstr+"])").text()+"</i>");

    }

    function escondeEstrutura(){
        $('#frmAlert').dialog('close');
    }

    $(document).ready(function(){
        /*
        $("#divfrmPesqEstrutura input:checkbox[value='PA']").attr("checked","checked");
        $("#divfrmPesqEstrutura input:checkbox[value='AP']").attr("checked","checked");
        $("#divfrmPesqEstrutura input:checkbox[value='PE']").attr("checked","checked");
         */

        $("#frmCadEstrutFormulario fieldset").click(function(){
            clickFieldSet(this);
        });

        $.ajaxSetup({async: false});

        $.post("readSessionServlet", {nome: "inicioEstrutura"}, function(dados){
            if ($.trim(dados)!=""){
                $("input[name='frmCadEstOptInicio'][value='"+dados+"']").click();
            }else{
                $("#fieldSet1").click();
            }
        },"text");

        $.post("readSessionServlet", {nome: "codEstrutura"}, function(dados){
            if($.trim(dados)==""){
                
            }else{
                if(dados=="<%= patternID%>" || dados==" <%= antiPatternID%>" || dados=="<%= personaID%>"){
                    $("input[value='"+dados+"']").attr("checked","checked");

                }else{

                    pesqEstruturas(dados);

                    $("input[value='"+dados+"']").click();
                }
            }
        },"text");


        $("#linkProximo").click(function(){
            if(valida_selecao()){
                $.post("writeSessionServlet", {inicioEstrutura: $("input[name='frmCadEstOptInicio']:checked").val(), codEstrutura: $("input[name='codEstrutura']:checked").val() }, null);
                return true;
            }else{
                return false;
            }
        });

        $("#frmPesqEstruturasButOk").click(function(){
            pesqEstruturas();
        });

        $("#divfrmPesqEstrutura input:checkbox").click(function(){
            clickFiltro();
        });

        $("input[name='codEstrutura']").click(function(){
            valida_selecao();
        });


    });
</script>

<!--Inicio do formul�rio-->
<table id="frmCadEstrutFormulario" border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <!--Menu do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            <b>Passos:</b>&nbsp;
            <a href="frmCadEstruturaStep1.jsp">Dados da estrutura</a>&nbsp;>&nbsp;
            <a href="#">Tipo de estrutura</a>&nbsp;>&nbsp;
            Defini��o dos Atributos
        </td>
    </tr>
    <!--Fim do menu do Wizard-->

    <tr>
        <td align="center" style="padding-top:20px;"><div id="divMsgSelecao"></div></td>
    </tr>

    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset id="fieldSet1" style="background-color:#eeeeee;width:90%">
                <legend class="legends"><input name="frmCadEstOptInicio" type="radio" value="minima">Estrutura minima:</legend>
                <table width="100%">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        Selecione o tipo de estrutura:
                                    </td>
                                    <td>
                                        <input type="radio" name="codEstrutura" value="<%= patternID%>">Pattern
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="radio" name="codEstrutura" value=" <%= antiPatternID%>">Anti-Pattern
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="radio" name="codEstrutura" value="<%= personaID%>">Persona
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td align="center" style="padding-top:10px;padding-bottom:10px">
            <div style="border-bottom-style:dashed;border-top-style:dashed;border-width:1px;width:80%;">
                <b style="font-size:15px;">OU</b>
            </div>
        </td>
    </tr>
    <tr>
        <td align="center">
            <fieldset id="fieldSet2" style="background-color:#eeeeee;width:90%;padding-top:10px;padding-bottom:30px;">
                <legend><input id="frmCadEstOptInicioImportar" name="frmCadEstOptInicio" type="radio" value="Importar"><b>Importar de uma estrutura existente:</b></legend>
                Caso deseja construir uma estrutura a partir de uma j� existente escolha uma estrutura:
                <div id="divfrmPesqEstrutura">
                    <table width="100%">
                        <tr>
                            <td>Pesquisar por nome da estrutura:</td>
                            <td><input class="edit" size="40" type="text" id="frmPesqEstruturasTxtNome">
                                <input class="botao" type="button" id="frmPesqEstruturasButOk" value="Ok">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table width="100%" style="background-color:#ffffff">
                                    <tr>
                                        <td colspan="3" align="center">
                                            Filtros:
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <input type="checkbox" value="PA" checked>Patterns
                                        </td>

                                        <td align="center">
                                            <input type="checkbox" value="AP" checked>Anti-Patterns
                                        </td>

                                        <td align="center">
                                            <input type="checkbox" value="PE" checked>Personas
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div style="overflow-y:scroll;height:250px;" >
                                    <table align="left" cellpadding="0" cellspacing="0" id="frmPesqEstruturasTabResult">

                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td>
            <table align="center" border="0" width="92%" style="background-color:#ffffff;">
                <tr>
                    <!--Botao Retornar Passo-->
                    <td align="left" style="padding-top:10px;padding-bottom:10px">
                        <div align="left" style="width:100%">
                            <a id="linkRetorna" class="navProximo ui-widget-header" href="frmCadEstruturaStep1.jsp">
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
                            <a id="linkProximo" class="navProximo ui-widget-header" href="frmCadEstruturaStep3.jsp">
                                <span style="cursor:url;">
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

<div style="display:block;" id="frmAlert">

</div>

<%@include file="rodape.jsp"%>
