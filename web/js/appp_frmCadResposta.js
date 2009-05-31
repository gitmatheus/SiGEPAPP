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


    $("#frmCadQuestionarioEnviaResp").click(function(){
        EnviaCadResposta();
        LimpaDescRespostas();
        carregaListaRespostas();
    });
});

function informa(Texto, Titulo){
    $("#alertPadrao").dialog('option','title',Titulo);
    $("#alertPadrao").html("<table width='100%'><tr><td><img src='images/m2bralerta.png' style='vertical-align:middle;'/></td><td>" + Texto+"</td>");
    $(document).scrollTop(0);
    $("#alertPadrao").dialog("open");
}


function carregaListaRespostas(){
    
    $.ajaxSetup({
        async: false
    });
    $.post("GetRespostaServlet", {},
        function(retorno, estado){
            $("#frmCadResp select").each(function(indice2, combotemp){
                var selecionado= $(combotemp).find("option:selected").text();
                $(combotemp).empty();
                $(combotemp).append("<option value='0'> </option>");
                $(retorno).find("Resposta").each(function(indice, conteudo){
                    if($.trim($(conteudo).find("DescResposta").text().toString()) ==$.trim(selecionado)){
                        $(combotemp).append("<option value='"+$(conteudo).find("Cod").text().toString()+"' selected>"+$(conteudo).find("DescResposta").text().toString()+"</option>");
                    }else{
                        $(combotemp).append("<option value='"+$(conteudo).find("Cod").text().toString()+"'>"+$(conteudo).find("DescResposta").text().toString()+"</option>");
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
            informa("Resposta cadastrada com sucesso!","Cadastro de Respostas");
        }else{
            informa("Resposta nao cadastrada devido a um erro!\nTente novamente mais tarde.","Cadastro de Respostas");
        }
    });
}