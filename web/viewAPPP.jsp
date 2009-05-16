<%@page import="br.edu.fei.sigepapp.log.*,br.edu.fei.sigepapp.bancodedados.*,java.sql.*,oracle.jdbc.*"%>
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

                /*    out.println("<Atributo>");
                out.println("<Nome>");
                out.println(rs.getMetaData().getColumnName(i));
                out.println("</Nome>");
                out.println("<Tipo>");
                out.println(rs.getMetaData().getColumnTypeName(i));
                out.println("</Tipo>");
                out.println("<Valor>");
                out.println(rs.getObject(i).toString());
                out.println("</Valor>");
                out.println("</Atributo>");
                 */


%>
<%@include file="cabecalho.jsp" %>
<style type="text/css">

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
            <table id="tbl_APPP" border="0" cellspacing="0" cellpadding="0" width="80%" align="center" style="" >
                <tr>
                    <td colspan="2"">
                        <% if (rs.getString("TP_ESTRUTURA").trim().equalsIgnoreCase("PA")) {%>
                        <font>
                            [Pattern]
                        </font>
                        <%} else if (rs.getString("TP_ESTRUTURA").trim().equalsIgnoreCase("AP")) {%>
                        <font>
                            [Anti-Pattern]
                        </font>
                        <%} else {%>
                        <font>
                            [Persona]
                        </font>
                        <%}%>
                    </td>
                </tr>
                <!--Nome do Objeto-->
                <tr>
                    <td colspan="2">
                        <font>
                            <%=rs.getString("NM_OBJETO").trim()%>
                        </font>
                    </td>
                </tr>
                <!--Fim Nome do Objeto-->
                <!--Contexto do Objeto-->
                <tr>
                    <td colspan="2">
                        <font>
                            <%=rs.getString("DS_OBJETO").trim()%>
                        </font>
                    </td>
                </tr>
                <!--Fim Contexto do Objeto-->
                <!--Problema do Objeto-->
                <tr>
                    <td colspan="2">
                        <font>
                            <%
        if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("PATTERN")) {
            rs.getString("PROBLEMA PATTERN").trim();
        } else if (rs.getString("NM_ESTRUTURA").trim().equalsIgnoreCase("ANTI_PATTERN")) {
            rs.getString("PROBLEMA ANTI-PATTERN").trim();
        } else {
        }

                            %>
                        </font>
                    </td>
                </tr>
                <!--Fim Problema do Objeto-->
                <!--Solução do Objeto-->
                <tr>
                    <td colspan="2">
                        <font>
                            <%=rs.getString("NM_OBJETO").trim()%>
                        </font>
                    </td>
                </tr>
                <!--Fim Solução do Objeto-->
                <%
        //For Principal para cada coluna
        for (int i = 1; i <= TotalCols; i++) {

                %>

                <%if (!rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("TP_ESTRUTURA") &&
                    !rs.getMetaData().getColumnName(i).trim().equalsIgnoreCase("NM_OBJETO")) {%>
                <tr>
                    <td style="border-bottom-style:solid;border-bottom-width:1px;padding-bottom:40px;">
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
        } catch (SQLException e) {
            GravarLog.gravaErro("viewAPPP.jsp: erro ao pesquisar o Objeto APPP: " + e.getMessage() + " : " + e.getSQLState());

        } finally {
            out.close();
        }
%>
<%@include file="rodape.jsp" %>