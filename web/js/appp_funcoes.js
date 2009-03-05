/**
 * @{#}appp_funcoes.js 0.01 09/01/18
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * 
 * Este codigo apresenta as funcoes dos scripts encontradas no sistema SiGePAPP
 * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
 * do Centro Universitario da FEI, sob orientação do Prof. Dr. Plinio T. Aquino Jr.
 *
 * |------------------------------------------------------------------|
 * |                   Modificacoes no Codigo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descricao                          |
 * |------------------------------------------------------------------|
 * |  Andrey     |  09/01/18   | Criacao do Arquivo                   |
 * |------------------------------------------------------------------|
 * | Guilherme   |  09/02/21   | Alteracao da funcao de carregamento: |
 * |             |             |trocado $("menubv li") p/ $(menubv td)|
 * |------------------------------------------------------------------|
 * |  Andrey     |  09/02/23   | Inclusao da funcao para chamada do   |
 * |             |             |LoginServlet e validacao de login.    |
 * |------------------------------------------------------------------|
 * |  Andrey     |  09/02/25   | Inclusao da funcao LogonSigepapp e   |
 * |             |             | LogoffSigepapp                       |
 * |------------------------------------------------------------------|
 * |  Guilherme  |  09/02/26   | Ao teclar "Enter" no campo senha     |
 * |             |             | o formulario e submetido             |
 * |------------------------------------------------------------------|
 * |  Andrey     | 09/03/04    | 	Inclusao da funcao para verifica  |
 * |             |             | login existente no sistema, utilizado|
 * |             |             | no cadastro de novos usuarios.       |
 * |------------------------------------------------------------------|
 * |  Andrey     |  09/03/05   |     Inclusao da funcao comparaSenha()|
 * |             |             | para a utilizacao no cadastro de user|
 * |------------------------------------------------------------------|
 */

/** As funcoes contidas dentro do metodo ready, sao poderam ser executadas apos o carregamento da pagina */
$(document).ready(function(){
    /** Funcao que da o efeito de fadein e fadeout no elemento li do menubv e tambem da classe botao */
    $(".menubv td, .botao").hover(function () {
        $(this).fadeTo("slow", 0.4) // Quando o mouse for posicionado sobre o elemento
        },function () {
        $(this).fadeTo("slow", 1); // Apos a retirada do mouse de cima do elemento
    });
    
    /** Funcao para efetuar o login no sistema */
    $("#enviar_login").click(function (){ // identifica o id do elemento que esta gerando o evento
    	LogonSigepapp(); // chama a funcao para efetuar o login
    });
    
    /** Caso o usuario tecle "Enter" no campo senha envia o formulario **/
    $("#senha").keypress(function(event){
        if(event.keyCode==13){
            $("#enviar_login").click();
        }
    });
    
});

/** Funcao para chamar a servlet de verificacao do login */
function LogonSigepapp(){
	var usuario = $("#usuario").val(); // atribui o valor de elemento identificado como usuario para a variavel usuario
	var senha = $("#senha").val(); // atribui o valor de elemento identificado como senha para a variavel senha
	
	// exibe mensagem de aguarde
	$("#syslogin").html("<center><img src='images/aguarde.gif'/> <h2>Por favor, aguarde...</h2></center>");
	
	// metodo post do jquery composto pelo programa/pagina chamada, array de atributos e seus valores, funcao passando xml para verificar o retorno
	$.post("LoginServlet",{usuario: usuario, senha: senha, logoff: ""}, function(xml){
		
		// converter o valor da tag xml confirma em inteiro
		var confirma = parseInt($("codigo",xml).text());
		// verifica a valor do flag confirma
		if(confirma != 0){// se 1, exibe codigo html na posicao do elemento identificado como syslogin
			$("#syslogin").html(
				"<h2>Seja bemvindo,<br /> " + $("usuario",xml).text() + "</h2>" +
				"<div align='right' style='margin-right: 10px;'>| " +
				"<a id='envia_logoff' href='#' class='painelcontrole' title='Sair do sistema'>Sair</a>" +
				//"<input id='envia_logoff' type='button' class='painelcontrole' title='Sair do sistema' value='Sair' /></div>" +
				"</div>"+
				"<input type='hidden' id='status' value='logoff' />" 
			);
			/** Funcao para efetuar logoff do sistema */
			$("#envia_logoff").click(function(){ // E deixa pronto para receber o evento click do identificador envia_logoff
				LogoffSigepapp(); // apos evento do click no identificador chama a fun�ao de logoff
				//$("#syslogin").html("<h2>Funcionou!</h2>");
			});

		}else{
			$("#syslogin").html( // em caso de erro exibe mensagem de erro no a tela e espera 2 seg para liberar o formulario de login
					"<center><h2 style='color: red;'>Erro no login!</h2></center>" +
					"<script type='text/javascript'>window.setTimeout('window.location.replace(" +
					'"index.jsp")' +
					"',2000);</script>" +
					"<center><img src='images/aguarde.gif'/><h2>Por favor, aguarde...</h2></center>"
			);
		}
		
	});
}

/** Funcao para efetuar logoff do sistema */
function LogoffSigepapp(){
	var logoff = $("#status").val(); // atribui o valor do identificador status para a variavel logoff
	
	$.post("LoginServlet", {usuario: "", senha: "", logoff: logoff}, function(xml){ // envia para a servlet os atributos de senha e usuario vazio e o atributo de logoff como ativo 
		var confirma = parseInt($("codigo",xml).text()); // converter o valor da tag xml confirma em inteiro
			if(confirma == 0){ // se confirma igual a 0 entao ele aguarda 2 seg para liberar o formulario novamente
			//load("index.jsp");
				$("#syslogin").html("<script type='text/javascript'>window.setTimeout('window.location.replace(" +
		    						'"index.jsp")' +
		    						"',2000);</script>" +
		    						"<center><img src='images/aguarde.gif'/><h2>Por favor, aguarde...</h2></center>");
			}
	});
}
//----------- Inicio das funcoes do cadastro de usuario no sistema ------------------------------------------------------------------
/** Funcao para verificar se existe um login igual ao escolhido pelo usuario no sistema */
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
//----------- Fim das funcoes do cadastro de usuario no sistema ------------------------------------------------------------------

/** A funcao Data retorna por extenso a data, e.g.: Segunda-Feira, 19 de janeiro de 2009 */
function Data(){
    function SetNameArray(item) {
        this.length = item
        return this
    }
    Month = new SetNameArray(12)
    Month[1] = "janeiro"
    Month[2] = "fevereiro"
    Month[3] = "mar&ccedil;o"
    Month[4] = "abril"
    Month[5] = "maio"
    Month[6] = "junho"
    Month[7] = "julho"
    Month[8] = "agosto"
    Month[9] = "setembro"
    Month[10] = "outubro"
    Month[11] = "novembro"
    Month[12] = "dezembro"

    WeekDay = new SetNameArray(7)
    WeekDay[1] = "Domingo"
    WeekDay[2] = "Segunda-feira"
    WeekDay[3] = "Ter&ccedil;a-feira"
    WeekDay[4] = "Quarta-feira"
    WeekDay[5] = "Quinta-feira"
    WeekDay[6] = "Sexta-feira"
    WeekDay[7] = "S&aacute;bado"

    theDate = new Date()
    var theWeekDay = WeekDay[theDate.getDay() + 1]
    var theMonth = Month[theDate.getMonth() + 1]
    var theYear = theDate.getYear() + 1900
    if (theYear>3000)
        theYear=theYear-1900;
    document.write(theWeekDay);
    document.write(",&nbsp;");
    document.write(theDate.getDate() + " de " + theMonth)
    document.write(" de " +theYear);
}