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
        int i=0;
%>

<%@include file="cabecalho.jsp"%>
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadResposta.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadPergunta.js"></script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

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
                <form id="frmCadResp" name="frmCadResp" method="post">
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
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
                                    <% for (Pergunta r : listPerguntas) { i++;%>
                                    <tr>
                                        <td colspan="5" style="padding-top:10px">
                                            Pergunta <%=i%>: <%=r.getDs_pergunta()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><select id="FrmCadQuestionarioComboResp<%=r.getCd_pergunta()%>" size="1" style="width:100%" class="edit"></select></td>
                                        <td><select id="FrmCadQuestionarioComboResp<%=r.getCd_pergunta()%>" size="1" style="width:100%" class="edit"></select></td>
                                        <td><select id="FrmCadQuestionarioComboResp<%=r.getCd_pergunta()%>" size="1" style="width:100%" class="edit"></select></td>
                                        <td><select id="FrmCadQuestionarioComboResp<%=r.getCd_pergunta()%>" size="1" style="width:100%" class="edit"></select></td>
                                        <td><select id="FrmCadQuestionarioComboResp<%=r.getCd_pergunta()%>" size="1" style="width:100%" class="edit"></select></td>
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

    <!--Botao de Proximo-->
    <tr>
        <td align="center" style="padding-top:10px;">
            <div align="right" style="width:80%">
                <a id="linkProximo" class="navProximo ui-widget-header" href="frmCadQuestionarioStep3.jsp">
                    <span>
                        Pr&oacute;ximo
                        <span class="ui-icon ui-icon-circle-arrow-e" style="display:inline-block;vertical-align:middle"></span>
                    </span>
                </a>
            </div>
        </td>
    </tr>
</table>

<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
