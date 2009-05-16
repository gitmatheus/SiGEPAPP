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
<% if (request.getSession().getAttribute("codigo_usuario") != null && request.getSession().getAttribute("codigo_usuario") != "0") {%>

<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<style type="text/css">
    .formulario input, .select_uma_linha{
        height: 20px;
        font-size:small;
        background-color: #CCCCCC;

    }

    .select_varias_linhas, .select_varias_linhas option{
        font-size:small;
        background-color: #CCCCCC;

    }

    .atributoAdicional{
        height: 2em;
        font-weight:bold;
        font-size:small;
        vertical-align:middle;
    }
    .atributoAdicional img{
        vertical-align:middle;
    }
    .atributoMinimo{
        font-size:small;
        height:2em;
        vertical-align:middle;
    }

    #divfrmCadAtributo td, #divfrmCadTipo td {
        font-size:small;
    }
    #divfrmCadAtributo table, #divfrmCadTipo table{
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
    }
    #divfrmCadAtributo table tr td, #divfrmCadTipo table tr td{
        line-height:2em;
    }

    #divfrmCadAtributo h1, #divfrmCadTipo h1{
        font-size:medium;
    }

    .ui-widget-overlay {
        background: #aaaaaa url(../images/ui-bg_flat_0_aaaaaa_40x100.png) 50% 50% repeat-x;
        opacity: .80;
    }
    .erroRG{
        background-color:#ff3333;
    }

</style>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadEstrutura.js"></script>

<script type="text/javascript" language="javascript">
    //Declara um array de objetos.Ela sera usada para marcos os <option>s que serao escondidos do combo box.
    var arrayEscondidos = new Array();
    var arrayVisiveis = new Array();
    var htmltabelaEstrutura="";

    function valida_desc(){

        //Verifica se o nome da estrutura é vazio
        var descricao=FCKeditorAPI.GetInstance('frmCadEstruturaDescricao').GetXHTML();
        if($.trim(descricao)!=""){
            $("#divMsgCadEstrutDesc").hide();
            return true;
        }else{
            $("#tagDescricao").attr("style", "color: #822007;display:inline-block");
            $("#divMsgCadEstrutDesc").html("<img src='images/uncheck.png'>&nbsp;Preencha a Descri&ccedil;&atilde;o da estrutura.");
            $("#divMsgCadEstrutDesc").show();
            return false;
        }

    }
    function valida_nome(){
        var msg=validaNome();
        if(msg!=null){
            $("#frmCadEstrutNome").attr("style", "border-color: #822007; background-color: #ee957f;color: #822007;display:inline-block");
            $("#divMsgCadEstrutNome").html("<img src='images/uncheck.png'>"+msg);
            $("#divMsgCadEstrutNome").show();
            $("#frmCadEstrutNome").select();
            return false;
        }else{
            $("#frmCadEstrutNome").removeAttr("style");
            $("#divMsgCadEstrutNome").hide();
            return true;
        }
    }

    function valida_tipo(){
        if($("#frmCadEstrTipo").val()!="PA" && $("#frmCadEstrTipo").val()!="PE" && $("#frmCadEstrTipo").val()!="AP"){
            $("#divMsgCadEstrutTipo").html("<img src='images/uncheck.png'>Selecione um tipo de estrutura");
            $("#divMsgCadEstrutTipo").show();
            return false;
        }else{
            $("#divMsgCadEstrutTipo").hide();
            return true;
        }
    }

    function show_PesqEstrutura(){
        if($("#frmCadEstrTipo").val()==-2){
            $(document).scrollTop(0);
            $("#alertInsAtrib").dialog('open');
            $("#frmCadEstrTipo").focus();
        }else{
            $(document).scrollTop(0);
            $("#divfrmPesqEstrutura").dialog('open');
        }
    }

    function pesqEstruturas(){
        $("#frmPesqEstruturasTabResult").empty();
        $.post("GetEstruturasServlet", {nome: $("#frmPesqEstruturasTxtNome").val(), tipo: $("#frmCadEstrTipo").val() }, function(xml,status){
            if(status=="success"){
                $(xml).find("Estrutura").each(function(indice,item){
                    $("#frmPesqEstruturasTabResult").append(
                    "<tr>"+
                        "<td style='width:auto;'>"+
                        "<input name='PesqEstruturas' type='radio' value='"+$(item).find("Cod").text()+"' id='frmPesqEstruturasRadio'>"+
                        $(item).find("Nome").text()+
                        "</td>"+
                        "<td>"+
                        "<div style='' class='ui-icon ui-icon-circlesmall-plus' />"+
                        "</td>"+
                        "</tr>"+
                        "<tr id='detalhesEstrut"+$(item).find("Cod").text()+"'>"+
                        "<td colspan='2'>"+
                        /* TODO: implementar a visão da estrutura
                         */
                    "</td>"+
                        "</tr>"
                );
                    //alert($(item).find("Cod").text());
                    $("#frmPesqEstruturasTabResult input:radio:eq("+indice+")").data("Cod",$(item).find("Cod").text());
                    //alert($("#frmPesqEstruturasTabResult input:radio:eq("+indice+")").data("Cod"));

                });
            }
        });
    }
    //Na inicializacao da pagina...
    $(document).ready(function(){
        $("#divfrmPesqEstrutura").dialog({
            width: 511,
            modal: false,
            autoOpen: false,
            title: 'Busca de Estruturas',
            buttons: {
                Cancelar: function() {
                    $("#divfrmPesqEstrutura").dialog('close');
                },
                Importar: function() {
                    $("#divfrmPesqEstrutura").dialog('close');
                    getAtributosDeEstrutura($("input[name=PesqEstruturas]:checked").val());
                }
            },
            close: function(){
                $("#frmCadTipoTxtNome").val("");
                $("#frmCadTipoTxtExpReg").val("");
            },
            open: function(){
                $("#frmPesqEstruturasTabResult").empty();
                $("#frmPesqEstruturasTxtNome").val("");
                //getEstruturas();
            }
        });



        $("#frmCadEstruturaEnvia").click(function(){
            if(valida_nome()==true && valida_tipo()==true && valida_desc()==true ) {
                var atributosArray=new Array();
                $("input[name='atributos_ids']").each(function(indice,DOM){
                    atributosArray.push($(DOM).val());
                });
                $.post("CadEstruturaServlet",{
                    nm_estrutura: $("#frmCadEstrutNome").val(),
                    ds_estrutura: FCKeditorAPI.GetInstance('frmCadEstruturaDescricao').GetXHTML() ,
                    tp_estrutura: $("#frmCadEstrTipo").val(),
                    atributos: atributosArray
                }, function(data, txtStatus){
                    informa(data, "Retorno do Servlet");
                });
            }
        });





        //Esconde o formulario para cadastro de tipos
        //$("#divbckCadAtributo, #divfrmCadAtributo").hide();
        //$("#divbckCadTipo, #divfrmCadTipo").hide();



        //Valor inicial do combo de TIPO de ESTRUTURA
        $("#frmCadEstrTipo").val(0);
        //Atribui funcao ajax ao objeto frmCadEstrTipo
        $("#frmCadEstrTipo").change(function(){
            if($(this).val()!=-2){
                getAtributosDeEstrutura();
            }else{
                $("#tabAtributos").empty();
            }


            //$("#divfrmPesqEstrutura").dialog('open');

        });

        $("#frmPesqEstruturasButOk").click(function(){
            pesqEstruturas();
        });

        //Cria editor HTML
        var oFCKeditor = new FCKeditor('frmCadEstruturaDescricao') ;
        oFCKeditor.BasePath = "./js/fckeditor/" ;
        oFCKeditor.ToolbarSet="Sigepapp2";
        oFCKeditor.Height=300;
        oFCKeditor.ReplaceTextarea() ;
        htmltabelaEstrutura=$("#tabAtributos").html();

        //Ordena o combo box frmCadEstrutCmbSelAtributo.
        ordenarCombo();
        //Preenche o array com os options visiceis
        arrayVisiveis=$.makeArray($("#frmCadEstrutCmbSelAtributo option"));
        //Esconde mensagem de Loading ajax
        $("#frmCadEstrDivLoadingEst").hide();
        $(document).ajaxError(function(event, XMLHttpRequest, ajaxOptions, thrownError){
            alert("Erro ao enviar solicitação ao servidor.\nMande um e-mail para: sigepapp@sigepapp.com.br para mais informações.");
        });

        //Fim de document.ready
    });


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

        //fim de frmCadEstrTipo.change
    }

    //Esconde um objeto. O parametro obj sera usado para passagem de um <option> do frmCadEstrutCmbSelAtributo
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
        if($("#frmCadEstrTipo").val()==-2){
            $(document).scrollTop(0);
            $("#alertInsAtrib").dialog('open');
            $("#frmCadEstrTipo").focus();

        }else{
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
        };
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


</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro&nbsp;de&nbsp;Estruturas APPP ::..</font> </td>
    </tr>

    <tr>
        <td align="center">
            <br>
            <fieldset style="width: 500px">
                <legend><b>Dados da estrutura:</b></legend>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font>Nome da estrutura:</font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadEstrutNome" class="edit" type="text" size="27"/>
                                <div id="divMsgCadEstrutNome" style="display:inline-block;vertical-align:middle;"></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <div id="divMsgCadEstrutTipo" style="background-color:#ee957f;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Tipo de Estrutura:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div style="margin-left: 5px;display:inline">
                                <select class="edit" id="frmCadEstrTipo" name="frmCadEstrTipo" style="height: 2em;"  maxlength="30" title="Escolha o tipo de Estrutura">
                                    <option value="-2" selected>Escolha um tipo de estrutura</option>
                                    <option value="PA">Pattern</option>
                                    <option value="AP">Anti-Pattern</option>
                                    <option value="PE">Persona</option>

                                </select>
                            </div>
                            <img id="frmCadEstrDivLoadingEst"  src="/sigepapp/images/aguardep.gif" style="vertical-align:middle;">
                        </td>
                    </tr>

                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <div id="divMsgCadEstrutDesc" style="background-color:#ee957f;"></div>
                        </td>
                    </tr>

                    <tr>
                        <td valign="top" width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Descri&ccedil;&atilde;o:
                            </div>
                        </td>
                        <td align="center" colspan="2">
                            <div  style="margin-left: 5px;">
                                <textarea id="frmCadEstruturaDescricao"></textarea>
                            </div>
                        </td>
                    </tr>

                </table>
            </fieldset>

            <br><br>

            <!-- Inicio da customizacao de atributos -->
            <form action="frmCadEstrutura.jsp" method="get">
                <fieldset style="width: 500px;">
                    <legend><b>Escolha dos atributos:</b></legend>

                    <table class="ui-corner-tl" border="0" cellpadding="0" cellspacing="0" width="300">
                        <tr>
                            <td colspan="2" align="center" style="padding-bottom:5px;"><a href="javascript:show_PesqEstrutura();" style="color: #822007;" >Importar de estrutura existente...</a></td>
                        </tr>
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
                <table border="0" cellpadding="0" cellspacing="0" width="500">
                    <tr id="linhaDoSeletor">
                        <td colspan="2" width="30%" align="center">
                            <div style="margin-right: 10px;">

                                <br>
                                <fieldset style="background-color:#eeeeee;">
                                    <legend>Selecionar atributos:</legend>
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
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td align="left" colspan="2">
                            <a id="linkAbreCadastroAtributo" href="#">
                                <img src="images/add.gif" border="none">Criar novo atributo
                            </a>
                        </td>
                    </tr>
                </table>
                <input id="frmCadEstruturaEnvia" class="botao" style="background-color:#3d414c;" type="button" value="enviar">
            </form>
        </td>
    </tr>
</table>



<!--Janela para cadastro de ATRIBUTOS -->
<div id="divfrmCadAtributo" title="Cadastro de Atributo">
    <form id="frmCadAtributo">
        <table width="500">
            <tr>
                <td align="right">
                    Nome do atributo:
                </td>
                <td align="center">
                    <input id="frmCadAtributoTxtNome" class="edit" type="text" size="35">
                </td>
            </tr>
            <tr>
                <td align="right"  valign="top">
                    Descri&ccedil;&atilde;o do atributo:
                </td>
                <td align="center">
                    <textarea id="frmCadAtributoTxtDesc" class="edit" cols="35" ></textarea>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Tipo do atributo:
                </td>
                <td align="center">
                    <select id="frmCadAtributoSelTipo" class="edit" style="width:200px;" >


                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Relacion&aacute;vel:
                </td>
                <td align="center">
                    <input id="frmCadAtributoChkRel" type="checkbox">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                </td>
            </tr>
        </table>
    </form>
</div>



<!--Janela para cadastro de TIPOS -->
<div id="divfrmCadTipo" title="Cadastro de Tipos" >
    <form id="frmCadTipo">
        <table width="500">
            <tr>
                <td align="right">
                    Nome do Tipo:
                </td>
                <td align="center">
                    <input id="frmCadTipoTxtNome" class="edit" type="text" size="35">
                </td>
            </tr>
            <tr>
                <td align="right"  valign="top">
                    Expressão Regular:
                </td>
                <td align="center">
                    <textarea id="frmCadTipoTxtExpReg" class="edit" cols="35" ></textarea>
                </td>
            </tr>
            <tr>
                <td align="center">
                    Teste sua Expressão Regular:
                </td>
                <td align="center">
                    <input type="text" id="frmCadTipoTxtTesteExpReg" class="edit" cols="35">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                </td>
            </tr>
        </table>
    </form>
</div>

<!--Janela para Seleção de Estruturas-->
<div id="divfrmPesqEstrutura">
    <table width="100%">
        <tr>
            <td>Pesquisar estrutura:</td>
            <td><input class="edit" type="text" id="frmPesqEstruturasTxtNome">
                <input class="botao" type="button" id="frmPesqEstruturasButOk" value="Ok">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div style="overflow-y:scroll;height:250px;" >
                    <table cellpadding="0" cellspacing="0" id="frmPesqEstruturasTabResult">
                        <tr class="ui-widget-header">
                            <td colspan="2" align="center" >
                                Resultado da busca
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</div>

<!-- -->
<div id="alertInsAtrib" title="Erro ao inserir atributo">
    <p style="color:red" align="center"><font size="5"><b>Erro:</b></font></p>
    <p style="color:black">Antes de inserir atributos &eacute; necess&aacute;rio selecionar um tipo de estrutura.</p>
</div>
<div id="alertPadrao" title="Informação"></div>
<% } else {%>
<center>
    <h2>Cadastro de Estrutura</h2>
    <font class="texto">Este m&oacute;dulo cadastra estruturas do tipo Pattern, Anti-Pattern ou Personas para, posteriormente, serem utilizadas no módulo cadastro de APPP.</font>
    <p><small><font class="texto">Por favor, efetue o login no canto superior direito da p&aacute;gina</font></small></p>
</center>
<% }%>
<%@include file="rodape.jsp"%>
