<%@include file="cabecalho.jsp"%>
<link rel="stylesheet" type="text/css" href="css/ui.all.css"/>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#frmCadUserLogin").blur(function(){
            if($("#frmCadUserLogin").val() != ""){
                verificaExisteLogin();
            }
        });
        $("#frmCadUserCSenha").blur(function(){
            if($("#frmCadUserSenha").val() != "" && $("#frmCadUserCSenha").val() != ""){
                comparaSenha();
            }
        });
        $("#frmCadUserDataNasc").datepicker({
            regional: ['pt-BR'],
            inline: true
        });
    });
    function verificaExisteLogin(){
        var login = $("#frmCadUserLogin").val();
        $("#existelogin").html(
        "<input id='frmCadUserLogin' type='text' name='frmCadUserLogin' class='edit' " +
            "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;' " +
            "maxlength='30' title='Digite o login desejado' value='" + login + "' />" +
            "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>verificando...</font>"
    );
        $.post("ExisteLoginServlet",{login:login},function(xml){
            if($("liberado",xml).text() == "sim"){
                //alert("Login disponivel!");
                $("#existelogin").html(
                "<input id='frmCadUserLogin' type='text' name='frmCadUserLogin' class='edit' " +
                    "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;' " +
                    "maxlength='30' title='Digite o login desejado' value='" + login + "' />" +
                    "&nbsp;&nbsp;<img src='images/check.png'/>"
            );
                $("#frmCadUserSenha").focus();
                //$("#frmCadUserLogin").css({border-color: "#19472a", background-color: "#88cfa2"});
            }else{
                //alert("Login existente");
                $("#existelogin").html(
                "<input id='frmCadUserLogin' type='text' name='frmCadUserLogin' class='edit' " +
                    "style='width: 100px; border-color: #822007; background-color: #ee957f; color: #822007;' " +
                    "maxlength='30' title='Digite o login desejado' value='" + login + "' />" +
                    "&nbsp;&nbsp;<img src='images/uncheck.png'/>&nbsp;&nbsp;<font size='small' color='#822007'>Este login j&aacute; est&aacute; cadastrado!</font>"
            );
                $("#frmCadUserLogin").select();
                //$("#frmCadUserLogin").css({border-color: "#822007", background-color: "#ee957f"});
            }
            $("#frmCadUserLogin").blur(function(){if($("#frmCadUserLogin").val() != ""){verificaExisteLogin();}});
        });
    }

    function comparaSenha(){
        var senha1 = $("#frmCadUserSenha").val();
        var senha2 = $("#frmCadUserCSenha").val();
        if(senha1 == senha2){
            $("#cadsenha").html(
            "<input id='frmCadUserSenha' type='password' name='frmCadUserSenha' class='edit'" +
                "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;'" +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha1 + "'/>"
        );
            $("#cadconfsenha").html(
            "<input id='frmCadUserCSenha' type='password' name='frmCadUserCSenha' class='edit'" +
                "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;'" +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha2 + "'/>" +
                "&nbsp;&nbsp;<img src='images/check.png'/>"
        );
            $("#frmCadUserEmail").focus();
        }else{
            $("#cadsenha").html(
            "<input id='frmCadUserSenha' type='password' name='frmCadUserSenha' class='edit'" +
                "style='width: 100px; border-color: #822007; background-color: #ee957f; color: #822007;' " +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha1 + "'/>"
        );
            $("#cadconfsenha").html(
            "<input id='frmCadUserCSenha' type='password' name='frmCadUserCSenha' class='edit'" +
                "style='width: 100px; border-color: #822007; background-color: #ee957f; color: #822007;' " +
                "maxlength='30' title='Digite uma senha de acesso' value='" + senha2 + "'/>" +
                "&nbsp;&nbsp;<img src='images/uncheck.png'/>&nbsp;&nbsp;<font size='small' color='#822007'>Senhas n&atilde;o conferem!</font>"
        );
            $("#frmCadUserSenha").select();
        }
        $("#frmCadUserCSenha").blur(function(){if($("#frmCadUserSenha").val() != "" && $("#frmCadUserCSenha").val() != ""){comparaSenha();}});
    }
</script>
<form name="frmCadUser" method="post">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
        <tr>
            <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro de Usu&aacute;rio ::..</font> </td>
        </tr>
        <tr>
            <td align="center">
                <br />
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Login: </font>
                            </div>
                        </td>
                        <td width="70%" align="left" valign="middle">
                            <div id="existelogin" style="margin-left: 5px;">
                                <input id="frmCadUserLogin" type="text" name="frmCadUserLogin" class="edit" style="width: 100px;" maxlength="30" title="Digite o login desejado" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Senha: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div id="cadsenha" style="margin-left: 5px;">
                                <input id="frmCadUserSenha" type="password" name="frmCadUserSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite uma senha de acesso" />
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
                                <input id="frmCadUserCSenha" type="password" name="frmCadUserCSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite novamente a senha de acesso" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> E-mail: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div id="cademail" style="margin-left: 5px;">
                                <input id="frmCadUserEmail" type="text" name="frmCadUserEmail" class="edit" style="width: 380px;" maxlength="100" title="Digite seu email" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Nome: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserNome" type="text" name="frmCadUserNome" class="edit" style="width: 250px;" maxlength="50" title="Digite seu nome" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Sobrenome: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserSobrenome" type="text" name="frmCadUserSobrenome" class="edit" style="width: 250px;" maxlength="50" title="Digite seu sobrenome" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr style="height:25px;">
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto" style=" vertical-align: top;"> Data de Nascimento: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserDataNasc" type="text" name="frmCadUserDataNasc" class="edit" style="width: 70px; vertical-align: middle;" maxlength="10" title="Escolha sua data de nascimento" />&nbsp;&nbsp;
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Endere&ccedil;o: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserEndereco" type="text" name="frmCadUserEndereco" class="edit" style="width: 300px;" maxlength="80" title="Digite seu endere&ccedil;o" />
                                <font class="texto"> n.�: </font>
                                <input id="frmCadUserNumEnd" type="text" name="frmCadUserNumEnd" class="edit" style="width: 40px;" maxlength="6" title="Digite o n&uacute;mero de sua resid&ecirc;ncia" />
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<%@include file="rodape.jsp"%>