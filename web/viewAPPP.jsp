<%@page import="br.edu.fei.sigepapp.log.*,br.edu.fei.sigepapp.bancodedados.*,java.sql.*,oracle.jdbc.*,java.text.*"%>
<%
        Connection conn;
        ResultSet rs = null;
        CallableStatement cstmt = null;

        conn = ConnectionFactory.getConnection();
        try {
            cstmt = conn.prepareCall("begin APPP_SEL_APPP_GEN(?,?); end;");
            cstmt.setLong(1, Long.parseLong(request.getParameter("CD_OBJ")));
            cstmt.registerOutParameter(2, OracleTypes.CURSOR);

            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(2);

            int TotalCols = rs.getMetaData().getColumnCount();


            while (rs.next()) {


%>
<%@include file="cabecalho.jsp" %>
<style type="text/css">
    .nome{
        font-size:medium;
    }

    .contexto font, .problema font, .solucao font{
        line-height:1.4em;
        
    }

    .titulo_contexto, .titulo_problema, .titulo_solucao{
        font-size:small;
        font-weight:bold;
        padding-top:15px;
    }
</style>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){

    });


</script>


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
                <tr><td class="titulo_contexto">Contexto:</td></tr>
                <tr class="contexto">
                    <td colspan="2">
                        <font>
                            <%=rs.getString("DS_OBJETO").trim()%>
                        </font>

                    </td>
                </tr>
                <!--Fim Contexto do Objeto-->
                <!--Problema do Objeto-->
                <tr><td class="titulo_problema">Problema:</td></tr>
                <tr class="problema">
                    <td colspan="2">
                        <font>
                            <%
        String TabelaProblema = new String();
        if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("PATTERN")) {%>

                            <%= rs.getString("PROBLEMA PATTERN").trim()%>

                            <%TabelaProblema = "PROBLEMA PATTERN";
                            } else if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("ANTI_PATTERN")) {%>
                            <%= rs.getString("DS_PROBLEMA").trim()%>
                            <%
                                TabelaProblema = "DS_PROBLEMA";
                            } else {%>
                            <%= rs.getString("Problema").trim()%>
                            <%
            TabelaProblema = "Problema";
        }

                            %>
                        </font>
                    </td>
                </tr>
                <!--Fim Problema do Objeto-->
                <!--Solução do Objeto-->
                <tr><td class="titulo_solucao">Solucao:</td></tr>
                <tr class="solucao">
                    <td colspan="2">
                        <font>
                            <%
        String TabelaSolucao = new String();
        if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("PATTERN")) {
            out.println(rs.getString("Solução Pattern").trim());
            TabelaSolucao = "Solução Pattern";
        } else if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("ANTI_PATTERN")) {
            out.println(rs.getString("Solução Anti-Pattern").trim());
            TabelaSolucao = "Solução Anti-Pattern";
        } else {
            out.println(rs.getString("Solução").trim());
            TabelaSolucao = "Solução";
        }

                            %>
                        </font>
                    </td>
                </tr>
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
                    !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("NM_ESTRUTURA")) {%>
                <tr>
                    <td style="">
                        <%= rs.getMetaData().getColumnName(i)%>
                        <%= rs.getObject(i).toString()%>
                    </td>
                </tr>

                <%}
        //Fim do for principal das colunas
        }%>
            </table>
            <!--Fim Exibição APPP-->
        </td>
    </tr>
</table>
<%
            }
            rs.close();
            cstmt.close();
            conn.close();
        } catch (SQLException e) {
            GravarLog.gravaErro("viewAPPP.jsp: erro ao pesquisar o Objeto APPP: " + e.getMessage() + " : " + e.getSQLState());

        } finally {
            rs.close();
            cstmt.close();
        }
%>
<%@include file="rodape.jsp" %>