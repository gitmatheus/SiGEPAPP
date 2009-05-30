var msgAlerta = "";
var cdcidadetemp = "";
var cidadetemp = "";
function valida(){
    var retorno=false;
    //Validações do cadastro
    if ($.trim($("#frmCadUserLogin").val())=="" && $("#flagEdit").val()=='nao'){
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Login";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserSenha").val())=="" && $("#flagEdit").val()=='nao')  {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Senha";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserCSenha").val())=="" && $("#flagEdit").val()=='nao') {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Confirmação de Senha";
        $("#alert").dialog('open');
    }else if ($.trim($("#frmCadUserEmail").val())=="") {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Email";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserCPF").val())=="" && $("#flagEdit").val()=='nao') {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de CPF";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserNome").val())==""){
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Nome";
        $("#alert").dialog('open');
    }else if ($.trim($("#frmCadUserSobrenome").val())=="") {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Sobrenome";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserDataNasc").val())=="")  {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Data de Nascimento";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserEndereco").val())=="")  {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Endereço";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserNumEnd").val())==""){
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Número de Endereço";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserCEP").val())=="") {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de CEP";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserBairro").val())==""){
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Bairro";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserEstado").val())=="") {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, selecione um Estado";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserCidade").val())=="") {
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, selecione uma Cidade";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserTelefone").val())==""){
        msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Por favor, preencha o campo de Telefone";
        $("#alert").dialog('open');
    }else if($.trim($("#frmCadUserEndComplemento").val())==""){
        $("#frmCadUserEndComplemento").val(" ");
        retorno=true;
    }else{
        retorno=true;
    }
    return retorno;
//Fim das validações do cadastro

}

$(document).ready(function(){
    $.ajaxSetup({
        async: false
    });
        
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
        yearRange: '1920:2050',
        dateFormat: 'dd/mm/yy',
        inline: true,
        changeMonth: true,
        changeYear: true,
        showOn: 'button',
        buttonImageOnly: true,
        buttonText: 'Clique para escolher uma data',
        buttonImage: 'images/smallcalendar.png'
    });

    $("#frmCadUserCEP").mask("99999-999");
    $("#frmCadUserDataNasc").mask("99/99/9999");
    $("#frmCadUserCPF").mask("999.999.999-99");
    $("#frmCadUserTelefone").mask("(99)9999-9999");
    $("#frmCadUserNumEnd").mask("99999");
    $("#frmCadUserDataNasc").val("");
    
    if($("#flagEdit").val() == 'sim'){
        carregaUsuario();
    }

    $("#frmCadUserEstado").change(function(){
        if($("#frmCadUserEstado").val() != ""){
            getCidade();
        }
    });

    

    $("#adicionaendereco").click(function(){
        adicionaRemoveEndereco('add')
    });
    //$("#adicionaendereco").click(function(){$("#adicionaendereco").fadeOut('slow')});

    $("#alertaCadCidade").show();
    $("#alertaCadastrado").show();
    $("#alertaExistente").show();
    $("#alertaErro").show();

});

function carregaUsuario(){
    $.post("GetUsuarioServlet",{}, function(xml){
        $("#frmCadUserEmail").val($("Email",xml).text());
        $("#frmCadUserNome").val($("PrimNome",xml).text());
        $("#frmCadUserSobrenome").val($("SobreNome",xml).text());
        dt = $("DataNasc",xml).text();
        $("#frmCadUserDataNasc").val(dt.substring(8, 10) + "/" + dt.substring(5, 7) + "/" + dt.substring(0, 4));
        $("#frmCadUserEndereco").val($("Endereco",xml).text());
        $("#frmCadUserNumEnd").val($("Nro",xml).text());
        $("#frmCadUserEndComplemento").val($("Complemento",xml).text());
        $("#frmCadUserCEP").val($("Cep",xml).text());
        $("#frmCadUserEstado").val($("CdEstado",xml).text());
        getCidade();
        $("#frmCadUserCidade").val($("CdCidade",xml).text());
        $("#frmCadUserTelefone").val($("Telefone",xml).text());
        $("#frmCadUserMsn").val($("Msn",xml).text());
        $("#frmCadUserSkype").val($("Skype",xml).text());
        $("#frmCadUserAreaInt").val($("AreaInteresse",xml).text());
        
    });
}

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

function AtualizaCadUsuario(){
    $("#frmCadUserLogin").val("update");
    $("#frmCadUserSenha").val("update");
    $("#frmCadUserCPF").val("1111111111");
    if(valida()){
        email = $("#frmCadUserEmail").val();
        tipoemail = "P";
        nome = $("#frmCadUserNome").val();
        sobrenome = $("#frmCadUserSobrenome").val();
        datanasc = $("#frmCadUserDataNasc").val();
        endereco = $("#frmCadUserEndereco").val();
        nroendereco = $("#frmCadUserNumEnd").val();
        endcomplemento = $("#frmCadUserEndComplemento").val();
        tipoendereco = "R";
        cep = new String($("#frmCadUserCEP").val());
        cep = apenasNumeros(cep);
        bairro = $("#frmCadUserBairro").val();
        cidade = $("#frmCadUserCidade").val();
        telefone = new String($("#frmCadUserTelefone").val());
        telefone =  apenasNumeros(telefone);
        tipotelefone = "R";
        msn = $("#frmCadUserMsn").val();
        skype = $("#frmCadUserSkype").val();
        areainteresse = $("#frmCadUserAreaInt").val();

        $.post("UpdUsuarioServlet", {
            email :email,
            tipoemail: tipoemail,
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
            var confirma = $("erro",xml).text();
            if(confirma == '0'){
                msgAlerta = "<img src='images/m2brinfo.png' style='vertical-align:middle;'/> Atualização realizada com sucesso.";
                $("#info").dialog('open');
                
            }else if(confirma == '2'){
                msgAlerta = "<img src='images/m2bralerta.png' style='vertical-align:middle;'/> Alguns de seus dados não sofreram alteração.<br>Por favor confira suas informações.";
                $("#alerta").dialog('open');
            }else{
                msgAlerta = "<img src='images/m2brerro.png' style='vertical-align:middle;'/> Problemas durante a atualização dos seus dados.";
                $("#alerta").dialog('open');
            }
            
        });
    }
}

function EnviaCadUsuario(){
    if (valida()){

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

    $("#alert").dialog({
        width: 300,
        modal: true,
        autoOpen: false,
        show: 'slide',
        hide: 'slide',
        draggable: false,
        buttons: {
            "Ok": function(){
                $(this).dialog("close");
            }
        },
        open: function(){
            $(this).html(msgAlerta);
        },
        close: function(){
            $("#alert").html("");
            msgAlerta = "";
        }
    });

    $("#info").dialog({
        width: 300,
        modal: true,
        autoOpen: false,
        show: 'slide',
        hide: 'slide',
        draggable: false,
        buttons: {
            "Ok": function(){
                $(this).dialog("close");
                window.location = '/sigepapp/';
            }
        },
        open: function(){
            $(this).html(msgAlerta);
        },
        close: function(){
            $("#alert").html("");
            msgAlerta = "";
        }
    });

    $("#envia_cad_user").click(function(){
        if($("#flagEdit").val() == 'sim'){
            AtualizaCadUsuario();
        }else{
            EnviaCadUsuario();
        }
    });

    $("#cancela_cad_user").click(function(){
        window.location = '/sigepapp';
    });
});