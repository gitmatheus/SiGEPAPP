<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%@include file="cabecalho.jsp"%>
<script type="text/javascript" src="js/jquery-ui-1.7.js" ></script>
<script type="text/javascript" language="javascript">
    var alterada = false;
    $(document).ready(function(){
        $("#frmCSenha").blur(function(){
            if($("#frmSenha").val() != "" && $("#frmCSenha").val() != ""){
                comparaSenha();
            }
        });

        $("#envia_altera_senha").click(function(){
            $("#mensagem").html("<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>");
            $("#alert").dialog('open');
            if($("#frmSenha").val()==$("#frmCSenha").val()){
                $.post("AlteraSenhaServlet", {senha:$("#frmSenha").val()}, function(xml){
                    if($("sucesso",xml).text() == "1"){
                        $("#mensagem").html("<img src='images/m2brinfo.png' style='vertical-align:middle;'/> Senha alterada com sucesso.");
                        $("#frmSenha").val("");
                        $("#frmCSenha").val("");
                        alterada = true;
                    }else{
                        $("#mensagem").html("<img src='images/m2brerro.png' style='vertical-align:middle;'/> Houve problemas na alteração da senha,<br /> tente mais tarde.");
                        alterada = false;
                        $("#frmSenha").select();
                    }
                });
            }else{
                $("#mensagem").html("<img src='images/m2brerro.png' style='vertical-align:middle;'/> Os campos devem conter as mesmas informações.");
                $("#frmSenha").select();
                alterada = false;
            }
        });

        $("#cancela_altera_senha").click(function(){
            window.location = '/sigepapp';
        });

    });

    function comparaSenha(){
        var senha1 = $("#frmSenha").val();
        var senha2 = $("#frmCSenha").val();
        if(senha1 == senha2){
            $("#cadsenha").html(
            "<input id='frmSenha' type='password' name='frmSenha' class='edit'" +
                "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;'" +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha1 + "'/>"
        );
            $("#cadconfsenha").html(
            "<input id='frmCSenha' type='password' name='frmCSenha' class='edit'" +
                "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;'" +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha2 + "'/>" +
                "&nbsp;&nbsp;<img src='images/check.png'/>"
        );
        }else{
            $("#cadsenha").html(
            "<input id='frmSenha' type='password' name='frmSenha' class='edit'" +
                "style='width: 100px; border-color: #822007; background-color: #ee957f; color: #822007;' " +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha1 + "'/>"
        );
            $("#cadconfsenha").html(
            "<input id='frmCSenha' type='password' name='frmCSenha' class='edit'" +
                "style='width: 100px; border-color: #822007; background-color: #ee957f; color: #822007;' " +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha2 + "'/>" +
                "&nbsp;&nbsp;<img src='images/uncheck.png'/>&nbsp;&nbsp;<font size='small' color='#822007'>Senhas n&atilde;o conferem!</font>"
        );
            $("#frmSenha").select();
        }
        $("#frmCSenha").blur(function(){
            if($("#frmSenha").val() != "" && $("#frmCSenha").val() != ""){
                comparaSenha();
            }
        });
    }

    $(function(){
        $("#alert").dialog({
            width: 350,
            modal: true,
            autoOpen: false,
            show: 'slide',
            hide: 'slide',
            draggable: false,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                    if (alterada){
                        window.location = '/sigepapp';
                    }
                }
            }
        });
    });
</script>
<form name="frmAlteraSenha" method="post">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
        <tr>
            <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"><font class="titulo">..:: Alteração de Senha ::..</font> </td>
        </tr>
        <tr>
            <td align="center">
                <br />
                <table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Senha: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div id="cadsenha" style="margin-left: 5px;">
                                <input id="frmSenha" type="password" name="frmCadUserSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite uma senha de acesso" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Confirmar senha: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div id="cadconfsenha" style="margin-left: 5px;">
                                <input id="frmCSenha" type="password" name="frmCadUserCSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite novamente a senha de acesso" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" id="envia_altera_senha" name="envia_altera_senha" class="botao" value="Confirmar" title="Confirmar alteração de senha">
                            &nbsp;&nbsp;
                            <input type="button" id="cancela_altera_senha" name="cancela_altera_senha" class="botao" value="Cancelar" title="Cancelar alteração de senha">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<div style="display:block;" id="alert" title="Alerta">
    <div id="mensagem"></div>
</div>

<%@include file="rodape.jsp"%>