$(document).ready(function(){
    
    $("#frmCadAPPPEstruturaPA").change(function(){
        if($("#frmCadAPPPEstruturaPA").val() != ""){
            getCidade($("#frmCadAPPPEstruturaPA").val());
        }
    });

});


function getCidade(pCdEstrutura){
    var cdestado = pCdEstrutura;
    $("#cadcidade").html(
        "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'></select>" +
        "&nbsp;&nbsp;<img src='images/aguardep.gif'/>&nbsp;<font size='x-small'>por favor, aguarde...</font>"
        );
    $.get("GetCidadeServlet", {
        cdestado: cdestado
    }, function(xml){
        var qtdecidades = parseInt($("nro_cidades",xml).text());
        var strComboCidade = "";
        if(qtdecidades > 0){
            strComboCidade += "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'>";
            for(i = 0; i < qtdecidades;i++){
                cdcid = "cd_cidade" + i;
                nmcid = "nm_cidade" + i;
                strComboCidade += "<option value='" + $(cdcid,xml).text() + "'>" + $(nmcid,xml).text() +"</option>";
            }
            strComboCidade +="</select>";
        }else{
            $("#alertaCadCidade").dialog('open');
            strComboCidade = "<select id='frmCadUserCidade' name='frmCadUserCidade' class='edit' style='width: auto;'></select>";
        }
        $("#cadcidade").html(strComboCidade);
    });
}