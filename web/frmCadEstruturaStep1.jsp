<%@include file="cabecalho.jsp"%>
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadEstrutura.js"></script>

<script type="text/javascript" language="javascript">


    function valida_desc(){
        //Verifica se o nome da estrutura é vazio
var descricao=FCKeditorAPI.GetInstance('frmCadEstrutDesc').GetXHTML();
        if($.trim(descricao)!=""){

            $("#divMsgCadEstrutDesc").hide();

            return true;
        }else{
            $("#tagDescricao").attr("style", "color: #822007;display:inline-block");
            $("#divMsgCadEstrutDesc").html("<img src='images/uncheck.png'>&nbsp;Preencha a Descri&ccedil;&atilde;o da estrutura.");
            $("#divMsgCadEstrutDesc").show();
            return false;
        }

    }
    function valida_nome(){
        var msg=validaNome();
        if(msg!=null){
            $("#frmCadEstrutNome").attr("style", "border-color: #822007; background-color: #ee957f;color: #822007;display:inline-block");
            $("#divMsgCadEstrutNome").html("<img src='images/uncheck.png'>"+msg);
            $("#divMsgCadEstrutNome").show();
            $("#frmCadEstrutNome").select();
            return false;
        }else{
            $("#frmCadEstrutNome").removeAttr("style");
            $("#divMsgCadEstrutNome").hide();
            return true;
        }
    }
    $(document).ready(function(){

        $("#divMsgCadEstrutNome").hide();
        $("#divMsgCadEstrutDesc").hide();
        //Valida Nome da Estrutura
        $("#frmCadEstrutNome").blur(function(){
            valida_nome();
        });
        //Valida Descrição da Estrutura

        //Fim das validações

        $.ajaxSetup({async: false});

        $.post("readSessionServlet", {nome: "nomeEstrutura"}, function(dados){
            $("#frmCadEstrutNome").val(dados);
        },"text");

        $.post("readSessionServlet", {nome: "descricaoEstrutura"}, function(dados){
            $("#frmCadEstrutDesc").val(unescape(dados));
        },"text");

        //Cria editor HTML no campo de descrição
        var oFCKeditor = new FCKeditor('frmCadEstrutDesc');
        oFCKeditor.BasePath = "./js/fckeditor/";
        oFCKeditor.ToolbarSet="Sigepapp2";
        oFCKeditor.Height=300;
        oFCKeditor.ReplaceTextarea() ;


        //Quando clicar no link "Proximo"
        $("#linkProximo").click(function(){
            //Grava dados no servidor
            //alert(escape(FCKeditorAPI.GetInstance('frmCadEstrutDesc').GetXHTML()));
            if(valida_nome()==true && valida_desc()==true) {
                $.post("writeSessionServlet", {nomeEstrutura: $("#frmCadEstrutNome").val(), descricaoEstrutura: escape(FCKeditorAPI.GetInstance('frmCadEstrutDesc').GetXHTML()) }, null);
                return true;
            }else{
                return false;
            }


        });
    });
</script>

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
            <td align="center" style="padding-top:20px;">
                <fieldset style="width:90%">
                    <legend><b>Dados da estrutura</b></legend>
                    <table width="100%">
                        <tr>
                            <td align="left" valign="middle">
                                Nome:
                                <input class="edit" type="text" size="30" id="frmCadEstrutNome">
                                <div id="divMsgCadEstrutNome" style="display:inline-block;vertical-align:middle;"></div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="padding-top:15px;" id="tagDescricao">
                                Descri&ccedil;&atilde;o:<div id="divMsgCadEstrutDesc" style="display:inline-block;vertical-align:middle;"></div>
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
</form>
<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
