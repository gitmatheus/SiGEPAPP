$(document).ready(function(){

    $("#envia_cad_pergunta").click(function(){
        EnviaCadUsuario();
    });
});

function EnviaCadUsuario(){
    var cd_pergunta = 1;
    var ds_pergunta = $("#frmCadPergRespDescPerg").val();
    
    $.post("CadPerguntaServlet", {
        cd_pergunta: cd_pergunta,
        ds_pergunta: ds_pergunta

    }, function(xml){
        var confirma = $("sucesso",xml).text();
        if (confirma == "sim"){
            alert("Pergunta cadastrada com sucesso!");
        }else{
            alert("Pergunta nao cadastrada devido a um erro!\nTente novamente mais tarde.");
        }
    });

}