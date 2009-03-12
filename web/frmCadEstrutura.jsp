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
         * |  Tom Mix    |  27/02/09   |                                      |
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
        persona = pesqEstrutDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(0, "ersona", null, null, 0, null), null);
        antiPatternID = persona.size() > 0 ? persona.get(0).getCd_estrutura() : 0;
//Fecha conexão
        pesqEstrutDAO.fechaConexao();



%>

<%@include file="cabecalho.jsp"%>
<style>
    .formulario input, .select_uma_linha{
        height: 20px;
        font-size:small;
        background-color: #CCCCCC;

    }
    .select_uma_linha option{
        font-size: small;
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
</style>

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript">
    //Declara um array de objetos.Ela sera usada para marcos os <option>s que serao escondidos do combo box.
    var arrayEscondidos = new Array();
    var arrayVisiveis = new Array();
    var htmltabelaEstrutura="";
    //Na inicializacao da pagina...
    $(document).ready(function(){
        //Esconde o formulario para cadastro de tipos
        var oFCKeditor = new FCKeditor('frmCadEstruturaDescricao') ;
        oFCKeditor.BasePath = "./js/fckeditor/" ;
        oFCKeditor.Height=300;
        oFCKeditor.ReplaceTextarea() ;

        htmltabelaEstrutura=$("#tabAtributos").html();

        $("#formEscolheAtributos").hide();
        //Ordena o combo box cmbSelecionaAtributo.
        ordenarCombo();
        //Preenche o array com os options visiceis
        arrayVisiveis=$.makeArray($("#cmbSelecionaAtributo option"));
        //Esconde mensagem de Loading ajax
        $("#frmCadEstrDivLoadingEst").hide();
        $(document).ajaxError(function(msg,msg1,msg2,msg3){
            alert("erro"+msg1);
        });
        //Atribui funcao ajax ao objeto frmCadEstrTipo
        $("#frmCadEstrTipo").change(function(){
            if( $("#frmCadEstrTipo").val() > -1){
                getAtributos()
            }else{
                $("#tabAtributos").html("");
            }
        });


        //Fim de document.ready
    });

    function getAtributos(){

        var cod_Atributo=$("#frmCadEstrTipo").val();

        $.post("GetAtribDeEstrut", {codatrib: cod_Atributo}, function(xml,status){

            $("#frmCadEstrDivLoadingEst").show("normal");

            if(status=="success"){

                //Tratamento dos dados recebidos
                $("#tabAtributos").html(htmltabelaEstrutura);
                $("atributo",xml).each(function(index, item){
                    $("#tabAtributos").append("<tr valign=\"middle\">\
                                                    <td colspan='2' align='center'>\
                                                     <div class='atributoMinimo' style='margin-right: 10px;border-bottom:black solid thin;'>\
                                                       "+$(item).text()+"</div></td></tr>");

                });
                $("#frmCadEstrDivLoadingEst").hide("normal");
            }else{
                alert('Falhei!');
            }
        });

        //fim de frmCadEstrTipo.change
    }

    //Esconde um objeto. O parametro obj sera usado para passagem de um <option> do cmbSelecionaAtributo
    function esconde(obj){
        //Adiciona no array o objeto.
        arrayEscondidos.push(obj);
        //remove do codigo HTML o objeto. (Esconde)
        $(obj).remove();
        //Atualiza os options visiveis
        arrayVisiveis=$.makeArray($("#cmbSelecionaAtributo option"));
    }

    function mostra(id){
        //Pesquisa no array de objetos onde esta o id para incluir no combo box cmbSelecionaAtributo
        $(arrayEscondidos).each(function(index,obj){
            //Se o atributo tiver o id procurado...
            if($(obj).attr("value") == id){
                //...Adiciona ele como option no combo box.
                $(obj).removeAttr("selected");
                $("#cmbSelecionaAtributo").append(obj);

                //Elimina o objeto da arrayDeObjetos escondidos
                arrayEscondidos.splice(index, 1);
            }
        });
        //Atualiza os options visiveis
        arrayVisiveis=$.makeArray($("#cmbSelecionaAtributo option"));
    }

    function func_desceAtrib(idAtributo){
        // $("#atributo_"+idAtributo);
    }

    function func_incluiAtributo(){
        if($('#cmbSelecionaAtributo option:selected').length>0){
            //Armazena na variavel selecao o objeto selecionado no combo box do formulario.
            var selecao=$("#cmbSelecionaAtributo option:selected");
            //Adiciona uma linha na tabela da estrutura do atributo com um campo hidden de input para passagem
            //de header da página
            $("#tabAtributos").append("<tr id=\"atributo_"+selecao.val()+"\">\n\
            <td width=\"80%\" class=\"atributoAdicional\" align=\"center\">\n\
                <input type=\"hidden\" name=\"atributos_ids\" value=\""+
                selecao.val()+"\">"+
                selecao.text()+
                "</td><td width=\"20%\" align=\"center\"><a href=\"javascript:func_removeAtributo(\'"+selecao.val()+"\')\">\
            <img src=\"images/222222_11x11_icon_minus.gif\" border=\"none\" ></a></td></tr>");
            //esconde o objeto <option> selecionado acima do combo box cmbSelecionaAtributo.
            esconde(selecao);
        }
    };

    function ordenarCombo(){
        //Ordena as tags "option" dentro do combo seleciona atributo.
        $("#cmbSelecionaAtributo>option").tsort();

    }

    function func_removeAtributo(cod_atrib){
        $("#atributo_"+cod_atrib).remove();
        mostra(cod_atrib);
        ordenarCombo();
    };

    function filtraCombo(){
        $("#cmbSelecionaAtributo option").remove();
        $(arrayVisiveis).each(function(indice, elemento){
            if($(elemento).text().toUpperCase().indexOf($("#txtBusca").val().toUpperCase(), 0)>=0){
                $("#cmbSelecionaAtributo").append(elemento);
            }
        });
        ordenarCombo();
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
                                Nome da estrutura:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input class="edit" type="text" size="20"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <div style="margin-right: 10px;">
                                Descri&ccedil;&atilde;o:
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <div  style="margin-left: 5px;">
                                <textarea id="frmCadEstruturaDescricao"></textarea>
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
                                Tipo de Estrutura:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <select class="select_uma_linha" id="frmCadEstrTipo" name="frmCadEstrTipo" style="height: 2em;" width="150px" maxlength="30" title="Escolha o tipo de Estrutura">
                                    <option value="-1" selected>Escolha um tipo de estrutura</option>
                                    <option value="<%= patternID%>">Pattern</option>
                                    <option value="21">Anti-Pattern</option>
                                    <option value="22">Persona</option>
                                    <option value="-2" style="background: #EEEEEE" onclick="alert('Aqui abre janela para procurar por estruturas existentes')" >Importar de Estrutura Existente...</option>
                                </select>
                            </div>
                            <div id="frmCadEstrDivLoadingEst">
                                <img src="/sigepapp/images/aguardep.gif" style="vertical-align:bottom;">Carregando estrutura...
                            </div>
                        </td>

                    </tr>

                </table>
            </fieldset>

            <!-- Inicio da customizacao de atributos -->
            <fieldset style="width: 500px;">
                <legend><b>Escolha dos atributos:</b></legend>
                <form action="frmCadEstrutura.jsp" method="get">
                    <table  id="tabAtributos" border="0" cellpadding="0" cellspacing="0" width="300">
                        <tr bgcolor="#3d414c">
                            <td colspan="2" align="center" style="color:#ffffff; font-size:medium">Estrutura</td>
                        </tr>
                        <tr bgcolor="#3d414c">
                            <td style="color:#ffffff; font-size:small">Nome do atributo</td>
                            <td style="color:#ffffff; font-size:small" width="20%"></td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0" width="500">
                        <tr id="linhaDoSeletor">
                            <td colspan="2" width="30%" align="center">
                            <div style="margin-right: 10px;">

                                <br>
                                <fieldset style="background-color:#eeeeee;">
                                    <legend>Selecionar atributos:</legend>
                                    <table width="300" style="background-color:#eeeeee;">
                                        <tr>
                                            <td align="right">
                                                Busca de Atributo:
                                            </td>
                                            <td>
                                                <input id="txtBusca" type="text" style="width: 145px" onkeyup="filtraCombo();"></input>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Atributo:</td><td>
                                                <select class="select_varias_linhas" size="8" style="width: 150px" id="cmbSelecionaAtributo" ondblclick="func_incluiAtributo();">
                                                    <%for (Atributo t : atributos) {%>
                                                    <option  value ="<%= t.getCd_atributo_obj()%>" title="<%= t.getDs_atributo_obj()%>" ><%= t.getNm_atributo_obj()%></option>
                                                    <% }%>
                                                </select>
                                        </td></tr>
                                        <tr><td colspan="2" align="center">
                                                <a onclick="" href="javascript:func_incluiAtributo();"><img src="images/add.gif" border="none">Adicionar</a>
                                        </td></tr>
                                        <tr><td colspan="2"></td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>


                        </tr>
                        <tr>
                            <td colspan="2"><a href="#" onclick="javascript: $('#formEscolheAtributos').show('normal');"><img src="images/add.gif" border="none">Adicionar novo atributo</a></td>
                        </tr>
                    </table>
                    <input class="botao" style="background-color:#3d414c;" type="submit" value="enviar">
                </form>
            </fieldset>

        </td>
    </tr>
</table>

<div id="formEscolheAtributos" style="position: absolute; left: 50%; top: 50%; background-color:silver; width: auto;">
    <div align="right" style="background-color:#3d414c"><a style="height:5px" onclick="$('#formEscolheAtributos').hide();" href="#"><img border="nome" src="images/fechar.gif"/></a></div>
    <br>
    <fieldset>
        <legend>Selecionar atributos:</legend>
        <table width="300">
            <tr><td align="center">Busca de Atributo:</td><td><input type="text" style="width: 145px"></input></td></tr>
            <tr><td>Atributo:</td><td>
                    <select size="8" style="width: 150px">
                        <option>At1</option>
                        <option>At2</option>
                        <option>At3</option>
                        <option>At4</option>
                    </select>
            </td></tr>

            <tr><td colspan="2" align="center">Ou crie um atributo novo:</td></tr>
            <tr><td>Nome:</td><td><input type="text"></input></td></tr>
            <tr><td>Descri&cedil;&atilde;o:</td><td><input type="text"></input></td></tr>
            <tr><td>Tipo:</td>
                <td><select id="frmCadAtribTipo" name="frmCadAtribTipo" class="edit" width="100px" maxlength="50" title="Escolha o tipo de dados do atributo">
                        <option label="" >data</option>
                        <option label="" >numero</option>
                        <option label="" >texto</option>
                        <option label="" style="background: #EEEEEE" onclick="alert('Aqui abre janela para procurar por estruturas existentes')" >Novo atributo</option>
                    </select>
                    <a onclick="alert('Adiciona o novo atributo e inclui')" href="#"><img src="images/add.gif" border="none">Adicionar</a>
            </td></tr>
            <tr><td colspan="2"></td>
            </tr>
        </table>
    </fieldset>
</div>
<%@include file="rodape.jsp"%>
