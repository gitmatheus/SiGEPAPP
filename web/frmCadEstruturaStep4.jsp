<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*, br.edu.fei.sigepapp.bancodedados.model.*, java.sql.* , java.util.Calendar"%>
<%
Estrutura_ObjDAO estrutura_ObjDAO = new Estrutura_ObjDAO();
Atrib_EstruturaDAO atrib_estrut= new Atrib_EstruturaDAO();
//try{
            String tipo_estrutura=new String();
            long cod_estrut = 0;
            String atributos[];

            

            Estrutura estrutura = new Estrutura();
            

            estrutura.setCod_user(35140189879l);
            estrutura.setDs_estrutura(request.getParameter("ds_estrutura"));
            estrutura.setDt_criacao(new Date(Calendar.getInstance().getTimeInMillis()));

            estrutura.setNm_estrutura(request.getParameter("nm_estrutura"));

            Estrutura estrutura_pesquisar=new Estrutura();
            estrutura_pesquisar.setCd_estrutura(Long.parseLong(request.getParameter("cod_estrutura").trim()));

            estrutura_pesquisar=estrutura_ObjDAO.APPP_SEL_Estrutura_OBJ(estrutura_pesquisar, null).get(0);

            //Procura a estrutura que foi derivada
            estrutura.setTp_estrutura(estrutura_pesquisar.getTp_estrutura());


            atributos=request.getParameterValues("atributos_ids");
            
            cod_estrut = estrutura_ObjDAO.APPP_INS_Estrutura_Obj(estrutura);

            estrutura_ObjDAO.fechaConexao();

            for (String codAtrib : atributos) {

                atrib_estrut.APPP_INS_ATRIB_ESTRUTURA(new Atrib_Estrutura(cod_estrut, Long.parseLong(codAtrib.trim())));
            }
            atrib_estrut.fechaConexao();

            out.println("Estrutura: "+cod_estrut+" Tipo de Estrutura: "+request.getParameter("tp_estrutura")+" Nome: "+request.getParameter("nm_estrutura")+"\n Desc:"+request.getParameter("ds_estrutura")+"\nAtrib: "+atributos[1]);
/*}catch(Exception e){
    out.print(e.getMessage());
e.printStackTrace();

}finally{
estrutura_ObjDAO.fechaConexao();
atrib_estrut.fechaConexao();

}

%>

<%@include file="cabecalho.jsp"%>
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>


<script type="text/javascript" language="javascript">

</script>
<%= request.getMethod() %>
<%= request.getParameter("nm_estrutura") %>
<%= request.getParameter("cod_estrutura") %>
<!--Inicio do formulário-->
<form action="#">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">
        <!--Menu do Wizard-->
        <tr>
            <td id="titulo" style="padding-left:10px">
                <a href="#">Passo 1: Dados da estrutura</a> &nbsp;>&nbsp;Passo 2: Tipo de estrutura&nbsp;>&nbsp;Passo 3: Definição dos Atributos
            </td>
        </tr>
        <!--Fim do menu do Wizard-->
        <tr>
            <td align="center" style="padding-top:30px;">
                <h1>Cadastro de estrutura concluído com sucesso</h1>
            </td>
        </tr>
        <!--Navegação no Wizard-->
        <tr>
            <td align="center" style="padding-top:10px;">
               
            </td>
        </tr>
    </table>
</form>
<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
