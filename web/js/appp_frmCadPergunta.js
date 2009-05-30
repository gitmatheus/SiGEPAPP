$(document).ready(function(){

    $("#alertPadrao").dialog({
        width: 300,
        modal: true,
        autoOpen: false,
        buttons: {
            Ok: function(){
                $(this).dialog('close');
            }
        }
        });

    carregaListaPerguntas();

    $("#frmCadQuestionarioEnviaPerg").click(function(){
        EnviaCadPergunta();
        LimpaDescPergunta();
        carregaListaPerguntas();
    });
});

function informa(Texto, Titulo){
    $("#alertPadrao").dialog('option','title',Titulo);
    $("#alertPadrao").html("<table width='100%'><tr><td><img src='images/m2bralerta.png' style='vertical-align:middle;'/></td><td>" + Texto+"</td>");
    $(document).scrollTop(0);
    $("#alertPadrao").dialog("open");
}

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
            informa("Pergunta cadastrada com sucesso!", "Cadastro de perguntas");
        }else{
            informa("Pergunta nao cadastrada devido a um erro!\nTente novamente mais tarde.", "Cadastro de perguntas");
        }
    });
}