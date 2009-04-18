
$(document).ready(function(){
    carregaListaRespostas();

    $("#frmCadQuestionarioEnviaResp").click(function(){
        EnviaCadResposta();
        LimpaDescRespostas();
        carregaListaRespostas();
    });
});

function carregaListaRespostas(){
    $("#FrmCadQuestionarioComboResp").empty();
    $.post("GetRespostaServlet", {},
        function(retorno, status){
            $(retorno).find("Resposta").each(
                function(indice, conteudo){
                    //$(conteudo).find("Cod").text();
                    $("#FrmCadQuestionarioComboResp").append("<option>"+$(conteudo).find("DescResposta").text()+"</option>");
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