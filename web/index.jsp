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
        $("#accordion_listPattern").accordion();
        $("#accordion_listAntiPattern").accordion();
        $("#accordion_listPersona").accordion();
    });

</script>
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: &Uacute;ltimos Patterns Cadastrados :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="accordion_listPattern">
                <%for (int i = 0; i < listPA.size() && i < 5; i++) {%>

                <h3><a href="#"><%= listPA.get(i).getNm_objeto()%></a></h3>
                <div>
                    <p>
                        <%= listPA.get(i).getDs_objeto()%>
                    </p>
                    <p>
                        <div align="right"><a class="ultimosDoc" href="viewAPPP.jsp?CD_OBJ=<%=listPA.get(i).getCd_objeto() %>">Detalhes...</a></div>
                    </p>
                </div>
                <%}%>
            </div>
        </td>
    </tr>
    <!--Ultimos Patterns Cadastrados FIM-->
    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: &Uacute;ltimos Anti-Patterns Cadastrados :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="accordion_listAntiPattern">
                <%for (int i = 0; i < listAP.size() && i < 5; i++) {%>

                <h3><a href=""><%= listAP.get(i).getNm_objeto()%></a></h3>
                <div>
                    <p>
                        <%= listAP.get(i).getDs_objeto()%>
                    </p>
                     <p>
                        <div align="right"><a class="ultimosDoc" href="viewAPPP.jsp?CD_OBJ=<%=listAP.get(i).getCd_objeto() %>">Detalhes...</a></div>
                    </p>
                </div>

                <%}%>
            </div>
        </td>
    </tr>
    <!--Ultimos Anti-Patterns cadastrados FIM-->


    <tr>
        <td colspan="2" class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:center;">
                <font class="titulo">.: &Uacute;ltimas Personas Cadastradas :.</font>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="accordion_listPersona">
                <%for (int i = 0; i < listPE.size() && i < 5; i++) {%>
                <h3><a href=""><%= listPE.get(i).getNm_objeto()%></a></h3>
                <div>
                    <p>
                        <%= listPE.get(i).getDs_objeto()%>
                    </p>
                     <p>
                        <div align="right"><a class="ultimosDoc" href="viewAPPP.jsp?CD_OBJ=<%=listPE.get(i).getCd_objeto() %>">Detalhes...</a></div>
                    </p>
                </div>

                <%}%>
            </div>
        </td>
    </tr>

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

    <tr>
        <td class="titulo" width="50%">
            <div style="margin-left: 10px; text-align:left">
                <font class="titulo">.: Patterns</font>
            </div>
        </td>
        <td class="titulo" width="50%">
            <div style="margin-left: 10px; text-align:left">
                <font class="titulo">.: Anti-Patterns</font>
            </div>
        </td>
    </tr>
    <tr>
        <td width="50%" style="border-right: 1px dotted #3d414c;">
            <div style=" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;">
                <font class="texto">
                    Os patterns são utilizados para documentar boas práticas.A vantagem na utilização dos patterns está em localizar as soluções para problemas recorrentes sem muito despreender muito tempo.
                </font>
            </div>
        </td>
        <td width="50%">
            <div style=" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;">
                <font class="texto">
                    Os anti-patterns são utilizados para documentar más práticas e recomendações na tentativa de informar o caminho para se encontrar uma solução.
                </font>
            </div>
        </td>
    </tr>
    <tr>
        <td class="titulo" width="50%" style="border-right: 1px dotted #3d414c;">
            <div style="margin-left: 10px; text-align:left;">
                <font class="titulo">.: Personas</font>
            </div>
        </td>
        <td class="titulo" width="50%">
            <div style="margin-left: 10px; text-align:left">
                <font class="titulo"> &nbsp;</font>
            </div>
        </td>
    </tr>
    <tr>
        <td width="50%" style="border-right: 1px dotted #3d414c;">
            <div style=" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;">
                <font class="texto">
                    São perfis de usuários utilizados para compreender as características de um determinado grupo de usuários.Isso é importante para manter o foco do projetista no usuário final.
                </font>
            </div>
        </td>
        <td width="50%">
            <div style=" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;">
                <font class="texto">&nbsp;</font>
            </div>
        </td>
    </tr>
</table>

<%@include file="rodape.jsp" %>
