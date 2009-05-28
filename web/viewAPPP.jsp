<%@page import="br.edu.fei.sigepapp.log.*,br.edu.fei.sigepapp.bancodedados.*,br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*, java.sql.*, oracle.jdbc.*,java.text.*,java.util.List"%>
<%@include file="cabecalho.jsp" %>
<% if (request.getSession().getAttribute("codigo_usuario") != null && request.getSession().getAttribute("codigo_usuario") != "0") {%>

<%
//Tratamento para solicitação de adicionar documento à lista de utilização
     boolean mostraMsgIncluir = false;
     if (request.getParameter("acao") != null) {
         Aval_Obj_UserDAO avaliaDAO = new Aval_Obj_UserDAO();
         try {
             avaliaDAO.APPP_INS_AvalObjUser(new AvalObjUser(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()), Long.parseLong(request.getParameter("CD_OBJ").trim())));
             mostraMsgIncluir = true;
         } catch (Exception e) {
         } finally {
             avaliaDAO.fechaConexao();
         }

     }
//Fim do tratamento para solicitação de adicionar documento à lista de utilização.

     Connection conn;
     ResultSet rs = null;
     CallableStatement cstmt = null;

     conn = ConnectionFactory.getConnection();
     try {
         cstmt = conn.prepareCall("begin APPP_SEL_APPP_GEN(?,?); end;");
         cstmt.setLong(1, Long.parseLong(request.getParameter("CD_OBJ").trim()));
         cstmt.registerOutParameter(2, OracleTypes.CURSOR);

         cstmt.execute();
         boolean encontrou = false;
         try {
             rs = (ResultSet) cstmt.getObject(2);
             encontrou = rs.next();
         } catch (Exception e) {
         }

         if (encontrou) {
             //Objeto do relacionamento
             int TotalCols = rs.getMetaData().getColumnCount();
             RelacObjetos_View relacProcura = new RelacObjetos_View();
             RelacObjetoDAO relacionamentoDao = new RelacObjetoDAO();
             relacProcura.setCd_obj_relacionado(Long.parseLong(request.getParameter("CD_OBJ").trim()));
             List<RelacObjetos_View> relacionamento = relacionamentoDao.APPP_SEL_OBJ_RELAC(relacProcura);
             RelacObjetos_View proc_relacionamento = new RelacObjetos_View();
%>

<style type="text/css">
    .nome{
        font-size:medium;
    }

    .contexto font, .problema font, .solucao font{
        line-height:1.4em;

    }

    .titulo_contexto, .titulo_problema, .titulo_solucao, .titulo_geral{
        font-size:small;
        font-weight:bold;
        padding-top:15px;
    }
</style>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>

<% if (mostraMsgIncluir) {%>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#alertPadrao").dialog({ buttons: { "Ok": function() { $(this).dialog("close")}}});
        $("#alertPadrao").dialog('option','title','Avaliação');
        $("#alertPadrao").html("<table width='100%'><tr><td><img src='images/m2bralerta.png' style='vertical-align:middle;'/></td><td>Documento colocado em sua lista de utiliza&ccedil;&atilde;o.<br/><br/><b> Muito obrigado!</b></td>" );
        $(document).scrollTop(0);
        $("#alertPadrao").dialog("open");
    });
</script>
<%}%>


<% if (request.getParameter("MSG")!=null && request.getParameter("MSG").equals("1")) {%>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#alertPadrao").dialog({ buttons: { "Ok": function() { $(this).dialog("close")}}});
        $("#alertPadrao").dialog('option','title','Avaliação');
        $("#alertPadrao").html("<table width='100%'><tr><td><img src='images/m2bralerta.png' style='vertical-align:middle;'/></td><td>Documento avaliado com sucesso.<br/><br/><b> Muito obrigado!</b></td>" );
        $(document).scrollTop(0);
        $("#alertPadrao").dialog("open");
    });
</script>
<%}else if(request.getParameter("MSG")!=null && request.getParameter("MSG").equals("2")){%>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#alertPadrao").dialog({ buttons: { "Ok": function() { $(this).dialog("close")}}});
        $("#alertPadrao").dialog('option','title','Avaliação');
        $("#alertPadrao").html("<table width='100%'><tr><td><img src='images/m2bralerta.png' style='vertical-align:middle;'/></td><td>Ocorreu um erro na avaliação.<br/>Por favor, tente novamente mais tarde.<br/><br/><b> Muito obrigado!</b></td>" );
        $(document).scrollTop(0);
        $("#alertPadrao").dialog("open");
    });
</script>
<%}%>



<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <!--Inicio do titulo-->
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: APPP ::..</font> </td>
    </tr>
    <!--Fim do titulo-->
    <tr><td style="padding:10px;"></td></tr>
    <tr>
        <td>
            <!--Exibição APPP-->
            <table id="tbl_APPP" border="0" cellspacing="0" cellpadding="0" width="90%" align="center" style="" >
                <tr>
                    <td colspan="2">

                    </td>
                </tr>
                <!--Nome do Objeto-->
                <tr class="ui-widget-header ui-corner-all nome">
                    <td colspan="2" class="nome">
                        <table width="100%">
                            <tr class="ui-widget-header ui-corner-all">
                                <td class="nome">
                                    <% String campoCD_Objeto = new String();%>

                                    <%=rs.getString("NM_OBJETO").trim()%>
                                </td><td align="center" width="100">
                                    <% if (rs.getString("TP_ESTRUTURA").trim().equalsIgnoreCase("PA")) {%>

                                    [Pattern]
                                    <% campoCD_Objeto = "CD_PATTERN";%>

                                    <%} else if (rs.getString("TP_ESTRUTURA").trim().equalsIgnoreCase("AP")) {%>

                                    [Anti-Pattern]
                                    <% campoCD_Objeto = "CD_ANTI_PATTERN";%>

                                    <%} else {%>

                                    [Persona]
                                    <% campoCD_Objeto = "CD_PERSONA";%>

                                    <%}%>
                                </td>
                                <td width="150">Cria&ccedil;&atilde;o:&nbsp;<%
             SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
             out.println(sdf.format(rs.getDate("DT_CRIACAO")));
                                %></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!--Fim Nome do Objeto-->
                <tr><td>&nbsp;</td></tr>
                <!--Contexto do Objeto-->
                <tr><td class="titulo_contexto"><% if (campoCD_Objeto == "CD_PERSONA") {%>Descri&ccedil;&atilde;o<%} else {%>Contexto:<%}%></td></tr>
                <tr class="contexto">
                    <td colspan="2">
                        <font>
                            <%=rs.getString("DS_OBJETO").trim()%>
                        </font>

                    </td>
                </tr>
                <!--Fim Contexto do Objeto-->
                <!--Problema do Objeto-->
                <%
             String TabelaProblema = new String();
             String TabelaSolucao = new String();
             if (campoCD_Objeto != "CD_PERSONA") {%>
                <tr><td class="titulo_problema">Problema:</td></tr>
                <tr class="problema">
                    <td colspan="2">

                        <%
                 TabelaProblema = new String();
                 if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("PATTERN")) {%>


                        <!--Pattern sem relacionamento-->
                        <%= rs.getString("PROBLEMA").trim()%>

                        <%TabelaProblema = "PROBLEMA";
                        } else if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("ANTI_PATTERN")) {%>

                        <%= rs.getString("DS_PROBLEMA").trim()%>
                        <%TabelaProblema = "DS_PROBLEMA";
                        } else {%>
                        <%= rs.getString("Problema").trim()%>
                        <%TabelaProblema = "Problema";
                        }
                        %>

                    </td>
                </tr>
                <!--Fim Problema do Objeto-->
                <!--Solução do Objeto-->
                <%/*
             <tr><td class="titulo_solucao">Solucao:</td></tr>
             <tr class="solucao">
             <td colspan="2">
             <font>
             <%
             TabelaSolucao = new String();
             if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("PATTERN")) {
             out.println(rs.getString("Solução").trim());
             TabelaSolucao = "Solução";
             } else if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("ANTI-PATTERN")) {
             out.println(rs.getString("DS_RECOMENDACOES").trim());
             TabelaSolucao = "DS_RECOMENDACOES";
             } else {

             out.println(rs.getString("Solução").trim());
             TabelaSolucao = "Solução";
             }

              */%>

                <%}%>
                <!--Fim Solução do Objeto-->
                <%
             //For Principal para cada coluna
             for (int i = 1; i <= TotalCols; i++) {

                %>

                <%if (!rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("TP_ESTRUTURA") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("NM_OBJETO") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("DS_OBJETO") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase(TabelaProblema) &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase(TabelaSolucao) &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("CD_USER_CRIADOR") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("CD_OBJETO") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase(campoCD_Objeto) &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("DT_CRIACAO") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("FL_ATIVO") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("NM_ESTRUTURA") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("Nome") &&
                         !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("Contexto")) {%>
                <tr>
                    <!--Nome do atributo-->
                    <td class="titulo_geral"><%= rs.getMetaData().getColumnName(i)%>:</td>
                </tr>

                <%

    proc_relacionamento.setNm_atributo_obj(rs.getMetaData().getColumnName(i));
    if (relacionamento.contains(proc_relacionamento)) {%>
                <!--Caso seja relacionado-->
                <tr class="solucao">
                    <td colspan="2">
                        <!--Valor do atributo-->
                        <div id="accordion_<%=rs.getMetaData().getColumnName(i).replace(" ", "_")%>">
                            <!--Iteração dos relacionamentos-->
                           <%int pos_relac = relacionamento.indexOf(proc_relacionamento);
                        while (pos_relac != -1) {
                            %>
                            <h3><a href="#"><%=relacionamento.get(pos_relac).getNome_relacionando()%></a></h3>
                            <div>
                                <p>
                                    <%=relacionamento.get(pos_relac).getVl_relac()%>
                                </p>
                            </div>
                            <%
                            relacionamento.remove(pos_relac);
                            pos_relac = relacionamento.indexOf(proc_relacionamento);
                        }%>
                            <!--Fim Iteração dos relacionamentos-->
                        </div>

                        <!--O comando abaixo executa o Accordion do Jquery-->
                        <script type="text/javascript">
                            $(document).ready(function() {
                                $("#accordion_<%=rs.getMetaData().getColumnName(i).replace(" ", "_")%>").accordion();
                            });
                        </script>
                        <!--Fim Accordiom-->

                    </td>
                </tr>
                <!--Fim Caso seja relacionado-->
                <%} else {%>
                <!--Caso não seja relacionado-->
                <tr class="solucao">
                    <td colspan="2">
                        <!--Valor do atributo-->
                        <font>
                            <%= rs.getObject(i).toString()%>
                        </font>
                    </td>
                </tr>
                <%}%>
                <!--Fim Caso não seja relacionado-->
                <tr>
                    <td align="right" style="padding-top:15px">
                        <%}
             //Fim do for principal das colunas
             }
             //Verificar se esse documento está na lista de avaliação do usuário.
             Aval_Obj_UserDAO avaliaDAO = new Aval_Obj_UserDAO();
             List<AvalObjUser> listaAvalia = avaliaDAO.APPP_SEL_AvalObjUser(new AvalObjUser(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()), Long.parseLong(request.getParameter("CD_OBJ").trim())));
             avaliaDAO.fechaConexao();

             if (listaAvalia.size() != 0) {%>
                        <!--Caso Documento está na Lista-->
                        <form action="frmAvaliacao.jsp" method="GET">
                            <input type="hidden" name="CD_OBJ" value="<%= Long.parseLong(request.getParameter("CD_OBJ").trim())%>">
                            <input class="botao" type="submit" name="avaliar" value="Avaliar Documento"/>

                        </form>
                        <%} else {%>
                        <!--Caso documento não está na lista-->
                        <form action="viewAPPP.jsp" method="get">
                            <input type="hidden" name="CD_OBJ" value="<%= Long.parseLong(request.getParameter("CD_OBJ").trim())%>">
                            <input class="botao" type="submit" name="acao" value="Adicionar este documento na minha lista de utilização" />
                        </form>
                        <%}%>
                    </td>
                </tr>
            </table>
            <!--Fim Exibição APPP-->
        </td>
    </tr>
</table>
<%
             relacionamentoDao.fechaConexao();
             rs.close();
         } else {%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <!--Inicio do titulo-->
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: APPP ::..</font> </td>
    </tr>
    <!--Fim do titulo-->
    <tr><td style="padding:10px;"></td></tr>
    <tr>
        <td align="center" style="background-color:rgb(238, 149, 127)">
            <!--Exibição Mensagem de erro-->
            <p><b>Nenhum objeto com esse código foi encontrado.</b></p>
            <!--Fim da Exibição de mensagem de erro-->
        </td>
    </tr>
</table>

<%}

     } catch (SQLException e) {
         GravarLog.gravaErro("viewAPPP.jsp: erro ao pesquisar o Objeto APPP: " + e.getMessage() + " : " + e.getSQLState());
         e.printStackTrace();
     } finally {

         cstmt.close();
         conn.close();
     }
%>

<%} else {%>
<center>
    <h2>Visualiza&ccedil;&atilde;o de Objetos</h2>
    <font class="texto">Este m&oacute;dulo exibe detalhes de um objeto e permite o aviso de utiliza&ccedil;&aacute;o.</font>
    <p><small><font class="texto">Por favor, efetue o login no canto superior direito da p&aacute;gina</font></small></p>
</center>
<%}%>
<div style="display:block;" id="alertPadrao">

</div>
<%@include file="rodape.jsp" %>