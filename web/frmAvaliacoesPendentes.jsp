<%@page import="br.edu.fei.sigepapp.log.*,br.edu.fei.sigepapp.bancodedados.*,br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*, java.sql.*, oracle.jdbc.*,java.text.*,java.util.List" %>
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
         * |  Guilherme  |  16/05/09   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         **/
        Aval_Obj_UserDAO avaliaDAO = new Aval_Obj_UserDAO();
        List<AvalObjUser> listaAvalia = avaliaDAO.APPP_SEL_AvalObjUser(new AvalObjUser(Long.parseLong(request.getSession().getAttribute("codigo_usuario").toString()), 0));
        avaliaDAO.fechaConexao();
%>
<%@include file="cabecalho.jsp" %>
<style type="text/css">

</style>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript">

</script>


<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <!--Inicio do titulo-->
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Avalia&ccedil;&otilde;es de APPP ::..</font> </td>
    </tr>
    <!--Fim do titulo-->
    <!--Inicio do Conteudo-->
    <tr>
        <td style="font-size:medium">
            A lista abaixo apresenta o(s) APPP(s) que est&atilde;o na sua lista de utiliza&ccedil;&atilde;o e ainda n&atilde;o foram avaliados:
        </td>
    </tr>
    <tr>
        <td>
            <!--Lista de avaliações pendentes-->
            <table align="center" width="100%" style="padding-top:20px; ">
                <% for (AvalObjUser item_lista : listaAvalia) {%>
                <tr>
                    <td align="center">
                        <%= item_lista.getCd_obj()%>
                        <!--Item da lista-->
                <%
     Connection conn;
     ResultSet rs = null;
     CallableStatement cstmt = null;

     conn = ConnectionFactory.getConnection();
     try {
         cstmt = conn.prepareCall("begin APPP_SEL_APPP_GEN(?,?); end;");
         cstmt.setLong(1, item_lista.getCd_obj());
         cstmt.registerOutParameter(2, OracleTypes.CURSOR);

         cstmt.execute();

         rs = (ResultSet) cstmt.getObject(2);
         while (rs.next()) {
                        %>
                       <a href="viewAPPP.jsp?CD_OBJ=<%= item_lista.getCd_obj() %>"><%= rs.getString("NM_OBJETO")%></a>
                        <%
         }
         rs.close();
         cstmt.close();
         conn.close();

     } catch (Exception e) {
         out.println("Erro ao pesquisar por esta estrutura. Os desenvolvedores já foram informados sobre o erro.Favor tente novamente mais tarde");
         GravarLog.gravaErro("Página de AvaliaçõesPendentes : erro na pesquisa referente a uma exceção:" + e.getMessage()+" - "+e.getLocalizedMessage());
     } finally {
     }

                        %>
                    </td>
                </tr>
                <%}%>
            </table>
            <!--Fim lista de avaliações pendentes-->
        </td>
    </tr>
    <!--Fim do Conteudo-->

</table>
<%@include file="rodape.jsp" %>