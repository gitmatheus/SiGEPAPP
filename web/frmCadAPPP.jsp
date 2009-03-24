<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%@include file="cabecalho.jsp"%>
<%        /**
         * @{#}frmCadAPPP.jsp 0.01 09/01/18
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
         * |   Autor             |   Data        |   Descricao                |
         * |------------------------------------------------------------------|
         * |  Matheus Gonçalves  |  19/03/2009   | Definicao do Cadastro      |
         * |------------------------------------------------------------------|
         **/
%>
<link type="text/css" href="css/ui.all.css" rel="Stylesheet" />
<script src="js/jquery-ui-personalized-1.5.3.js" type="text/javascript"></script>
<%        Estrutura_ObjDAO daoPA = new Estrutura_ObjDAO();
        Estrutura_ObjDAO daoAP = new Estrutura_ObjDAO();
        Estrutura_ObjDAO daoPE = new Estrutura_ObjDAO();

        List<Estrutura> estruturasPA;
        List<Estrutura> estruturasAP;
        List<Estrutura> estruturasPE;

        Estrutura estPA = new Estrutura();
        Estrutura estAP = new Estrutura();
        Estrutura estPE = new Estrutura();


%>
<script type="text/javascript">
    $(function(){
        $('#tabs').tabs();
    });

    $(document).ready(function(){

        $("#frmCadAPPPEstruturaPA").change(function(){
          
          getAtributos();
        });
        // Tabs


        
    });
    function getAtributos(){


            var cod_Estrutura=$("#frmCadAPPPEstruturaPA").val();

            $.post("GetAtribDeEstrutServlet", {codestr: cod_Estrutura}, function(xml,status){
                
                if(status=="success"){
                    //Retorno para estrutura minima
                    $("atributo",xml).each(function(index, item){
                        if( $(item).find("oracletype").text().toUpperCase() == "VARCHAR2"){
                          $("#tabAtributosPE").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                          "<input type='texfield' name='" + $(item).find("nome").text() + "' size='70'>" +
                          "</td></tr>");
                        }

                        if( $(item).find("oracletype").text().toUpperCase() == "DATE"){
                          $("#tabAtributosPE").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                          "<input type='texfield' name='" + $(item).find("nome").text() + "' size='35'>" +
                          "</td></tr>");
                        }
                        if( $(item).find("oracletype").text().toUpperCase() == "NUMBER"){
                          $("#tabAtributosPE").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                          "<input type='texfield' name='" + $(item).find("nome").text() + "'size='50'>" +
                          "</td></tr>");
                        }

                        //"<tr valign=\"middle\">\
                        //<td colspan='2' align='center'>\
                        //<div class='atributoMinimo' style='margin-right: 10px;border-bottom:black solid thin;'>\
                        // "+$(item).find("nome").text()+"</div></td></tr>"

                    });
                    


                }else{
                    alert('Erro ao carregar...!');
                }
            });

            //fim de frmCadEstrTipo.change
        }
</script>
<style type="text/css">
    body{ font: 62.5% Verdana, sans-serif; margin: 50px;}
    #dialog_link {padding: .7em 1em;text-decoration: none;}
</style>

<!-- Tabs -->
<h2 class="demoHeaders">APPP</h2>
<div id="tabs" style="width:95%;left:10px" align="left">

    <ul>
        <li><a href="#tabs-1">Patterns</a></li>
        <li><a href="#tabs-2">Anti-Patterns</a></li>
        <li><a href="#tabs-3">Personas</a></li>
    </ul>
    <div id="tabs-1">
        <table border="0">
            <thead>
                <tr>
                    <th>Preencha os campos:</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>Estrutura: <select class="edit" name="frmCadAPPPEstruturaPA" id="frmCadAPPPEstruturaPA">
                            <option value="">Selecione aqui a estrutura desejada...</option>
                            <%
        estPA.setTp_estrutura("PA");
        estruturasPA = daoPA.APPP_SEL_Estrutura_Geral(estPA);
        daoPA.fechaConexao();

        for (Estrutura e : estruturasPA) {%>
                            <option value="<%= e.getCd_estrutura()%>"><%= e.getNm_estrutura()%></option>
                            <%}%>
                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td><form><table id="tabAtributosPE"></table></form></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="tabs-2">
        <table border="0">
            <thead>
                <tr>
                    <th>Preencha os campos:</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>Estrutura: <select class="edit" name="frmCadAPPPEstruturaAP" id="frmCadAPPPEstruturaAP">
                            <option value="">Selecione aqui a estrutura desejada...</option>
                            <%
        estAP.setTp_estrutura("AP");
        estruturasAP = daoAP.APPP_SEL_Estrutura_Geral(estAP);
        daoAP.fechaConexao();

        for (Estrutura e : estruturasAP) {%>
                            <option value="<%= e.getCd_estrutura()%>"><%= e.getNm_estrutura()%></option>
                            <%}%>
                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="2">
                        
                    </td>

                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>

    <div id="tabs-3">
        <table border="0">
            <thead>
                <tr>
                    <th>Preencha os campos:</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td>Estrutura: <select class="edit" name="frmCadAPPPEstruturaPE" id="frmCadAPPPEstruturaPE">
                            <option value="">Selecione aqui a estrutura desejada...</option>
                            <%
        estPE.setTp_estrutura("PE");
        estruturasPE = daoPE.APPP_SEL_Estrutura_Geral(estPE);
        daoPE.fechaConexao();

        for (Estrutura e : estruturasPE) {%>
                            <option value="<%= e.getCd_estrutura()%>"><%= e.getNm_estrutura()%></option>
                            <%}%>
                        </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<%@include file="rodape.jsp"%>
