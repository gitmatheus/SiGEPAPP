$(document).ready(function(){

    carregaListaPerguntas();

    $("#frmCadQuestionarioEnviaPerg").click(function(){
        EnviaCadPergunta();
        LimpaDescPergunta();
        carregaListaPerguntas();
    });
});

function carregaListaPerguntas(){
    $("#FrmCadQuestionarioComboPerg").empty();
    $.ajaxSetup({
        async: false
    });
    $.post("GetPerguntaServlet", {},
        function(retorno, status){
            $(retorno).find("Pergunta").each(
                function(indice, conteudo){
                    //$(conteudo).find("Cod").text();
                    $("#FrmCadQuestionarioComboPerg").append("<option>"+$(conteudo).find("DescPergunta").text()+"</option>");
                });
        });
}

function LimpaDescPergunta(){
    $("#frmCadQuestionarioDescPerg").val('');
}

function EnviaCadPergunta(){
    var cd_pergunta = 1;
    var ds_pergunta = $("#frmCadQuestionarioDescPerg").val();
    $.ajaxSetup({
        async: false
    });
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