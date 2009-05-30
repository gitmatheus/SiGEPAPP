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
        if (request.getParameter("cd_est") == null) {
            listEst = estrDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(), null);
        } else {
            listEst = estrDAO.APPP_SEL_Estrutura_OBJ(new Estrutura(Long.parseLong(request.getParameter("cd_est")), null, null, null, 0, null), null);
        }
        estrDAO.fechaConexao();
        String tipo_estrutura;
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
<form action="frmBuscaPorEstrutura.jsp" method="get">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
        <!--Inicio do titulo-->
        <tr>
            <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Busca Por Estruturas ::..</font> </td>
        </tr>
        <!--Fim do titulo-->
        <%if (request.getParameter("cd_est") == null) {%>
        <!--Inicio Do Formulário para Busca-->
        <tr>
            <td align="center" style="padding-top:20px;padding-bottom:10px;">
                <font class="texto">
                    Selecione uma das estruturas abaixo:
                </font>
            </td>
        </tr>
        <tr>
            <td align="center">

                <select name="cd_est" size="10" class="select_varias_linhas" style="width:50%">
                    <!--Listagem de estruturas-->
                <% for (Estrutura estrutura : listEst) {

        if (estrutura.getTp_estrutura().equals("PA")) {
            tipo_estrutura = "Pattern";
        } else if (estrutura.getTp_estrutura().equals("AP")) {
            tipo_estrutura = "Anti-Pattern";
        } else {
            tipo_estrutura = "Persona";
        }
                    %>
                    <option value="<%= estrutura.getCd_estrutura()%>"/>[<%= tipo_estrutura%>]&nbsp;<%= estrutura.getNm_estrutura()%>
                    <%}
                    %>
                    <!--Fim da listagem de estruturas-->
                </select>
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
    int indice = 1;
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
        <%for (Objeto objeto : listObjetos) {%>
        <!--Exibição de um documento-->
        <tr>
            <td align="center">
                <a href="viewAPPP.jsp?CD_OBJ=%0A3">
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
        indice++;
    }
} else {
        %>
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