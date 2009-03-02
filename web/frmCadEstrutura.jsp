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
         * |  Tom e Gui  |  09/02/25   | Definicao do Cadastro                |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/26   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  09/02/27   |                                      |
         * |------------------------------------------------------------------|
         **/
AtributoDAO atributoDAO=new AtributoDAO();
Collection<Atributo> atributos;
atributos=atributoDAO.seleciona("select * from APPP_TB_ATRIBUTO_OBJ");
%>

<%@include file="cabecalho.jsp"%>
<style>
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
        
        vertical-align:middle;
    }
    .atributoAdicional img{
        vertical-align:middle;
    }
    .atributoMinimo{

    }
</style>

<script type="text/javascript" language="javascript">
    var nro_atributos;
    $(document).ready(function(){
        $("#formEscolheAtributos").hide();
        nro_atributos=0;
    });

    function func_incluiAtributo(){
        //Armazena na variavel selecao o objeto selecionado no combo box do formulario.
        var selecao=$("#cmbSelecionaAtributo option:selected");
        //Adiciona na tabela de atributos o atributo selecionado no combo.O id da
        $("#tabAtributos").append("<tr id=\"atributo_"+selecao.val()+"\">\n\
            <td width=\"50%\" class=\"atributoAdicional\" align=\"right\">\n\
                <input type=\"hidden\" name=\"atributos_ids\" value=\""+
            selecao.val()+"\">"+
            selecao.text()+
            "</td><td width=\"50%\" align=\"left\"><a href=\"javascript:func_removeAtributo(\'"+selecao.val()+"\')\">\
            <img src=\"images/remover.gif\" border=\"none\" ></a></td></tr>");
        selecao.hide();
        selecao.attr("disabled","disabled");
        selecao.removeAttr("selected");
        nro_atributos++;
        guardaOption("teste");
        guardaOption("tteste2");
        
    };
    var objetos=new Array;
    var i=0;
    function guardaOption(id){
        objetos.push(id);
        i++;
    }
    function retornaOption(id){
        objetos.slice(id, 1);
        return "paseei";
    }

    function func_removeAtributo(cod_atrib){

        //$("#atributo_"+cod_atrib).hide()
        $("#atributo_"+cod_atrib).remove();

        $("#cmbSelecionaAtributo option[value='"+cod_atrib+"']").show("normal").removeAttr("selected").removeAttr("disabled");
        nro_atributos--;
    }

    function filtraCombo(){
        
        var texto=$("#txtBusca").val().toLowerCase();
        $("#cmbSelecionaAtributo option:enabled").hide();
        $("#cmbSelecionaAtributo option:enabled").each(function(index,elemento){
            if($(elemento).text().toLowerCase().indexOf($("#txtBusca").val().toLowerCase(), 0)>=0){
                $(elemento).show();
            }
        });
        //$("#cmbSelecionaAtributo option:contains('"+$("#txtBusca").val()+"')").show("normal");
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
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Descri&ccedil;&atilde;o:
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
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Tipo de Estrutura:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <select class="select_uma_linha" id="frmCadEstrTipo" name="frmCadEstrTipo" style="height: 1.5em;" width="150px" maxlength="30" title="Escolha o tipo de Estrutura">
                                    <option label="" >Pattern</option>
                                    <option label="" >Anti-Pattern</option>
                                    <option label="" >Persona</option>
                                    <option label="" style="background: #EEEEEE" onclick="alert('Aqui abre janela para procurar por estruturas existentes')" >Importar de Estrutura Existente...</option>
                                </select>
                            </div>
                        </td>

                    </tr>

                </table>
            </fieldset>

            <!-- Inicio da customizacao de atributos -->
            <fieldset style="width: 500px;">
                <legend><b>Escolha dos atributos:</b></legend>
                <form action="frmCadEstrutura.jsp" method="get">
                    <table  id="tabAtributos" border="0" cellpadding="0" cellspacing="0" width="500">
                        <tr>
                            <td colspan="2" width="30%" align="center">
                                <div style="margin-right: 10px;">
                                    Nome
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="2" width="30%" align="center">
                                <div style="margin-right: 10px;">
                                    Contexto
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td></td>
                        </tr>

                        <tr>
                            <td colspan="2" width="30%" align="center">
                            <div style="margin-right: 10px;">
                                Problema
                            </div>


                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td></td>
                        </tr>

                        <tr>
                            <td colspan="2" width="30%" align="center">
                            <div style="margin-right: 10px;">
                                Solu&ccedil;&atilde;o
                            </div>
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
                                                    <%for (Atributo t : atributos) {  %>
                                    <option label="" value="<%=t.getCd_atributo_obj() %>" title="<%=t.getDs_atributo_obj() %>" ><%=t.getNm_atributo_obj() %></option>
                                    <%}%>
                                                </select>
                                        </td></tr>
                                        <tr><td colspan="2" align="center">
                                                <a onclick="" href="javascript:if($('#cmbSelecionaAtributo option:selected').length>0){func_incluiAtributo();}"><img src="images/add.gif" border="none">Adicionar</a>
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
                    <input type="submit" value="enviar">Enviar
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
