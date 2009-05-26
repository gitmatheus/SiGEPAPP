<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%
        PerguntaDAO pergDAO = new PerguntaDAO();
        List<Pergunta> listPerguntas = pergDAO.APPP_SEL_PERGUNTA(new Pergunta());
        pergDAO.fechaConexao();
        int i = 0;

        RespostaDAO respDAO = new RespostaDAO();
        List<Resposta> listRespostas;

        int j = 0;

        RelacPergRespDAO relacPRDAO = new RelacPergRespDAO();

        List<Relac_Perg_Resp> listRelacPergResp;

%>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/appp_frmCadResposta.js"></script>
<script type="text/javascript">

</script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" class="formulario">

    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Avalia&ccedil;&atilde;o ::..</font> </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset title="Respostas" style="width:90%">
                <form id="formCad" action="CadQuestPreenchServlet?CD_OBJ=<%= request.getParameter("CD_OBJ")%>" method="post">
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="justify" valign="middle" colspan="3" style="padding-top:5px;padding-bottom:15px">
                                Favor preencha o question&aacute;rio abaixo para avaliar o documento:
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <table border="0" width="100%">
                                    <%
        for (Pergunta p : listPerguntas) {
            i++;
                                    %>
                                    <tr>
                                        <td colspan="5" style="padding-top:10px;padding-bottom:8px" class="pergunta" align="left">
                                            <%=i%>) <%=p.getDs_pergunta()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <%

                                                listRelacPergResp = relacPRDAO.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp(p.getCd_pergunta(), 0, 0));


                                                for (Relac_Perg_Resp rel : listRelacPergResp) {
                                                    listRespostas = respDAO.APPP_SEL_RESPOSTA(new Resposta(rel.getCd_resposta(), null));
                                                    %>
                                                    <td style="padding-left:20px;">
                                                        <input name="<%= p.getCd_pergunta()%>" type="radio" value="<%= listRespostas.get(0).getCd_resposta()%>" >
                                                        <%= listRespostas.get(0).getDs_resposta()%>
                                                    </td>
                                                    <%}%>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="border-top-style:solid;border-top-color:black;border-top-width:1px;border-top-color:silver;padding-top:10px;">
                                <input class="botao" type="submit" id="cadQuest">
                                <input class="botao" type="reset" id="resQuest">
                            </td>
                        </tr>
                    </table>
                </form>
            </fieldset>
        </td>
    </tr>
</table>
<%

        respDAO.fechaConexao();
        relacPRDAO.fechaConexao();

%>
<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
