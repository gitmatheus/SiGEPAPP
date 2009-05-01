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
         * |  Guilherme  |  10/04/09   | Import de estrutura já existente.    |
         * |             |             | Comunicação com Servlet              |
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
//Fecha conexão
        pesqEstrutDAO.fechaConexao();

%>
<%@include file="cabecalho.jsp"%>

<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>

<script type="text/javascript" language="javascript">
    var arrayEscondidos = new Array();
    var arrayVisiveis = new Array();

    function getAtributosDeEstrutura(cod_Estrutura){

        //Mostra todos atributos
        mostra(null);
        if(cod_Estrutura==null){
            if($("#frmCadEstrTipo").val()=="PA"){
                cod_Estrutura=<%=patternID%>
            }else if($("#frmCadEstrTipo").val()=="AP"){
                cod_Estrutura=<%=antiPatternID%>
            }else if($("#frmCadEstrTipo").val()=="PE"){
                cod_Estrutura=<%=personaID%>
            }
        }
        $.post("GetAtribDeEstrutServlet", {codestr: cod_Estrutura}, function(xml,status){

            $("#frmCadEstrDivLoadingEst").show();

            if(status=="success"){

                //Tratamento dos dados recebidos
                $("#tabAtributos").empty();
                //Retorno para estrutura mnima
                $("atributo",xml).each(function(index, item){

                    $("#tabAtributos").append("<tr valign=\"middle\">\
                                                    <td colspan='2' align='center'>\
                                                     <div class='atributoMinimo' style='margin-right: 10px;border-bottom:black solid thin;'>"+
                        $(item).find("nome").text()+
                        "</div>"+
                        "<input type=\"hidden\" name=\"atributos_ids\" value=\""+
                        $(item).find("id").text()+"\">"+
                        "</td>"+
                        "</tr>");

                    //Tira o atributo do combo para não ser inserido duas vezes
                    esconde($(item).find("id").text())
                });

                setTimeout(function(){
                    $("#frmCadEstrDivLoadingEst").hide();
                }, 100);

            }else{
                alert('Erro ao carregar...!');
            }
        });
    }
    function esconde(id){
        //Adiciona no array o objeto.
        //dica retirada de: http://jquery-howto.blogspot.com/2009/02/how-to-get-full-html-string-including.html
        arrayEscondidos.push($("#frmCadEstrutCmbSelAtributo option[value="+id+"]").get(0));

        $(arrayVisiveis).each(function(index, item){
            if($(item).attr("value")==id){
                arrayVisiveis.splice(index, 1);
            }
        });
        //remove do codigo HTML o objeto. (Esconde)
        $("#frmCadEstrutCmbSelAtributo option[value="+id+"]").remove();
        //Atualiza os options visiveis

    }

    function mostra(id){
        if(id==null){
            $(arrayEscondidos).each(function(index,obj){
                mostra($(obj).attr("value"));
            });

        }else{

            //Pesquisa no array de objetos onde esta o id para incluir no combo box frmCadEstrutCmbSelAtributo
            $(arrayEscondidos).each(function(index,obj){
                //Se o atributo tiver o id procurado...
                if($(obj).attr("value") == id){
                    //...Adiciona ele como option no combo box.
                    $(obj).removeAttr("selected");
                    $("#frmCadEstrutCmbSelAtributo").append(obj);

                    //Elimina o objeto da arrayDeObjetos escondidos
                    arrayEscondidos.splice(index, 1);
                    arrayVisiveis.push(obj);
                }
            });
            //Atualiza os options visiveis
            //arrayVisiveis=$.makeArray($("#frmCadEstrutCmbSelAtributo option"));

        }

    }



    function func_incluiAtributo(){

        if($('#frmCadEstrutCmbSelAtributo option:selected').length>0){
            //Armazena na variavel selecao o objeto selecionado no combo box do formulario.
            var selecao=$("#frmCadEstrutCmbSelAtributo option:selected");
            //Adiciona uma linha na tabela da estrutura do atributo com um campo hidden de input para passagem
            //de header da página
            $("#tabAtributos").append("\
            <tr id=\"atributo_"+selecao.val()+"\">"+
                "<td width=\"80%\" class=\"atributoAdicional\" align=\"center\">"+
                "<input type=\"hidden\" name=\"atributos_ids\" value=\""+
                selecao.val()+"\">"+
                selecao.text()+
                "</td>"+
                "<td width=\"20%\" align=\"center\">"+
                "<a href=\"javascript:func_removeAtributo(\'"+selecao.val()+"\')\">"+
                "["+
                "<img src=\"images/222222_11x11_icon_minus.gif\" border=\"none\" >&nbsp;"+
                "] Remover"+
                "</a>"+
                "</td></tr>");
            //esconde o objeto <option> selecionado acima do combo box frmCadEstrutCmbSelAtributo.
            esconde($(selecao).attr("value"));
        }
        $("#tabAtributos").sortable({items: 'tr:has(td.atributoAdicional)',cursor: "move"});
        $("#tabAtributos tr:has(td.atributoAdicional)").css("cursor", "pointer");

    }
    function ordenarCombo(){
        //Ordena as tags "option" dentro do combo seleciona atributo.
        $("#frmCadEstrutCmbSelAtributo>option").tsort();

    }

    function func_removeAtributo(cod_atrib){
        $("#atributo_"+cod_atrib).remove();
        mostra(cod_atrib);
        ordenarCombo();
    };

    function filtraCombo(){
        $("#frmCadEstrutCmbSelAtributo option").remove();
        $(arrayVisiveis).each(function(indice, elemento){
            if($(elemento).text().toUpperCase().indexOf($("#frmCadEstruturaTxtBusca").val().toUpperCase(), 0)>=0){
                $("#frmCadEstrutCmbSelAtributo").append(elemento);
            }
        });
        ordenarCombo();
    }
    function func_move(id,tipo){

        if (tipo=='up'){
            atributo_acima=$("#atributo_"+id).prev("tr :has(td.atributoAdicional)");
            atributo=$('#atributo_'+id);
            atributo.insertBefore(atributo_acima);
        }else if(tipo=='down'){
            atributo_acima=$("#atributo_"+id).next("tr :has(td.atributoAdicional)");
            atributo=$('#atributo_'+id);
            atributo.insertAfter(atributo_acima);
        }


    }

    $(document).ready(function(){

        $.post("readSessionServlet", {nome: "codEstrutura"}, function(dados){
            getAtributosDeEstrutura(dados);
        },"text");

        $.post("readSessionServlet", {nome: "tabAtributos"}, function(dados){
            alert($(dados).find("tbody"));

        },"text");


        $("#linkProximo").click(function(){
            $.post("writeSessionServlet", {tabAtributos: $("#tabAtributos").parent().html() }, null);
            //alert($("#tabAtributos").parent().html());
        });

    });
</script>

<!--Inicio do formulário-->
<table id="frmCadEstrutFormulario" border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <!--Menu do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            <b>Passos:</b>&nbsp;
            <a href="frmCadEstruturaStep1.jsp">Dados da estrutura</a>&nbsp;>&nbsp;
            <a href="frmCadEstruturaStep2.jsp">Tipo de estrutura</a>&nbsp;>&nbsp;
            <a href="#">Definição dos Atributos</a>
        </td>
    </tr>
    <!--Fim do menu do Wizard-->

    <tr>
        <td align="center" style="padding-top:20px">
            <!--Conteudo-->
            <fieldset style="background-color:#eeeeee;width:90%">
                <legend class="legend">Escolha dos atributos:</legend>

                <table class="ui-corner-tl" border="0" cellpadding="0" cellspacing="0" width="300">

                    <tr bgcolor="#3d414c">
                        <td colspan="2" align="center" style="color:#ffffff; font-size:medium;">Estrutura</td>
                    </tr>
                    <tr bgcolor="#3d414c">
                        <td style="color:#ffffff; font-size:small;"></td>
                        <td style="color:#ffffff; font-size:small" width="20%"></td>
                    </tr>
                    <tbody id="tabAtributos">

                    </tbody>
                </table>
            </fieldset>
            <fieldset style="background-color:#eeeeee;width:90%">
                <legend class="legend">Selecionar atributos:</legend>
                <table width="100%" style="background-color:#eeeeee;">
                    <tr>
                        <td align="right">
                            Buscar Atributo:
                        </td>
                        <td>
                            <input id="frmCadEstruturaTxtBusca" type="text" class="edit" style="width: 250px" onkeyup="filtraCombo();"></input>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Atributo:
                        </td>
                        <td>
                            <select class="select_varias_linhas" size="8" style="width: 250px" id="frmCadEstrutCmbSelAtributo" ondblclick="func_incluiAtributo();">
                                <%for (Atributo t : atributos) {%>
                                <option  value ="<%= t.getCd_atributo_obj()%>" title="<%= t.getDs_atributo_obj()%>" ><%= t.getNm_atributo_obj()%></option>
                                <% }%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <a onclick="" href="javascript:func_incluiAtributo();"><img src="images/add.gif" border="none">Adicionar à estrutura</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                    </tr>
                </table>
            </fieldset>
            <!--Fim conteudo-->
        </td>
    </tr>
    <tr>
        <td>
            <table align="center" border="0" width="92%" style="background-color:#ffffff;">
                <tr>
                    <!--Botao Retornar Passo-->
                    <td align="left" style="padding-top:10px;padding-bottom:10px">
                        <div align="left" style="width:100%">
                            <a id="linkRetorna" class="navProximo ui-widget-header" href="frmCadEstruturaStep2.jsp">
                                <span>
                                    <span class="ui-icon ui-icon-circle-arrow-w" style="display:inline-block;vertical-align:middle"></span>
                                    Retornar
                                </span>
                            </a>
                        </div>
                    </td>
                    <!--Botao Avançar Passo-->
                    <td align="right" style="padding-top:10px;padding-bottom:10px">
                        <div align="right" style="width:100%">
                            <a id="linkProximo" class="navProximo ui-widget-header" hreff="frmCadEstruturaStep4.jsp">
                                <span>
                                    Finalizar
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
<!--Fim do formulário-->

<div style="display:block;" id="frmAlert">

</div>

<%@include file="rodape.jsp"%>