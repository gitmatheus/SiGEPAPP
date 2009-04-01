function EnviaCadUsuario(){
    var codPerg = 1;
    var descPerg = $("#frmCadPergRespNomePerg").val();
    
    $.post("CadUsuarioServlet", {
        codPerg: codPerg,
        descPerg: descPerg

    }, function(xml){
        var confirma = $("sucesso",xml).text();
        if (confirma == "sim"){
            alert("Pergunta cadastrada com sucesso!");
        }else{
            alert("Pergunta nao cadastrada devido a um erro!\nTente novamente mais tarde.");
        }
    });

}