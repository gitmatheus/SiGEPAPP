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
    $("#frmCadUserTelefone").mask("(99)9999-9999");

    $("#adicionaendereco").click(function(){
        adicionaRemoveEndereco('add')
    });
//$("#adicionaendereco").click(function(){$("#adicionaendereco").fadeOut('slow')});

});
function verificaExisteLogin(){
    var login = $("#frmCadUserLogin").val();
    $("#existelogin").html(
        "<input id='frmCadUserLogin' type='text' name='frmCadUserLogin' class='edit' " +
        "style='width: 100px; border-color: #19472a; background-color: #88cfa2; color: #19472a;' " +
        "maxlength='30' title='Digite o login desejado' value='" + login + "' />" +
        "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>verificando...</font>"
        );
    $.post("ExisteLoginServlet",{
        login:login
    },function(xml){
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
        $("#frmCadUserLogin").blur(function(){
            if($("#frmCadUserLogin").val() != ""){
                verificaExisteLogin();
            }
        });
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
    $("#frmCadUserCSenha").blur(function(){
        if($("#frmCadUserSenha").val() != "" && $("#frmCadUserCSenha").val() != ""){
            comparaSenha();
        }
    });
}

function getCidade(){
    var cdestado = $("#frmCadUserEstado").val();
    $("#cadcidade").html(
        "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'></select>" +
        "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>"
        );
    $.get("GetCidadeServlet", {
        cdestado: cdestado
    }, function(xml){
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

function EnviaCadUsuario(){
    var login = $("#frmCadUserLogin").val();
    var senha = $("#frmCadUserSenha").val();
    var email = $("#frmCadUserEmail").val();
    var tipoemail = "P";
    var cpf = new String($("#frmCadUserCPF").val());
    cpf = apenasNumeros(cpf);
    var nome = $("#frmCadUserNome").val();
    var sobrenome = $("#frmCadUserSobrenome").val();
    var datanasc = $("#frmCadUserDataNasc").val();
    var endereco = $("#frmCadUserEndereco").val();
    var nroendereco = $("#frmCadUserNumEnd").val();
    var endcomplemento = $("#frmCadUserEndComplemento").val();
    var tipoendereco = "R";
    var cep = new String($("#frmCadUserCEP").val());
    cep = apenasNumeros(cep);
    var bairro = $("#frmCadUserBairro").val();
    var cidade = $("#frmCadUserCidade").val();
    var telefone = new String($("#frmCadUserTelefone").val());
    telefone =  apenasNumeros(telefone);
    var tipotelefone = "R";
    var msn = $("#frmCadUserMsn").val();
    var skype = $("#frmCadUserSkype").val();
    var areainteresse = $("#frmCadUserAreaInt").val();

    $.post("CadUsuarioServlet", {
        login: login,
        senha: senha,
        email :email,
        tipoemail: tipoemail,
        cpf: cpf,
        nome: nome,
        sobrenome: sobrenome,
        datanasc: datanasc,
        endereco: endereco,
        nroendereco: nroendereco,
        endcomplemento: endcomplemento,
        tipoendereco: tipoendereco,
        cep: cep,
        bairro: bairro,
        cidade: cidade,
        telefone: telefone,
        tipotelefone: tipotelefone,
        msn: msn,
        skype: skype,
        areainteresse: areainteresse
    }, function(xml){
        var confirma = $("sucesso",xml).text();
        if (confirma == "inserido"){
            $("#alertaCadastrado").dialog('open');
        }else{
            if (confirma == "existente")
                $("#alertaExistente").dialog('open');
            else
                $("#alertaErro").dialog('open');
        }
    });

}

function inverterData(str){
    var aux = "";
    aux = str.substring(4, 8);
    aux += str.substring(2,4);
    aux += str.substring(0,2);
    return aux;
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

    $("#alertaCadastrado").dialog({
        autoOpen: false,
        width: 'auto',
        height: 100,
        buttons:{
            "Ok": function(){
                $(this).dialog("close");
                window.location = '/sigepapp';
            }
        }
    });

    $("#alertaExistente").dialog({
        autoOpen: false,
        width: 'auto',
        height: 100,
        buttons:{
            "Ok": function(){
                $(this).dialog("close");
                $("#frmCadUserCPF").focus();
            }
        }
    });

    $("#alertaErro").dialog({
        autoOpen: false,
        width: 'auto',
        height: 200,
        buttons:{
            "Ok": function(){
                $(this).dialog("close");
            }
        }
    });

    $("#envia_cad_user").click(function(){
        EnviaCadUsuario();
    });

    $("#cancela_cad_user").click(function(){
        window.location = '/sigepapp';
    });
});