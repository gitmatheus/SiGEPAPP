
function EnviaCadUsuario(){
    var cd_Estrutura = new String ($("frmCadAPPPEstruturaPA").val());
    var cd_User_criador = new String ($("system.cd_user"));
    var ds_Pat_problema = $("frmCadAPPPProblemaPA").val();
    var ds_Pat_solucao  = $("frmCadAPPPSolucaoPA").val()  
    var nm_Objeto       = $("frmCadAPPPNomePA").val();
    var ds_Objeto       = $("frmCadAPPPDescricaoPA").val();  
    
    $.post("CadPatternServlet", {
        cd_Estrutura: cd_Estrutura,
        cd_User_criador: cd_User_criador,
        ds_Pat_problema: ds_Pat_problema,
        ds_Pat_solucao: ds_Pat_solucao,
        nm_Objeto: nm_Objeto,
        ds_Objeto: ds_Objeto
        
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
        height: 100,
        buttons:{
            "Ok": function(){
                $(this).dialog("close");
            }
        }
    });

    $("#envia_cad_user").click(function(){
        EnviaCadUsuario();
    });

    $("#cancela_cad_user").click(function(){
        window.location = '/sigepapp';
    });
});