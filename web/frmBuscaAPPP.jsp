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
         * |  Guilherme  |  10/05/09   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         **/
%>
<%@include file="cabecalho.jsp" %>
<style type="text/css">
    .app_nome{
        font-size:medium;
        font-weight:bold;
    }
    .app_similaridade{
        font-style:italic;
    }
    .app_contexto{

    }
    .app_problema_titulo, .app_solucao_titulo,.app_contexto_titulo{
        font-size:medium;

    }
    .app_problema{

    }
    .app_solucao{

    }

</style>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript">
    var tab_adicionada=false;

    $(document).keyup(function(event){
        //Caso o usuário tecle enter, a busca é iniciada...
        if(event.keyCode==13){
            $("#btnBuscaAPP").click();
        };
    });

    function BuscaAPP(){

        var HtmlResultado="";
        HtmlResultado+="<tr class='ui-widget-header ui-corner-all app_nome' style='border-width:1px;'><td class='app_nome'>";
        HtmlResultado+="Nome";
        HtmlResultado+="</td>";
        HtmlResultado+="<td class='app_similaridade' width=15%>";
        HtmlResultado+="Similaridade";
        HtmlResultado+="</td>";
        HtmlResultado+="</tr>";
        $.post("BuscaSimilaridadeServlet", {nome: $("#frmBuscaAPPNome").val() ,contexto: $("#frmBuscaAPPContexto").val(), problema: $("#frmBuscaProblema").val(), solucao: $("#frmBuscaAPPSolucao").val()}, function(retorno, msgstatus){
            $(retorno).find("documento").each(function(indice,documento){

                HtmlResultado+="<a href='viewAPPP.jsp?CD_OBJ="+$(documento).find("codigo").text()+"'><div><table width='100%'>";
                HtmlResultado+="<tr class='ui-widget-header ui-corner-all app_nome' style='border-width:1px;'><td class='app_nome'>";
                HtmlResultado+=indice+1+".";
                HtmlResultado+=$(documento).find("nome").text();

                if($.trim($(documento).find("tipo").text())=='PA'){
                    HtmlResultado+="&nbsp;<font style='font-size:small;'>[Pattern]</font>";
                }else{
                    HtmlResultado+="&nbsp;<font style='font-size:small;'>[Anti-Pattern]</font>";
                }
                HtmlResultado+="</td><td align='right' width=15% class='app_similaridade'>";

                HtmlResultado+=$(documento).find("similaridade").text()+"%";
                HtmlResultado+="</td></tr>";
                HtmlResultado+="<tr><td colspan=2 class='app_contexto_titulo'>";
                HtmlResultado+="Contexto:";
                HtmlResultado+="</td></tr>";
                HtmlResultado+="<tr><td colspan=2 class='app_contexto'>";
                HtmlResultado+=$(documento).find("contexto").text();
                HtmlResultado+="</td></tr>";
                HtmlResultado+="<tr><td colspan=2 class='app_problema_titulo'>";
                HtmlResultado+="Problema:";
                HtmlResultado+="</td></tr>";
                HtmlResultado+="<tr><td colspan=2 class='app_problema'>";
                HtmlResultado+=$(documento).find("problema").text();
                HtmlResultado+="</td></tr>";
                HtmlResultado+="<tr><td colspan=2 class='app_solucao_titulo'>";
                if($.trim($(documento).find("tipo").text())=='PA'){
                    HtmlResultado+="Solu&ccedil;&atilde;o:";
                }else{
                    HtmlResultado+="Recomenda&ccedil;&atilde;o:";
                }
                HtmlResultado+="</td></tr>";
                HtmlResultado+="<tr><td colspan=2 class='app_solucao'>";
                HtmlResultado+=$(documento).find("solucao").text();
                HtmlResultado+="</td></tr>";
                HtmlResultado+="</table></div></a>";



            });
        }, "xml");
        $("#tab_resultado").html("<table width='100%' id='tbl_resultado'><tr><td>"+HtmlResultado+"</td></tr></table>");
    }


    $(document).ready(function(){
        $.ajaxSetup({async: false});
        $("#tabs_menu").tabs();
        $("#tabs_menu").tabs('select',0);
        $('#tabs_menu').tabs('option', 'fx', { opacity: 'toggle' });



        $("#btnBuscaAPP").click(function(){
            if(!tab_adicionada){
                $("#tabs_menu").append("<div id='tab_resultado'>Result<div>");
                $("#tabs_menu").tabs('add','#tab_resultado','Resultados');
                $("#tabs_menu li a[href='#tab_resultado']").attr("style", "background-color:#000000;color:#FFFFFF");
                tab_adicionada=true;
            }
            $("#tabs_menu").tabs('select',2);

            BuscaAPP();
        });

        $("#btnBuscaPersona").click(function(){
            //Abre tab de resultado
            //$('#tabs_menu').tabs('add' , 'frmCadEstrutura.jsp' , 'Primeira Pagina');
            //$("#tabs_menu ul").append("<li><a href='#tab_resultado'><span>Resultados</span></a></li>");
            if(!tab_adicionada){
                $("#tabs_menu").append("<div id='tab_resultado'>Result<div>");
                $("#tabs_menu").tabs('add','#tab_resultado','Resultados');
                $("#tabs_menu li a[href='#tab_resultado']").attr("style", "background-color:#000000;color:#FFFFFF");
                tab_adicionada=true;
            }

            $("#tabs_menu").tabs('select',2);
        });



    });


</script>


<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <!--Inicio do titulo-->
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Busca de APPP ::..</font> </td>
    </tr>
    <!--Fim do titulo-->
    <!--Inicio das tabs-->
    <tr>
        <td>
            <div id="tabs_menu">
                <ul>
                    <li><a href="#busca_PatAntPat"><span>Busca de Patterns e Anti-Patterns</span></a></li>
                    <li><a href="#busca_Personas"><span>Busca Personas</span></a></li>
                </ul>

                <!--Tab de Busca de Pattern e Anti-Patterns-->
                <DIV id="busca_PatAntPat">
                    <p>A busca por similaridade trar&aacute; APPP de acordo com a similaridade do texto inserido em uma ou mais caixas de texto abaixo.
                    Os resultados apresentados estar&atilde;o ordenados de forma decrescente com a similaridade.</p>
                    <p>
                        <form id="frmBuscaAPP" action="frmBuscaAPPP.jsp" method="post">
                            <table align="center">
                                <tr>
                                    <td>
                                        <font class="texto">Nome:</font>
                                    </td>
                                    <td>
                                        <textarea id="frmBuscaAPPNome" class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Contexto:</font>
                                    </td>
                                    <td>
                                        <textarea id="frmBuscaAPPContexto" class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Problema:</font>
                                    </td>
                                    <td>
                                        <textarea id="frmBuscaProblema" class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Solu&ccedil;&atilde;o:</font>
                                    </td>
                                    <td>
                                        <textarea id="frmBuscaAPPSolucao" class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center" style="padding-top:20px">
                                        <input id="btnBuscaAPP" class="botao" type="button" value="Buscar" name="BtnBuscar">&nbsp;
                                        <input class="botao" type="reset" value="Limpar" name="Limpar">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </p>
                </DIV>
                <!--Fim Tab de Busca de Pattern e Anti-Patterns-->
                <!--Tab de Busca de Personas-->
                <DIV id="busca_Personas">
                    <p>A busca simples ir&aacute; selecionar um APPP se forem encontradas todas as palavras digitadas em uma ou mais caixas de texto abaixo.</p>
                    <p>
                        <form id="frmBuscaPE" action="frmBuscaAPPP.jsp" method="post">
                            <table align="center">
                                <tr>
                                    <td>
                                        <font class="texto">Nome:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Descri&ccedil;&atilde;o</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center" style="padding-top:20px">
                                        <input id="btnBuscaPersona" class="botao" type="button" value="Buscar" name="BtnBuscar">&nbsp;
                                        <input class="botao" type="reset" value="Limpar" name="Limpar">
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </p>
                </DIV>
                <!--Fim Tab de Busca de Personas-->
            </div>
        </td>
    </tr>
    <!--Fim das tabs-->
</table>

<%@include file="rodape.jsp" %>