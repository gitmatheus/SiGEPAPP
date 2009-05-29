<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*, br.edu.fei.sigepapp.bancodedados.model.*, java.util.*" %>
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
         * |  Andrey     |  09/01/18   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/23   | Alteracao na formatacao do menu para |
         * |             |             | compatibilidade entre IE e Firefox.  |
         * |------------------------------------------------------------------|
         * |  Andrey     |  09/01/26   | Inclusao das formatacoes dos         |
         * |             |             | elementos body e table               |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Troca do menu (de lista para tabela) |
         * |             |             | para reparar o bug de largura no menu|
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/21   | Quebra do arquivo index em cabecalho |
         * |             |             | e rodape.                            |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/05/28   | Últimos documentos cadastrados apre- |
         * |             |             | sentados em forma de tabs.           |
         * |------------------------------------------------------------------|
         **/
        GenericDAO generica = new GenericDAO();

        List<Objeto> listPA = generica.ultimosDocumentos(1);
        List<Objeto> listAP = generica.ultimosDocumentos(2);
        List<Objeto> listPE = generica.ultimosDocumentos(3);
        generica.fechaConexao();

%>
<%@include file="cabecalho.jsp" %>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    <%if (listPA.size() > 0) {%>
            $("#tabs_Patterns").tabs();
    <%}%>
<%if (listAP.size() > 0) {%>
        $("#tabs_Anti_Patterns").tabs();
    <%}%>
    <%if (listPE.size() > 0) {%>
            $("#tabs_Persona").tabs();
        <%}%>
            });

</script>
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <%if (listPA.size() > 0) {%>
    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: &Uacute;ltimos Patterns Cadastrados :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="tabs_Patterns">
                <ul>
                    <%for (int i = 0; i < listPA.size() && i < 5; i++) {%>
                    <li><a href="#tabs_Pat_<%= listPA.get(i).getCd_objeto()%>"><%= listPA.get(i).getNm_objeto()%></a></li>
                    <%}%>
                </ul>
                <%for (int i = 0; i < listPA.size() && i < 5; i++) {%>
                <div id="tabs_Pat_<%= listPA.get(i).getCd_objeto()%>">
                    <p class="texto">
                        <%=listPA.get(i).getDs_objeto()%>
                    </p>
                    <p>
                        <div align="right"><a class="ultimosDoc" href="viewAPPP.jsp?CD_OBJ=<%=listPA.get(i).getCd_objeto()%>">Detalhes...</a></div>
                    </p>
                </div>
                <%}%>
            </div>
        </td>
    </tr>
    <%}%>
    <!--Ultimos Patterns Cadastrados FIM-->
    <%if (listAP.size() > 0) {%>
    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: &Uacute;ltimos Anti-Patterns Cadastrados :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="tabs_Anti_Patterns">
                <ul>
                    <%for (int i = 0; i < listAP.size() && i < 5; i++) {%>
                    <li><a href="#tabs_Pat_<%= listAP.get(i).getCd_objeto()%>"><%= listAP.get(i).getNm_objeto()%></a></li>
                    <%}%>
                </ul>
                <%for (int i = 0; i < listAP.size() && i < 5; i++) {%>
                <div id="tabs_Pat_<%= listAP.get(i).getCd_objeto()%>">
                    <p class="texto">
                        <%=listAP.get(i).getDs_objeto()%>
                    </p>
                    <p>
                        <div align="right"><a class="ultimosDoc" href="viewAPPP.jsp?CD_OBJ=<%=listAP.get(i).getCd_objeto()%>">Detalhes...</a></div>
                    </p>
                </div>
                <%}%>
            </div>
        </td>
    </tr>
    <%}%>
    <!--Ultimos Anti-Patterns cadastrados FIM-->

    <%if (listPE.size() > 0) {%>
    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: &Uacute;ltimas Personas Cadastradas :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="tabs_Persona">
                <ul>
                    <%for (int i = 0; i < listPE.size() && i < 5; i++) {%>
                    <li><a href="#tabs_Pat_<%= listPE.get(i).getCd_objeto()%>"><%= listPE.get(i).getNm_objeto()%></a></li>
                    <%}%>
                </ul>
                <%for (int i = 0; i < listPE.size() && i < 5; i++) {%>
                <div id="tabs_Pat_<%= listPE.get(i).getCd_objeto()%>">
                    <p class="texto">
                        <%=listPE.get(i).getDs_objeto()%>
                    </p>
                    <p>
                        <div align="right"><a class="ultimosDoc" href="viewAPPP.jsp?CD_OBJ=<%=listPE.get(i).getCd_objeto()%>">Detalhes...</a></div>
                    </p>
                </div>
                <%}%>
            </div>
        </td>
    </tr>
    <%}%>


    <!--Ultimas Personas Cadastras FIM-->

    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: Sobre o SiGePAPP :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" class="texto" style="padding:10px">
            O SigePAPP - Sistema de Gerenciamento de Patterns, Anti-Patterns e Personas - visa auxiliar os
            desenvolvedores de software através do compartilhamento, busca e gerenciamento de documentações providas
            pelos próprios usuários do sistema. Uma base de dados rica em experiência, instruções e perfis de usuários,
            aliados a uma poderosa ferramenta de busca por similaridade através de conceitos envolvendo Raciocínio Baseado
            em Casos, auxiliam os profissionais a desenvolverem sistemas de qualidade - focados no perfil do usuário - de maneira
            mais eficiente, minimizando o retrabalho e reduzindo custos. Bem vindo ao SigePAPP!
        </td>
    </tr>
</table>

<%@include file="rodape.jsp" %>
