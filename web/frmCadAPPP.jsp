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
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script src="js/jquery-ui-personalized-1.5.3.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>


<%      Estrutura_ObjDAO daoPA = new Estrutura_ObjDAO();
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

            getAtributosPA();
        });
        $("#frmCadAPPPEstruturaAP").change(function(){

            getAtributosAP();
        });
        $("#frmCadAPPPEstruturaPE").change(function(){

            getAtributosPE();
        });
        // Tabs



    });
    //Cria editor HTML



    function getAtributosPA(){


        var cod_Estrutura=$("#frmCadAPPPEstruturaPA").val();

        $.post("GetAtribDeEstrutServlet", {codestr: cod_Estrutura}, function(xml,status){

            if(status=="success"){
                //Retorno para estrutura minima

                $("atributo",xml).each(function(index, item){
                    if( $(item).find("oracletype").text().toUpperCase() == "VARCHAR2"){
                        
                        if(       ($(item).find("nome").text().toUpperCase() == ("DESCRIÇÃO")      )
                               || ($(item).find("nome").text().toUpperCase() == ("CONTEXTO")       )
                               || ($(item).find("nome").text().toUpperCase() == ("PROBLEMA")       )
                               || ($(item).find("nome").text().toUpperCase() == ("SOLUÇÃO")        )
                               || ($(item).find("nome").text().toUpperCase() == ("BARREIRAS")      )
                               || ($(item).find("nome").text().toUpperCase() == ("SINTOMAS")       )
                               || ($(item).find("nome").text().toUpperCase() == ("CONSEQUÊNCIAS")  )
                               || ($(item).find("nome").text().toUpperCase() == ("RECOMENDAÇÕES")  )
                          ){
         
                            $("#tabAtributosPA").append("<tr>" + $(item).find("nome").text() + ":<td align='center' colspan='2'>" +
                                "<div  style='margin-left: 5px;'>"    +
                                "<textarea class='edit' id='" + $(item).find("nome").text() +"PA'></textarea>" +
                                "</div></td></tr>");

                            var oFCKeditor = new FCKeditor($(item).find("nome").text() + "PA") ;
                            oFCKeditor.BasePath = "./js/fckeditor/" ;
                            oFCKeditor.ToolbarSet="Sigepapp2";
                            oFCKeditor.Height=300;
                            oFCKeditor.ReplaceTextarea() ;
                            htmltabelaEstrutura=$("#tabAtributosPA").html();
                        }
                        else{
                            $("#tabAtributosPA").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                                "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "PA' size='70'>" +
                                "</td></tr>");
                        }

                    }

                    if( $(item).find("oracletype").text().toUpperCase() == "DATE"){
                        $("#tabAtributosPA").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                            "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "PA' size='35'>" +
                            "</td></tr>");
                    }
                    if( $(item).find("oracletype").text().toUpperCase() == "NUMBER"){
                        $("#tabAtributosPA").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                            "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "PA'size='50'>" +
                            "</td></tr>");
                    }

                });


            }else{
                alert('Erro ao carregar...!');
            }
        });

        //fim de frmCadEstrTipo.change
    }
    function getAtributosAP(){
        var cod_Estrutura=$("#frmCadAPPPEstruturaAP").val();
        $.post("GetAtribDeEstrutServlet", {codestr: cod_Estrutura}, function(xml,status){
            if(status=="success"){
                //Retorno para estrutura minima
                $("atributo",xml).each(function(index, item){
                    if( $(item).find("oracletype").text().toUpperCase() == "VARCHAR2"){
                        if(       ($(item).find("nome").text().toUpperCase() == ("DESCRIÇÃO")      )
                               || ($(item).find("nome").text().toUpperCase() == ("CONTEXTO")       )
                               || ($(item).find("nome").text().toUpperCase() == ("PROBLEMA")       )
                               || ($(item).find("nome").text().toUpperCase() == ("SOLUÇÃO")        )
                               || ($(item).find("nome").text().toUpperCase() == ("BARREIRAS")      )
                               || ($(item).find("nome").text().toUpperCase() == ("SINTOMAS")       )
                               || ($(item).find("nome").text().toUpperCase() == ("CONSEQUÊNCIAS")  )
                               || ($(item).find("nome").text().toUpperCase() == ("RECOMENDAÇÕES")  )
                          ){
                            $("#tabAtributosAP").append("<tr>" + $(item).find("nome").text() + ":<td align='center' colspan='2'>" +
                                "<div  style='margin-left: 5px;'>"    +
                                "<textarea class='edit' id='" + $(item).find("nome").text() +"AP'></textarea>" +
                                "</div></td></tr>");
                            var oFCKeditor = new FCKeditor($(item).find("nome").text() + "AP") ;
                            oFCKeditor.BasePath = "./js/fckeditor/" ;
                            oFCKeditor.ToolbarSet="Sigepapp2";
                            oFCKeditor.Height=300;
                            oFCKeditor.ReplaceTextarea() ;
                            htmltabelaEstrutura=$("#tabAtributosAP").html();
                        }
                        else{
                            $("#tabAtributosAP").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                                "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "AP' size='70'>" +
                                "</td></tr>");
                        }

                    }

                    if( $(item).find("oracletype").text().toUpperCase() == "DATE"){
                        $("#tabAtributosAP").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                            "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "AP' size='35'>" +
                            "</td></tr>");
                    }
                    if( $(item).find("oracletype").text().toUpperCase() == "NUMBER"){
                        $("#tabAtributosAP").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                            "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "AP' size='50'>" +
                            "</td></tr>");
                    }

                });

            }else{
                alert('Erro ao carregar...!');
            }
});

//fim de frmCadEstrTipo.change
}
function getAtributosPE(){


var cod_Estrutura=$("#frmCadAPPPEstruturaPE").val();

$.post("GetAtribDeEstrutServlet", {codestr: cod_Estrutura}, function(xml,status){

    if(status=="success"){
        //Retorno para estrutura minima
        $("atributo",xml).each(function(index, item){
            if( $(item).find("oracletype").text().toUpperCase() == "VARCHAR2"){
                if(       ($(item).find("nome").text().toUpperCase() == ("DESCRIÇÃO")      )
                               || ($(item).find("nome").text().toUpperCase() == ("CONTEXTO")       )
                               || ($(item).find("nome").text().toUpperCase() == ("PROBLEMA")       )
                               || ($(item).find("nome").text().toUpperCase() == ("SOLUÇÃO")        )
                               || ($(item).find("nome").text().toUpperCase() == ("BARREIRAS")      )
                               || ($(item).find("nome").text().toUpperCase() == ("SINTOMAS")       )
                               || ($(item).find("nome").text().toUpperCase() == ("CONSEQUÊNCIAS")  )
                               || ($(item).find("nome").text().toUpperCase() == ("RECOMENDAÇÕES")  )
                          ){
                    $("#tabAtributosPE").append("<tr>" + $(item).find("nome").text() + ":<td align='center' colspan='2'>" +
                        "<div  style='margin-left: 5px;'>"    +
                        "<textarea class='edit' id='" + $(item).find("nome").text() +"PE'></textarea>" +
                        "</div></td></tr>");
                    var oFCKeditor = new FCKeditor($(item).find("nome").text() + "PE") ;
                    oFCKeditor.BasePath = "./js/fckeditor/" ;
                    oFCKeditor.ToolbarSet="Sigepapp2";
                    oFCKeditor.Height=300;
                    oFCKeditor.ReplaceTextarea() ;
                    htmltabelaEstrutura=$("#tabAtributosPE").html();
                }
                else{
                    $("#tabAtributosPE").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                        "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "PE' size='70'>" +
                        "</td></tr>");
                }

            }

            if( $(item).find("oracletype").text().toUpperCase() == "DATE"){
                $("#tabAtributosPE").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                    "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "PE' size='35'>" +
                    "</td></tr>");
            }
            if( $(item).find("oracletype").text().toUpperCase() == "NUMBER"){
                $("#tabAtributosPE").append("<tr><td>" + $(item).find("nome").text() + "</td>" +
                    "<input class='edit' type='texfield' name='" + $(item).find("nome").text() + "PE' size='50'>" +
                    "</td></tr>");
            }

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
                    <td><form><table id="tabAtributosPA"></table></form></td>
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
                    <td><form><table id="tabAtributosAP"></table></form></td>
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
                    <td><form><table id="tabAtributosPE"></table></form></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<%@include file="rodape.jsp"%>
