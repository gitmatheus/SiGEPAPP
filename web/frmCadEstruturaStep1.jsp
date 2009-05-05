<%@include file="cabecalho.jsp"%>
<link type="text/css" rel="stylesheet" href="css/jquery-ui-1.7.css">
<link type="text/css" rel="stylesheet" href="css/appp_css.css">

<script type="text/javascript" language="javascript" src="js/jquery.tinysort.js"></script>
<script type="text/javascript" language="javascript" src="js/jquery-ui-1.7.js"></script>
<script type="text/javascript" language="javascript" src="js/fckeditor/fckeditor.js"></script>


<script type="text/javascript" language="javascript">


    function valida_campos_step1(){
        var nome_estrut=$.trim($("#frmCadEstrutNome").val());
        //Verifica se o nome da estrutura é vazio
        if(nome_estrut==""){
            $("#frmCadEstrutNome").parent("td").html(
                "Nome:"+
                "<input class='edit' type='text' size='30' id='frmCadEstrutNome' value='"+nome_estrut+"' "+
                "style='border-color: #822007; background-color: #ee957f; color: #822007;'>"+
                "<img src='images/uncheck.png'/>"+
                "<font size='small' color='#822007'>&nbsp;O&nbsp;nome&nbsp;deve&nbsp;ser&nbsp;preenchido</font>"
        );
            $("#frmCadEstrutNome").focus();
            return false;
        }else{
            
            //Verifica se já existe um documento com esse nome
           // if($("#frmCadEstrutNome"))

            return true;
        }

    }

    $(document).ready(function(){

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
            if(valida_campos_step1()==true){
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
</form>
<!--Fim do formulário-->
<%@include file="rodape.jsp"%>
