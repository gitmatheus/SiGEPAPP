$(document).ready(function(){

    $("#envia_cad_pergunta").click(function(){
        EnviaCadPergunta();
        LimpaDescPergunta();
    });
    
});

function LimpaDescPergunta(){
       $("#frmCadPergRespDescPerg").val('');
}

function EnviaCadPergunta(){
    var cd_pergunta = 1;
    var ds_pergunta="Guilherme Fodao!";
    //var ds_pergunta = $("#frmCadPergRespDescPerg").val();

    $.post("CadPerguntaServlet", {
        cd_pergunta: cd_pergunta,
        ds_pergunta: ds_pergunta

    }, function(xml){
        var confirma = $("sucesso",xml).text();
        
        /*
        if(confirma == "nao" && ds_pergunta!=''){
            alert("Digite sua pergunta no campo !");
        }else
        */

        if (confirma == "sim"){ //Esse NÃO é para ser SIM porque ??? Tom Mix 01/04/2008
            alert("Pergunta cadastrada com sucesso!");
        }else{
            alert("Pergunta nao cadastrada devido a um erro!\nTente novamente mais tarde.");
        }
    });
}