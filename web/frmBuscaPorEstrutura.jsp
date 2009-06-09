<%@page import="br.edu.fei.sigepapp.bancodedados.model.Estrutura, br.edu.fei.sigepapp.bancodedados.dao.Estrutura_ObjDAO, java.util.*, br.edu.fei.sigepapp.bancodedados.model.Objeto, br.edu.fei.sigepapp.bancodedados.dao.ObjetoDAO" %>
<%        /**
         * @{#}frmBuscaPorEstrutura.jsp 0.01 29/05/09
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
         * |  Guilherme  |  29/05/09   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         **/
        Estrutura_ObjDAO estrDAO = new Estrutura_ObjDAO();
        List<Estrutura> listEst;
        int paginaAtual = 1;
        if (request.getParameter("cd_est") == null) {
            listEst = estrDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(), null);
        } else {
            listEst = estrDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(Long.parseLong(request.getParameter("cd_est")), null, null, null, 0, null), null);
        }

        if (request.getParameter("Pag") != null) {
            paginaAtual = Integer.parseInt(request.getParameter("Pag"));
        }

        estrDAO.fechaConexao();
        String tipo_estrutura;

        final int DocumentosPorPag = 5;
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
<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript">
    var arrayVisiveis = new Array();

    $(document).ready(function(){
        $.ajaxSetup({
            async: false
        });

        var req = verificaChkBox();
        selecionaTpEstrutura(req);


        arrayVisiveis=$.makeArray($("#frmBuscaEstruturaEstrutura option"));



        $("#frmBuscaEstChkPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);



        });

        $("#frmBuscaEstChkAntiPattern").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);



        });

        $("#frmBuscaEstChkPersona").click(function(){
            var req = verificaChkBox();
            selecionaTpEstrutura(req);



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

    function verificaChkBox(){

        if ($("#frmBuscaEstChkPattern").is(":checked") && $("#frmBuscaEstChkAntiPattern").is(":checked") && $("#frmBuscaEstChkPersona").is(":checked")){
            return 1;
        }else if($("#frmBuscaEstChkPattern").is(":checked")==false && $("#frmBuscaEstChkAntiPattern").is(":checked") && $("#frmBuscaEstChkPersona").is(":checked")){
            return 2;
        }else if($("#frmBuscaEstChkPattern").is(":checked") && $("#frmBuscaEstChkAntiPattern").is(":checked")==false && $("#frmBuscaEstChkPersona").is(":checked")){
            return 3;
        }else if($("#frmBuscaEstChkPattern").is(":checked") && $("#frmBuscaEstChkAntiPattern").is(":checked") && $("#frmBuscaEstChkPersona").is(":checked")==false){
            return 4;
        }else if($("#frmBuscaEstChkPattern").is(":checked") && $("#frmBuscaEstChkAntiPattern").is(":checked")==false && $("#frmBuscaEstChkPersona").is(":checked")==false){
            return 5;
        }else if($("#frmBuscaEstChkPattern").is(":checked")==false && $("#frmBuscaEstChkAntiPattern").is(":checked") && $("#frmBuscaEstChkPersona").is(":checked")==false){
            return 6;
        }else if($("#frmBuscaEstChkPattern").is(":checked")==false && $("#frmBuscaEstChkAntiPattern").is(":checked")==false && $("#frmBuscaEstChkPersona").is(":checked")){
            return 7;
        }else{
            return 0;
        }
    }

    function selecionaTpEstrutura(requisicao){
        $("#SelectEstrutura").html(
        "<select id='frmBuscaEstruturaEstrutura' name='cd_est' class='select_varias_linhas' size='5' style='width: 300px;'></select>" +
            "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>");

        $.get("BuscaEstrutCadAPPPServlet",{
            tipos_requisitados:requisicao
        },function(xml){
            var qtd = parseInt($("qtd",xml).text());
            var strCombo = "";
            if (qtd > 0){
                strCombo += "<select id='frmBuscaEstruturaEstrutura' name='cd_est' class='select_varias_linhas' size='5' style='width: 300px;'>";
                //strCombo += "<option value=''>Escolha a estrutura do documento...</option>";
                $(xml).find("estrutura").each(function(indice /* indice de interacao utilizado pelo each() */,
                elemento /* a estrutura atual do each */){
                    strCombo += "<option value='" + $(elemento).find("cod_est").text()+ "'>[" +
                        $(elemento).find("tp_est").text() + "]\t" +
                        $(elemento).find("nm_est").text() + "</option>";
                });
                strCombo +="</select>";
            }else{
                $("#alertaSelectEstrut").dialog('open');
                strCombo += "<select id='frmBuscaEstruturaEstrutura' name='cd_est' class='select_varias_linhas' size='5' style='width: 300px;'>";
                strCombo += "<option value=''>Nenhuma estrutura encontrada...</option>";
                strCombo +="</select>";
            }
            $("#SelectEstrutura").html(strCombo);
        });
        arrayVisiveis=$.makeArray($("#frmBuscaEstruturaEstrutura option"));

        $("#frmBuscaEstruturaEstrutura").change(function(){
            var cd = $("#frmBuscaEstruturaEstrutura").val();
            cod_estrutura = $("#frmBuscaEstruturaEstrutura").val();
        });
    }

</script>
<form action="frmBuscaPorEstrutura.jsp" method="get" id="frmBuscaEstrutura">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
        <!--Inicio do titulo-->
        <tr>
            <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Busca Por Estruturas ::..</font> </td>
        </tr>
        <!--Fim do titulo-->
        <%if (request.getParameter("cd_est") == null) {%>
        <!--Inicio Do Formulário para Busca-->
        <tr>
            <td colspan="2" align="center" style="padding-top:10px">
                <fieldset style="width:400px;">
                    <legend style="font-weight: bold;">Filtros de busca de estruturas:</legend>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="right">
                                <font class="texto">Por nome:&nbsp;&nbsp;</font>
                            </td>
                            <td>
                                <input id="frmTxtBuscaEstrutura" type="text" class="edit" style="width: 250px" onkeyup="filtraCombo('#frmBuscaEstruturaEstrutura','#frmTxtBuscaEstrutura')"></input>
                            </td>
                        </tr>
                        <td colspan="2" align="center">
                            <br /><font class="texto">Por tipo:</font>&nbsp;&nbsp;
                            <input id="frmBuscaEstChkPattern" name="frmBuscaEstChkPattern" type="checkbox" class="edit" value="PA" checked>
                            <font class="texto"> Patterns </font> &nbsp;&nbsp;
                            <input id="frmBuscaEstChkAntiPattern" name="frmBuscaEstChkAntiPattern" type="checkbox" class="edit" value="AP" checked>
                            <font class="texto"> Anti-Patterns </font> &nbsp;&nbsp;
                            <input id="frmBuscaEstChkPersona" name="frmBuscaEstChkPersona" type="checkbox" class="edit" value="PE" checked>
                            <font class="texto"> Personas </font>
                        </td>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td align="center" style="padding-top:10px;padding-bottom:10px;">
                <font class="texto">
                    Selecione uma das estruturas abaixo:
                </font>
            </td>
        </tr>
        <tr>
            <td align="center">
                <div id="SelectEstrutura" style="margin-left: 5px;">

                </div>
            </td>
        </tr>
        <tr>
            <td align="center">
                <input type="submit" class="botao" value="Buscar">
                <input type="reset" class="botao" value="Limpar">
            </td>
        </tr>
        <!--Fim Do Formulário para Busca-->
        <%
//Caso a estrutura já foi escolhida efetuamos a busca
} else {
    ObjetoDAO objetoDAO = new ObjetoDAO();
    Objeto objetoProcurado = new Objeto();
    objetoProcurado.setCd_estrutura(Long.parseLong(request.getParameter("cd_est")));
    List<Objeto> listObjetos = objetoDAO.pesquisaObjetoAtivos(objetoProcurado);
    objetoDAO.fechaConexao();
    int indice = ((paginaAtual - 1) * DocumentosPorPag) + 1;
    int total = 1;
        %>
        <tr>
            <td align="center">
                <font class="texto">
                    Resultados para busca por estrutura: <%= listEst.get(0).getNm_estrutura()%>
                </font>
            </td>
        </tr>

        <%if (listObjetos.size() > 0) {%>
        <tr>
            <td>
                <table width="100%">
                    <tbody>
                        <tr class="ui-widget-header ui-corner-all app_nome" style="border-width: 1px;">
                            <td class="app_nome">Nome</td>
                    </tr></tbody>
                </table>
            </td>
        </tr>
        <%for (int i = (paginaAtual - 1) * DocumentosPorPag; i < listObjetos.size() && total <= 5; i++) {
        Objeto objeto = listObjetos.get(i);
        %>
        <!--Exibição de um documento-->
        <tr>
            <td align="center">
                <a href="viewAPPP.jsp?CD_OBJ=<%= objeto.getCd_objeto() %>">
                    <div>
                        <table width="100%">
                            <tr class="ui-widget-header ui-corner-all app_nome" style="border-width: 1px;">
                                <td class="app_nome"><%=indice%>.
                                    <%= objeto.getNm_objeto()%>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="app_contexto_titulo">Contexto:</td>
                            </tr>
                            <tr>
                                <td colspan="2" class="app_contexto">
                                    <%= objeto.getDs_objeto()%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </a>
            </td>
        </tr>
        <!--Fim da exibição de um documento-->
        <%
        total++;
        indice++;
    }%>

        <%
    int UltimaPagina = (int) ((listObjetos.size() / DocumentosPorPag) + 0.5)+1;

    if (UltimaPagina > 0) {%>
        <tr>
            <td align="center">
                <table class="paginacao">
                    <tr>
                        <td>
                            <a href="frmBuscaPorEstrutura.jsp?cd_est=<%= request.getParameter("cd_est")%>&Pag=1"> << Primeira</a>
                        </td>
                        <%if (paginaAtual==1){ %>
                        <td>
                            <a href="#"> < Anterior</a>
                        </td>
                        <%}else{%>
                        <td>
                            <a href="frmBuscaPorEstrutura.jsp?cd_est=<%= request.getParameter("cd_est")%>&Pag=<%= paginaAtual - 1%>"> < Anterior</a>
                        </td>
                        <%}%>
                        <td>
                            <%if (paginaAtual==UltimaPagina){ %>
                            <a href="#">Pr&oacute;xima > </a>
                            <%}else{%>
                            <a href="frmBuscaPorEstrutura.jsp?cd_est=<%= request.getParameter("cd_est")%>&Pag=<%= paginaAtual + 1%>">Pr&oacute;xima > </a>
                            <%}%>
                        </td>
                        <td>
                            <a href="frmBuscaPorEstrutura.jsp?cd_est=<%= request.getParameter("cd_est")%>&Pag=<%= UltimaPagina %>">&Uacute;ltima >></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%}%>

        <%} else {%>
        <tr valign="middle">
            <td align="center" style="background-color:rgb(238, 149, 127);">
                <p>
                    <b>Nenhum documento localizado</b>
                </p>
            </td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:history.back(1);">Voltar</a>
            </td>
        </tr>
        <%}
        }%>
    </table>

</form>
<%@include file="rodape.jsp" %>