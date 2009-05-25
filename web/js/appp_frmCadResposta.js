$(document).ready(function(){

    $("#frmCadQuestionarioEnviaResp").click(function(){
        EnviaCadResposta();
        LimpaDescRespostas();
        carregaListaRespostas();
    });
});

function carregaListaRespostas(){
    
    $.ajaxSetup({
        async: false
        });
    $.post("GetRespostaServlet", {},
        function(retorno, estado){
            $("#frmCadResp select").each(function(indice2, combotemp){
                var selecionado= $(combotemp).find("option:selected").text();
                $(combotemp).empty();
                $(combotemp).append("<option> </option>");
                $(retorno).find("Resposta").each(function(indice, conteudo){
                    if($.trim($(conteudo).find("DescResposta").text().toString()) ==$.trim(selecionado)){
                        $(combotemp).append("<option selected>"+$(conteudo).find("DescResposta").text().toString()+"</option>");
                    }else{
                        $(combotemp).append("<option>"+$(conteudo).find("DescResposta").text().toString()+"</option>");
                    }
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
    $.ajaxSetup({
        async: false
    });
    $.post("CadRespostaServlet", {
        cd_resposta: cd_resposta,
        ds_resposta: ds_resposta

    }, function(xml){
        var confirma = $("sucesso",xml).text();

        if (confirma == "sim"){
            alert("Resposta cadastrada com sucesso!");
        }else{
            alert("Resposta nao cadastrada devido a um erro!\nTente novamente mais tarde.");
        }
    });
}