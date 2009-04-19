<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%        /**
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  30/03/09   | Criacao                              |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  31/03/09   | Criacao da Servlet e DAO             |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  01/04/09   | Cadastro de Resposta funcionando     |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  18/04/09   | Combo para mostrar Resp. cadastradas |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  18/04/09   | Criacao das Wizards                  |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  18/04/09   | Mostrar resp. em selects dinamicos   |
         * |------------------------------------------------------------------|
         **/
        PerguntaDAO pergDAO = new PerguntaDAO();
        List<Pergunta> listPerguntas = pergDAO.APPP_SEL_PERGUNTA(new Pergunta());
        pergDAO.fechaConexao();
        int i = 0;

        RespostaDAO respDAO = new RespostaDAO();
        List<Resposta> listRespostas = respDAO.APPP_SEL_RESPOSTA(new Resposta());
        respDAO.fechaConexao();
        int j = 0;
%>

<%@include file="cabecalho.jsp"%>


<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" class="formulario">

    <!--Menu de Navegacao do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            Passos: <a href="frmCadQuestionarioStep1.jsp">Cadastro das Perguntas</a>&nbsp;>&nbsp;<a href="#">Cadastro das Respostas</a>&nbsp;>&nbsp;
        </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset title="Respostas" style="width:90%">
                <legend><b>Resposta</b></legend>
                <form id="frmCadResp" action="CadRelacPergRespServlet" method="post">
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="left">
                                <div style="display:inline-block ">Cadastre uma nova Resposta</div>
                            </td>
                            <td align="center">
                                <div>
                                    <input id="frmCadQuestionarioDescResp" name="frmCadQuestionarioDescResp" type="text" class="edit" size="40" maxlength="100" title="Digite sua resposta" />
                                </div>
                            </td>
                            <td align="center">
                                <input id="frmCadQuestionarioEnviaResp" name="frmCadQuestionarioEnviaResp" class="botao" style="background-color:#3d414c;" type="button" value="cadastrar">
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <table>
                                    <% for (Pergunta p : listPerguntas) {
            i++;%>
                                    <tr>
                                        <td colspan="5" style="padding-top:10px" class="pergunta">
                                            Pergunta <%=i%>: <%=p.getDs_pergunta()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <%for (j = 1; j <= 5; j++) {%>
                                        <input type="hidden" name="CDPerg" value="<%=p.getCd_pergunta()%>">
                                        <input type="hidden" name="PesoResp" value="<%=j%>" >
                                        <td>
                                            <select name="CDResp" size="1" style="width:100%" class="edit">
                                                <option value="0">
                                                <% for (Resposta r : listRespostas) {%>
                                                <option value="<%=r.getCd_resposta()%>"><%=r.getDs_resposta()%>
                                                <%}%>
                                            </select>
                                            <div  align="center" >Peso <%=j%></div>
                                        </td>
                                        <%}%>
                                    </tr>
                                    <%}%>
                                </table>
                            </td>
                        </tr>
                    </table>
                </form>
            </fieldset>
        </td>
    </tr>

    <!--Botoes de sequencia ao final da pagina-->
    <tr>
        <td>
            <table align="center" border="0" width="92%" style="background-color:#ffffff;">
                <tr>
                    <!--Botao Retornar Passo-->
                    <td align="left" style="padding-top:10px;padding-bottom:10px">
                        <div align="left" style="width:100%">
                            <a id="linkRetorna" class="navProximo ui-widget-header" href="frmCadQuestionarioStep2.jsp">
                                <span>
                                    <span class="ui-icon ui-icon-circle-arrow-w" style="display:inline-block;vertical-align:middle"></span>
                                    Retornar
                                </span>
                            </a>
                        </div>
                    </td>
                    <!--Botao Avançar Passo-->
                    <td align="right" style="padding-top:10px;padding-bottom:10px">
                        <div align="right" style="width:100%">
                            <a id="linkProximo" class="navProximo ui-widget-header" href="#" onclick='$("#frmCadResp").submit();return false;'>
                                <span>
                                    Pr&oacute;ximo
                                    <span class="ui-icon ui-icon-circle-arrow-e" style="display:inline-block;vertical-align:middle"></span>
                                </span>
                            </a>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!--Fim do formulário-->
<%@include file="rodape.jsp"%>