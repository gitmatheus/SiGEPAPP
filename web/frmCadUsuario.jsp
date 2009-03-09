<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%
        EstadoDAO dao = new EstadoDAO();
        Collection<Estado> estados;
        estados = dao.APPP_SEL_ESTADO(new Estado());
        dao.fechaConexao();
%>
<%@include file="cabecalho.jsp"%>
<link rel="stylesheet" type="text/css" href="css/ui.all.css"/>
<script type="text/javascript" src="js/jquery-ui-1.5.3.js" ></script>
<script type="text/javascript" src="js/jquery.maskedinput-1.2.1.js"></script>
<script type="text/javascript" language="javascript" src="js/i18n/ui.datepicker-pt-BR.js"></script>
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
            language: 'pt-BR',
            yearRange: '1950:2050',
            dateFormat: 'dd/mm/yy',
            inline: true
        });

        $("#frmCadUserEstado").change(function(){
            if($("#frmCadUserEstado").val() != ""){
                getCidade();
            }
        });

        $("#frmCadUserCEP").mask("99999-999");
        $("#frmCadUserDataNasc").mask("99/99/9999");
        $("#frmCadUserCPF").mask("999.999.999-99");
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

    function getCidade(){
        var cdestado = $("#frmCadUserEstado").val();
        $("#cadcidade").html(
        "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'></select>" +
            "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>"
    );
        $.get("GetCidadeServlet", {cdestado: cdestado}, function(xml){
            var qtdecidades = parseInt($("nro_cidades",xml).text());
            var strComboCidade = "";
            if(qtdecidades > 0){
                strComboCidade += "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'>";
                for(i = 0; i < qtdecidades;i++){
                    cdcid = "cd_cidade" + i;
                    nmcid = "nm_cidade" + i;
                    strComboCidade += "<option value='" + $(cdcid,xml).text() + "'>" + $(nmcid,xml).text() +"</option>";
                }
                strComboCidade +="</select>";
            }else{
                $("#alertaCadCidade").dialog('open');
                strComboCidade = "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'></select>";
            }
            $("#cadcidade").html(strComboCidade);
        });
    }
    $(function(){
        $("#alertaCadCidade").dialog({
            autoOpen: false,
            width: 'auto',
            height: 100,
            buttons: {
                "Ok": function(){
                    $(this).dialog("close");
                }
            }
        });
    });

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
                                <font class="texto"> CPF: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserCPF" type="text" name="frmCadUserCPF" class="edit" style="width: 100px;" maxlength="15" title="Digite aqui seu cpf" />
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
                                <input id="frmCadUserDataNasc" type="text" name="frmCadUserDataNasc" class="edit" style="width: 70px; vertical-align: middle;" maxlength="10" title="Digite ou escolha sua data de nascimento" />&nbsp;&nbsp;
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
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> CEP: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserCEP" name="frmCadUserCEP" class="edit" style="width: 60px;" title="Digite aqui o cep do endere&ccedil;o acima"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Bairro: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserBairro" name="frmCadUserBairro" class="edit" style="width: 150px;" maxlength="50" title="Digite o nome de seu bairro"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Estado: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <select id="frmCadUserEstado" name="frmCadUserEstado" class="edit" style="width: auto;">
                                    <option value="">Selecione aqui o seu estado</option>
                                    <% for (Estado e : estados) {%>
                                    <option value="<%= e.getCd_estado()%>"><%= e.getSg_sigla()%>&nbsp;-&nbsp;<%= e.getNm_estado()%></option>
                                    <%}%>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Cidade: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div id="cadcidade"  style="margin-left: 5px;">
                                <select id="frmCadUserCidade" name="frmCadUserCidade" class="edit" style="width: auto;"></select>
                            </div>
                            <div id="alertaCadCidade" title="Cidades n�o cadastradas">
                                Desculpe, mas n�o foram encontradas cidades cadastradas para este estado!
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Pais: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserPais" name="frmCadUserPais" class="edit" style="width: 150px;" maxlength="50" title="Digite seu pais de origem"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Telefone/Celular: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserTelefone" name="frmCadUserTelefone" class="edit" style="width: 70px;" maxlength="15" title="Digite o n�mero de telefone de seu interesse"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> MSN: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserMsn" name="frmCadUserMsn" class="edit" style="width: 150px;" maxlength="50" title="Digite seu endere&ccedil;o de msn"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Skype: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserSkype" name="frmCadUserSkype" class="edit" style="width: 150px;" maxlength="50" title="Digite seu identificador do Skype"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> &Aacute;rea de interesse: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <textarea id="frmCadUserAreaInt" name="frmCadUserAreaInt" class="edit" cols="60" rows="5" title="Digite sua &aacute;rea de interesse" >Digite aqui sua &aacute;rea de interesse...</textarea>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" id="envia_cad_user" name="envia_cad_user" class="botao" value="Confirmar" title="Confirmar cadastro de usu�rio">
                            &nbsp;&nbsp;
                            <input type="button" id="cancela_cad_user" name="cancela_cad_user" class="botao" value="Cancelar" title="Cancelar cadastro de usu�rio">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<%@include file="rodape.jsp"%>