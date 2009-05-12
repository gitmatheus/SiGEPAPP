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

<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#tabs_menu").tabs();
        $("#tabs_menu").tabs('select',0);
        $('#tabs_menu').tabs('option', 'fx', { opacity: 'toggle' });

        $("#btnBuscaSimples").click(function(){
            //Abre tab de resultado
            $('#tabs_menu').tabs('add' , 'frmCadEstrutura.jsp' , 'Primeira Pagina');

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
                    <li><a href="#busca_simples"><span>Busca Simples</span></a></li>
                    <li><a href="#busca_similaridade"><span>Busca Avan&ccedil;ada por similaridade</span></a></li>
                </ul>

                <DIV id="busca_simples">
                    <p>A busca simples ir&aacute; selecionar um APPP se forem encontradas todas as palavras digitadas em uma ou mais caixas de texto abaixo.</p>
                    <p>
                        <form>
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
                                        <font>Contexto:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Problema:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Solu&ccedil;&atilde;o:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr><td colspan="2" align="center" style="padding-top:20px"><input id="btnBuscaSimples" class="botao" type="button" value="Buscar" name="BtnBuscar">&nbsp;<input class="botao" type="reset" value="Limpar" name="Limpar"></td></tr>
                            </table>
                        </form>
                    </p>
                </DIV>

                <DIV id="busca_similaridade">
                    <p>A busca por similaridade trar&aacute; APPP de acordo com a similaridade do texto inserido em uma ou mais caixas de texto abaixo.
                    Os resultados apresentados estar&atilde;o ordenados de forma decrescente com a similaridade.</p>
                    <p>
                        <form>
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
                                        <font>Contexto:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Problema:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <font>Solu&ccedil;&atilde;o:</font>
                                    </td>
                                    <td>
                                        <textarea class="edit" cols="60" rows="3"></textarea>
                                    </td>
                                </tr>
                                <tr><td colspan="2" align="center" style="padding-top:20px"><input id="btnBuscaSimilaridade" class="botao" type="button" value="Buscar" name="BtnBuscar">&nbsp;<input class="botao" type="reset" value="Limpar" name="Limpar"></td></tr>
                            </table>
                        </form>
                    </p>
                </DIV>
            </div>
        </td>
    </tr>
    <!--Fim das tabs-->
</table>

<%@include file="rodape.jsp" %>