<%@include file="cabecalho.jsp"%>
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>


<script type="text/javascript" language="javascript">


    $(document).ready(function(){
    
        $.post("readSessionServlet", {nome: "nomeEstrutura"}, function(dados){
            $("#frmCadEstrutNome").val(dados);
        },"text");

        $.post("readSessionServlet", {nome: "nomeEstrutura"}, function(dados){
            $("#frmCadEstrutDesc").val(dados);
        },"text");

        //Cria editor HTML no campo de descri��o
        var oFCKeditor = new FCKeditor('frmCadEstrutDesc');
        oFCKeditor.BasePath = "./js/fckeditor/";
        oFCKeditor.ToolbarSet="Sigepapp2";
        oFCKeditor.Height=300;
        oFCKeditor.ReplaceTextarea() ;

        //Quando clicar no link "Proximo"
        $("#linkProximo").click(function(){
            //Grava dados no servidor
            $.post("writeSessionServlet", {nomeEstrutura: $("#frmCadEstrutNome").val(), descricaoEstrutura: FCKeditorAPI.GetInstance('frmCadEstrutDesc').GetXHTML() }, null);
        });

    });
</script>

<!--Inicio do formul�rio-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">

    <!--Menu do Wizard-->
    <tr>
        <td id="titulo" style="padding-left:10px">
            <b>Passos:</b>&nbsp;
            <a href="#">Dados da estrutura</a>&nbsp;>&nbsp;
            Tipo de estrutura&nbsp;>&nbsp;
            Defini��o dos Atributos
        </td>
    </tr>
    <!--Fim do menu do Wizard-->

    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset style="width:90%">
                <legend class="legend">Dados da estrutura</legend>
                <table width="100%">
                    <tr>
                        <td align="left">
                            Nome:
                            <input class="edit" type="text" size="50" id="frmCadEstrutNome">
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="padding-top:15px;">
                            Descri&ccedil;&atilde;o:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <textarea rows="20" cols="48" id="frmCadEstrutDesc"></textarea>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
    <tr>
        <td align="center" style="padding-top:10px;">
            <div align="right" style="width:92%">
                <a id="linkProximo" class="navProximo ui-widget-header" href="frmCadEstruturaStep2.jsp">
                    <span>
                        Pr&oacute;ximo
                        <span class="ui-icon ui-icon-circle-arrow-e" style="display:inline-block;vertical-align:middle"></span>
                    </span>
                </a>
            </div>
        </td>
    </tr>
</table>
<!--Fim do formul�rio-->
<%@include file="rodape.jsp"%>
