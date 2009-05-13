a<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>

<%
        PerguntaDAO pergDAO = new PerguntaDAO();
        List<Pergunta> listPerguntas = pergDAO.APPP_SEL_PERGUNTA(new Pergunta());
        pergDAO.fechaConexao();
        int i = 0;

        RespostaDAO respDAO = new RespostaDAO();
        List<Resposta> listRespostas = respDAO.APPP_SEL_RESPOSTA(new Resposta());
        respDAO.fechaConexao();
        int j = 0;

        RelacPergRespDAO relacPRDAO = new RelacPergRespDAO();
        Relac_Perg_Resp buscaRelac = new Relac_Perg_Resp();
        List<Relac_Perg_Resp> listRelacPergResp = relacPRDAO.APPP_SEL_RELAC_PERG_RESP(new Relac_Perg_Resp(0, 0, 0));
        relacPRDAO.fechaConexao();
%>

<%@include file="cabecalho.jsp"%>

<script type="text/javascript" language="javascript" src="js/appp_frmCadResposta.js"></script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center" class="formulario">

    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Avalia&ccedil;&atilde;o ::..</font> </td>
    </tr>

    <!--Conteudo da Pagina-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset title="Respostas" style="width:90%">
                <form id="frmCadResp" action="CadRelacPergRespServlet" method="post">
                    <table align="center" border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td align="justify" valign="middle" colspan="3" style="padding-top:5px;padding-bottom:15px">
                                Avalie o objeto
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" align="center">
                                <table border="0" width="100%">
                                    <%
                                        Relac_Perg_Resp buscaListaRelac = new Relac_Perg_Resp();

                                        for (Pergunta p : listPerguntas) {
                                            i++;
                                    %>
                                    <tr>
                                        <td colspan="5" style="padding-top:10px;padding-bottom:8px" class="pergunta" align="left">
                                            <%=i%>) <%=p.getDs_pergunta()%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <%for (j = 1; j <= 5; j++) {%>

                                        <input type="hidden" name="CDPerg" value="<%=p.getCd_pergunta()%>">
                                        <input type="hidden" name="PesoResp" value="<%=j%>" >
                                        <td>
                                        <%
                                        
                                        %>
                                        <input name="radio" type="radio" value=""/>
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
</table>

<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
