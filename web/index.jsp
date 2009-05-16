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
%>
<%@include file="cabecalho.jsp" %>

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
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
                    desenvolvedores de software atrav�s do compartilhamento, busca e gerenciamento de documenta��es providas
                    pelos pr�prios usu�rios do sistema. Uma base de dados rica em experi�ncia, instru��es e perfis de usu�rios,
                    aliados a uma poderosa ferramenta de busca por similaridade atrav�s de conceitos envolvendo Racioc�nio Baseado
                    em Casos, auxiliam os profissionais a desenvolverem sistemas de qualidade - focados no perfil do usu�rio - de maneira
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
                    Os patterns s�o utilizados para documentar boas pr�ticas.A vantagem na utiliza��o dos patterns est� em localizar as solu��es para problemas recorrentes sem muito despreender muito tempo.
                </font>
            </div>
        </td>
        <td width="50%">
            <div style=" margin-left: 10px; margin-right: 10px; margin-top: 5px; margin-bottom: 15px; text-align:justify;">
                <font class="texto">
                    Os anti-patterns s�o utilizados para documentar m�s pr�ticas e recomenda��es na tentativa de informar o caminho para se encontrar uma solu��o.
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
                    S�o perfis de usu�rios utilizados para compreender as caracter�sticas de um determinado grupo de usu�rios.Isso � importante para manter o foco do projetista no usu�rio final.
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
