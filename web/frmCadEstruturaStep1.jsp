<%@include file="cabecalho.jsp"%>
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>

<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        //Cria editor HTML no campo de descrição
        var oFCKeditor = new FCKeditor('frmCadEstrutDesc');
        oFCKeditor.BasePath = "./js/fckeditor/";
        oFCKeditor.ToolbarSet="Sigepapp2";
        oFCKeditor.Height=300;
        oFCKeditor.ReplaceTextarea() ;

        //Quando clicar no link "Proximo"
        $("#linkProximo").click(function(){
            //Grava dados no servidor
            $(post)

        });

    });
</script>

<!--Inicio do formulário-->
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right" class="formulario">
    <!--Menu do Wizard-->
    <tr>
        <td id="titulo">
            Passo 1: <a href="#">Dados da estrutura</a>&nbsp;>&nbsp;Passo 2: Tipo de estrutura&nbsp;>&nbsp;Passo 3: Definição dos Atributos
        </td>
    </tr>
    <!--Fim do menu do Wizard-->
    <tr>
        <td align="center" style="padding-top:20px;">
            <fieldset style="background-color:#eeeeee;width:80%">
                <legend><b>Dados da estrutura</b></legend>
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
            <div align="right" style="width:80%">
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
<!--Fim do formulário-->
<%@include file="rodape.jsp"%>