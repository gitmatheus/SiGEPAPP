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
    var tipoemail = $("#frmCadUserTipoEmail").val();
    var cpf = $("#frmCadUserCPF").val();
    var nome = $("#frmCadUserNome").val();
    var sobrenome = $("#frmCadUserSobrenome").val();
    var datanasc = $("#frmCadUserDataNasc").val();
    var endereco = $("#frmCadUserEndereco").val();
    var nroendereco = $("#frmCadUserNumEnd").val();
    var endcomplemento = $("#frmCadUserEndComplemento").val();
    var tipoendereco = $("#frmCadUserTipoEnd").val();
    var cep = $("#frmCadUserCEP").val();
    var bairro = $("#frmCadUserBairro").val();
    var cidade = $("#frmCadUserCidade").val();
    var telefone = $("#frmCadUserTelefone").val();
    var tipotelefone = $("#frmCadUserTipoTel").val();
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
        if (confirma == "sim"){
            alert("Usuario cadastrado com sucesso!");
        }else{
            alert("Usuario nao cadastrado devido a um erro!\nTente novamente mais tarde.");
        }
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
    $("#adicionaemail").click(function(){
        adicionaRemoveEmail('add');
    });
    $("#adicionaendereco2").click(function(){
        alert("Funfou!!!!");
    });
    $("#envia_cad_user").click(function(){
        EnviaCadUsuario();
    });
});


function adicionaRemoveEmail(str){
    var strValue = $("#frmCadUserTipoEmail").val();
    if(str == 'add'){
        strEmail1sadd = "<tr><td width='30%' align='right'><div style='margin-right: 10px;'><font class='texto'> E-mail: </font>" +
        "</div></td><td width='70%' align='left'><div style='margin-left: 5px;'><input id='frmCadUserEmail' type='text'" +
        " name='frmCadUserEmail' class='edit' style='width: 260px;' maxlength='100' title='Digite seu email' value='" + $("#frmCadUserEmail").val() +
        "'/><font class='texto'> Tipo: </font><select id='frmCadUserTipoEmail' name='frmCadUserTipoEmail' class='edit' style='width: auto;'>" +
        "<option value='"+$("#frmCadUserTipoEmail").val()+"'>"+$("#frmCadUserTipoEmail").val()+"</option>";
        if(strValue == "Pessoal"){
            strEmail1sadd += "<option value='Comercial'>Comercial</option></select></div></td></tr>";
        }else{
            strEmail1sadd += "<option value='Pessoal'>Pessoal</option></select></div></td></tr>";
        }
        strEmail2 = "<tr><td width='30%' align='right'><div style='margin-right: 10px;'><font class='texto'> E-mail 2: </font>" +
        "</div></td><td width='70%' align='left'><div style='margin-left: 5px;'><input id='frmCadUserEmail2' type='text'" +
        " name='frmCadUserEmail2' class='edit' style='width: 260px;' maxlength='100' title='Digite seu email'/>" +
        "<font class='texto'> Tipo: </font><select id='frmCadUserTipoEmail2' name='frmCadUserTipoEmail2' class='edit' style='width: auto;'>";
        if(strValue == "Pessoal"){
            strEmail2 += "<option value='Comercial'>Comercial</option><option value='Pessoal'>Pessoal</option></select>" +
        "&nbsp;&nbsp;<a href='#' id='removeemail'><img  src='images/222222_11x11_icon_minus.gif' title='Remove este email' border='0'></a></div></td></tr>";
        }else{
            strEmail2 += "<option value='Pessoal'>Pessoal</option><option value='Comercial'>Comercial</option></select>" +
        "&nbsp;&nbsp;<a href='#' id='removeemail'><img  src='images/222222_11x11_icon_minus.gif' title='Remove este email' border='0'></a></div></td></tr>";
        }
        $("#cademail").html(
            "<table border='0' cellpadding='0' cellspacing='0' width='100%' >"+
            strEmail1sadd + "<tr><td>&nbsp;</td><td>&nbsp;</td></tr>" +
            strEmail2 + "</table>"
            );
        $("#removeemail").click(function(){
            adicionaRemoveEmail('remove');
        });
    }else if(str == 'remove'){
        strEmail1 = "<tr><td width='30%' align='right'><div style='margin-right: 10px;'><font class='texto'> E-mail: </font>" +
        "</div></td><td width='70%' align='left'><div style='margin-left: 5px;'><input id='frmCadUserEmail' type='text'" +
        " name='frmCadUserEmail' class='edit' style='width: 260px;' maxlength='100' title='Digite seu email' value='" + $("#frmCadUserEmail").val() +
        "'/><font class='texto'> Tipo: </font><select id='frmCadUserTipoEmail' name='frmCadUserTipoEmail' class='edit' style='width: auto;'>" +
        "<option value='"+$("#frmCadUserTipoEmail").val()+"'>"+$("#frmCadUserTipoEmail").val()+"</option>";
        if(strValue == "Pessoal"){
            strEmail1 += "<option value='Comercial'>Comercial</option></select>" +
        "&nbsp;&nbsp;<a href='#' id='adicionaemail'><img src='images/222222_11x11_icon_plus.gif' title='Adicionar outro email' border='0'></a></div></td></tr>";
        }else{
            strEmail1 += "<option value='Pessoal'>Pessoal</option></select>" +
        "&nbsp;&nbsp;<a href='#' id='adicionaemail'><img src='images/222222_11x11_icon_plus.gif' title='Adicionar outro email' border='0'></a></div></td></tr>";
        }
        $("#cademail").html(
            "<table border='0' cellpadding='0' cellspacing='0' width='100%' >"+
            strEmail1 + "</table>"
            );
        $("#adicionaemail").click(function(){
            adicionaRemoveEmail('add');
        });
    }
}
var contEndereco = 1;

function adicionaRemoveEndereco(str){
    //var strValue = $("#frmCadUserTipoEnd").val();
    //if(str == 'add'){
    //    strEndsadd =

    //    }
    var frmEndereco = $("#cadendereco").clone();
    //$("#cadendereco").attr("id","cadendereco_old");
    frmEndereco.attr("id","cadendereco" + contEndereco);
    frmEndereco.append("cadendereco");
    frmEndereco.prepend("<tr><td colspan='2'>&nbsp;</td></tr>");
    //$("#adicionaendereco").attr("src", "images/222222_11x11_icon_minus.gif");
    //$("#adicionaendereco").attr("id", "adicionaendereco" + contEndereco);
    //$("#lnkaddendereco").attr("id","lnkaddendereco" + contEndereco);
    //$("#lnkaddendereco" + contEndereco).insertAfter("&nbsp;&nbsp;<a id='" + contEndereco + "' href='#'><img id='removeendereco" + contEndereco + "' src='images/222222_11x11_icon_minus.gif'/></a>");
    //$("#adicionaendereco_old").attr("id", "adicionaendereco");
    //$("#adicionaendereco").hide();
    contEndereco++;
}


