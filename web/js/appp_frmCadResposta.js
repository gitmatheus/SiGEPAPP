$(document).ready(function(){

    $("#frmCadQuestionarioEnviaResp").click(function(){
        EnviaCadResposta();
        LimpaDescRespostas();
        carregaListaRespostas();
    });
});

function carregaListaRespostas(){
    
    $("#frmCadResp select").empty();
    $.post("GetRespostaServlet", {},
        function(retorno, estado){
            $(retorno).find("Resposta").each(function(indice, conteudo){
                $("#frmCadResp select").each(function(indice2, combotemp){
                    //alert($("#frmCadResp").attr("id"));
                    $(combotemp).append("<option>"+$(conteudo).find("DescResposta").text().toString()+"</option>");
                });
                    
            });
        });
        
}

function LimpaDescRespostas(){
    $("#frmCadQuestionarioDescResp").val('');
}

function EnviaCadResposta(){
    var cd_resposta = 1;
    var ds_resposta = $("#frmCadQuestionarioDescResp").val();

    $.post("CadRespostaServlet", {
        cd_resposta: cd_resposta,
        ds_resposta: ds_resposta

    }, function(xml){
        var confirma = $("sucesso",xml).text();

        if (confirma == "sim"){ //Esse NÃO é para ser SIM porque ??? Tom Mix 01/04/2008
            alert("Resposta cadastrada com sucesso!");
        }else{
            alert("Resposta nao cadastrada devido a um erro!\nTente novamente mais tarde.");
        }
    });
}