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

<script type="text/javascript" language="javascript">
    //Declara um array de objetos.Ela sera usada para marcos os <option>s que serao escondidos do combo box.
    var arrayEscondidos = new Array();
    var arrayVisiveis = new Array();
    var htmltabelaEstrutura="";

    function show_CadastraAtributo(){
        $(document).scrollTop(0);
        $("#divfrmCadAtributo").dialog('open');
    }



    function show_CadastraTipo(){
        $(document).scrollTop(0);
        $("#divfrmCadTipo").dialog('open');
    }

    function show_PesqEstrutura(){
        $(document).scrollTop(0);
        $("#divfrmPesqEstrutura").dialog('open');
    }

    //Na inicializacao da pagina...
    function informa(Texto, Titulo){
        $("#alertPadrao").dialog('option','title',Titulo);
        $("#alertPadrao").html(Texto);
        $(document).scrollTop(0);
        $("#alertPadrao").dialog("open");
    }

    function getTipos(){
        $("#frmCadAtributoSelTipo option").remove();
        $.post('GetTiposServlet',null,function(xml){
            $(xml).find("tipo").each(function(indice, item){
                $("#frmCadAtributoSelTipo").append("<option value='"+
                    $(item).find("cod").text()+"'>"+
                    $(item).find("nome").text()+
                    "</option>");
            });
            $("#frmCadAtributoSelTipo").append(
            "<option value='-1' style='background:#eeeeee'>"+
                "Cadastrar novo tipo..."+
                "</option>");
        });
    }

    function pesqEstruturas(){
        $("#frmPesqEstruturasTabResult").empty();
        $.post("GetEstruturasServlet", {nome: $("#frmPesqEstruturasTxtNome").val()}, function(xml,status){
            if(status=="success"){
                $(xml).find("Estrutura").each(function(indice,item){
                    $("#frmPesqEstruturasTabResult").append(
                        "<tr>"+
                        "<td>"+
                        "<input name='PesqEstruturas' type='radio' id='frmPesqEstruturasRadio'>"+
                        $(item).find("Nome").text()+
                        "<div style='display:block; position:static'  class='ui-icon ui-icon-circlesmall-plus' />"+
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

    $(document).ready(function(){

        $("#alertInsAtrib").dialog({autoOpen: false});
        $("#linkAbreCadastroAtributo").click(function(){show_CadastraAtributo()});

        $("#divfrmCadAtributo").dialog({
            width: 511,
            modal: true,
            autoOpen: false,
            buttons: {
                Cancelar: function() {
                    $(this).dialog('close');
                },
                Cadastrar: function() {
                    var relacionavel;
                    if($("#frmCadAtributoChkRel").is(":checked")){
                        relacionavel="S";
                    }else{
                        relacionavel="N";
                    }

                    if($("#frmCadAtributoTxtNome").val()==""){
                        informa("Nome não preenchido", "Erro");
                        $("#frmCadAtributoTxtNome").focus();
                    }else if($("#frmCadAtributoTxtDesc").val()==""){
                        informa("Descrição não preenchida", "Erro");
                        $("#frmCadAtributoTxtDesc").focus();
                    }else if($("#frmCadAtributoSelTipo").val()=="" || $("#frmCadAtributoSelTipo").val()=="-1"){
                        informa("Tipo de atributo não selecionado", "Erro");
                    }else{
                        var nome=$("#frmCadAtributoTxtNome").val();
                        var desc=$("#frmCadAtributoTxtDesc").val();
                        var cod_atrib;

                        $.post("CadAtributoServlet",{
                            nome:   $("#frmCadAtributoTxtNome").val(),
                            descricao: $("#frmCadAtributoTxtDesc").val(),
                            codTipo: $("#frmCadAtributoSelTipo").val(),
                            relac: relacionavel
                        } , function(dados, msgstatus){
                            if(msgstatus=="success"){
                                cod_atrib=$(dados).find("codAtrib").text();
                                funcIncluiAtributoDisponivel(nome, desc, cod_atrib);
                                informa($(dados).find("mensagem").text() , "Cadastro");
                                $("#divfrmCadAtributo").dialog("close");
                            }
                        });
                    }
                }
            },
            close: function(){
                $("#frmCadAtributoTxtNome").val("");
                $("#frmCadAtributoTxtDesc").val("");
                $("#frmCadAtributoSelTipo:selected").removeAttr("selected");
                $("#frmCadAtributoSelTipo:first").attr("selected","selected");
                $("frmCadAtributoSelTipo").removeAttr("checked");
            },
            open: function(){
                getTipos();
            }
        });

        $("#divfrmCadTipo").dialog({
            width: 511,
            modal: false,
            autoOpen: false,
            buttons: {
                Cancelar: function() {
                    $("#divfrmCadTipo").dialog('close');
                },
                Cadastrar: function() {
                    if($("#frmCadTipoTxtNome").val()==""){
                        informa("Nome não preenchido", "Erro")
                    }else{
                        $.post("CadTipoServlet",{
                            nome:   $("#frmCadTipoTxtNome").val(),
                            expreg: $("#frmCadTipoTxtExpReg").val()
                        } , function(dados, msgstatus){
                            if(msgstatus=="success"){
                                getTipos();
                                informa(dados, "Cadastro");
                                $("#divfrmCadTipo").dialog('close');
                            }
                        });
                    }
                }
            },
            close: function(){
                $("#frmCadTipoTxtNome").val("");
                $("#frmCadTipoTxtExpReg").val("");
            }
        });
        $("#frmCadTipoTxtExpReg").keyup(function(){
            //$("#frmCadTipoTxtTesteExpReg").filter(function(){
            $("#frmCadTipoTxtExpReg").removeClass("erroRG");

            $("#frmCadTipoTxtTesteExpReg").keyup(function(){
                try{
                    var txtRG=new RegExp($("#frmCadTipoTxtExpReg").val());
                    var txtTest=$("#frmCadTipoTxtTesteExpReg").val();

                    if(!txtTest.match(txtRG)){
                        $("#frmCadTipoTxtTesteExpReg").addClass("erroRG");
                    }else{
                        $("#frmCadTipoTxtTesteExpReg").removeClass("erroRG");
                    }
                }catch(e){
                    $("#frmCadTipoTxtExpReg").addClass("erroRG");
                }
            });

            $("#frmCadTipoTxtTesteExpReg").keyup();

        });


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
                    getAtributosDeEstrutura();
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
            $.post("CadEstruturaServlet", {
                nm_estrutura: $("#frmCadEstrNome").val(),
                ds_estrutura: FCKeditorAPI.GetInstance('frmCadEstruturaDescricao').GetXHTML() ,
                tp_estrutura: $("#frmCadEstrTipo").val()
            }, function(data, txtStatus){
                informa(data, "Retorno do Servlet");
            });
        });

        $("#alertPadrao").dialog({
            autoOpen: false,
            modal: false,
            buttons: {
                Ok: function(){
                    $(this).dialog("close");
                }
            }
        });



        //Esconde o formulario para cadastro de tipos
        //$("#divbckCadAtributo, #divfrmCadAtributo").hide();
        //$("#divbckCadTipo, #divfrmCadTipo").hide();



        //Valor inicial do combo de TIPO de ESTRUTURA
        $("#frmCadEstrTipo").val(0);
        //Atribui funcao ajax ao objeto frmCadEstrTipo
        $("#frmCadEstrTipo").change(function(){
            if( $("#frmCadEstrTipo").val() == "PA" || $("#frmCadEstrTipo").val() == "AP" || $("#frmCadEstrTipo").val() == "PE"){
                getAtributosDeEstrutura();
            }else if($("#frmCadEstrTipo").val()==-1){
                $("#tabAtributos").html("");
                show_PesqEstrutura();
                //$("#divfrmPesqEstrutura").dialog('open');
            }
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


        //Evento de clique para abrir a janela de cadastro de tipos


        $("#frmCadAtributoSelTipo").change(function(){
            if($("#frmCadAtributoSelTipo option:selected").attr("value")=="-1"){
                show_CadastraTipo();
            }
        });
        //FIM Janela de CADASTRO DE TIPOS

        //Fim de document.ready
    });

    function getAtributosDeEstrutura(){

        //Mostra todos atributos
        mostra(null);
        var cod_Estrutura;
        if($("#frmCadEstrTipo").val()=="PA"){
            cod_Estrutura=<%=patternID%>
        }else if($("#frmCadEstrTipo").val()=="AP"){
            cod_Estrutura=<%=antiPatternID%>
        }else if($("#frmCadEstrTipo").val()=="PE"){
            cod_Estrutura=<%=personaID%>
        }else{
            cod_Estrutura=$("#frmPesqEstruturasRadio:checked").data("Cod");
        }

        $.post("GetAtribDeEstrutServlet", {codestr: cod_Estrutura}, function(xml,status){

            $("#frmCadEstrDivLoadingEst").show();

            if(status=="success"){

                //Tratamento dos dados recebidos
                $("#tabAtributos").html(htmltabelaEstrutura);
                //Retorno para estrutura mnima
                $("atributo",xml).each(function(index, item){

                    $("#tabAtributos").append("<tr valign=\"middle\">\
                                                    <td colspan='2' align='center'>\
                                                     <div class='atributoMinimo' style='margin-right: 10px;border-bottom:black solid thin;'>\
                                                       "+$(item).find("nome").text()+"</div></td></tr>");

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

    function funcIncluiAtributoDisponivel(Nome, Descricao, ID){
        $("#frmCadEstrutCmbSelAtributo:selected").removeAttr("selected");
        $("#frmCadEstrutCmbSelAtributo").append("<option selected value='"+ID+"' title='"+Descricao+"'>"+Nome+"</option>");
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
                <legend><b>Escolha da estrutura:</b></legend>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto">Nome da estrutura:</font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadEstrNome" class="edit" type="text" size="27"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>

                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto">Tipo de Estrutura:</font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div style="margin-left: 5px;display:inline">
                                <select class="edit" id="frmCadEstrTipo" name="frmCadEstrTipo" style="height: 2em;"  maxlength="30" title="Escolha o tipo de Estrutura">
                                    <option value="-2" selected>Escolha um tipo de estrutura</option>
                                    <option value="PA">Pattern</option>
                                    <option value="AP">Anti-Pattern</option>
                                    <option value="PE">Persona</option>
                                    <option value="-1" style="background: #EEEEEE" >Importar de Estrutura Existente...</option>
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
                        <td valign="top" width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto">Descri&ccedil;&atilde;o:</font>
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

                    <table class="ui-corner-tl"   border="0" cellpadding="0" cellspacing="0" width="300">
                        <tr bgcolor="#3d414c">
                            <td colspan="2" align="center" style="color:#ffffff; font-size:medium">Estrutura</td>
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
                    <font class="texto">Nome do atributo:</font>
                </td>
                <td align="center">
                    <input id="frmCadAtributoTxtNome" class="edit" type="text" size="35">
                </td>
            </tr>
            <tr>
                <td align="right"  valign="top">
                    <font class="texto">Descri&ccedil;&atilde;o do atributo:</font>
                </td>
                <td align="center">
                    <textarea id="frmCadAtributoTxtDesc" class="edit" cols="35" ></textarea>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <font class="texto">Tipo do atributo:</font>
                </td>
                <td align="center">
                    <select id="frmCadAtributoSelTipo" class="edit" style="width:200px;" >


                    </select>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <font class="texto">Relacion&aacute;vel:</font>
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
                    <font class="texto">Nome do Tipo:</font>
                </td>
                <td align="center">
                    <input id="frmCadTipoTxtNome" class="edit" type="text" size="35">
                </td>
            </tr>
            <tr>
                <td align="right"  valign="top">
                    <font class="texto">Expressão Regular:</font>
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
                <table id="frmPesqEstruturasTabResult" width="100%">
                    <tr class="ui-widget-header">
                        <td align="center" >
                            Resultado da busca
                        </td>
                    </tr>
                </table>
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

<%@include file="rodape.jsp"%>
