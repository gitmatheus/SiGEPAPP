$(document).ready(function(){

    $("#envia_cad_pergunta").click(function(){
        EnviaCadUsuario();
        LimpaDescPergunta();
    });
    
});

function LimpaDescPergunta(){
       $("#frmCadPergRespDescPerg").val('');
}

function EnviaCadUsuario(){
    var cd_pergunta = 1;
    var ds_pergunta = $("#frmCadPergRespDescPerg").val();

    $.post("CadPerguntaServlet", {
        cd_pergunta: cd_pergunta,
        ds_pergunta: ds_pergunta

    }, function(xml){
        var confirma = $("sucesso",xml).text();
        
        /*
        if(confirma == "nao" && ds_pergunta!=''){
            alert("Digite sua pergunta no campo !");
        }else
        */

        if (confirma == "nao"){ //Esse NÃO é para ser SIM porque ??? Tom Mix 01/04/2008
            alert("Pergunta cadastrada com sucesso!");
        }else{
            alert("Pergunta nao cadastrada devido a um erro!\nTente novamente mais tarde.");
        }
    });
}

var arrayEscondidos = new Array();
var arrayVisiveis = new Array();

function mostra(id){
        if(id==null){
            $(arrayEscondidos).each(function(index,obj){
                mostra($(obj).attr("value"));
            });

        }else{

            //Pesquisa no array de objetos onde esta o id para incluir no combo box frmCadEstrutCmbSelAtributo
            $(arrayEscondidos).each(function(index,obj){
                //Se o atributo tiver o id procurado...
                if($(obj).attr("value") == id){
                    //...Adiciona ele como option no combo box.
                    $(obj).removeAttr("selected");
                    $("#frmCadEstrutCmbSelPergunta").append(obj);

                    //Elimina o objeto da arrayDeObjetos escondidos
                    arrayEscondidos.splice(index, 1);
                    arrayVisiveis.push(obj);
                }
            });
            //Atualiza os options visiveis
            //arrayVisiveis=$.makeArray($("#frmCadEstrutCmbSelAtributo option"));

        }
}

function func_removeAtributo(cod_atrib){
        $("#atributo_"+cod_atrib).remove();
        mostra(cod_atrib);
        ordenarCombo();
}

function esconde(id){
        //Adiciona no array o objeto.
        //dica retirada de: http://jquery-howto.blogspot.com/2009/02/how-to-get-full-html-string-including.html
        arrayEscondidos.push($("#frmCadEstrutCmbSelPergunta option[value="+id+"]").get(0));

        $(arrayVisiveis).each(function(index, item){
            if($(item).attr("value")==id){
                arrayVisiveis.splice(index, 1);
            }
        });
        //remove do codigo HTML o objeto. (Esconde)
        $("#frmCadEstrutCmbSelAtributo option[value="+id+"]").remove();
        //Atualiza os options visiveis
}

function listaPergunta(){
            if($('#frmCadEstrutCmbSelPergunta option:selected').length>0){
                //Armazena na variavel selecao o objeto selecionado no combo box do formulario.
                var selecao=$("#frmCadEstrutCmbSelPergunta option:selected");
                //Adiciona uma linha na tabela da estrutura do atributo com um campo hidden de input para passagem
                //de header da página
                $("#tabAtributos").append("\<tr id=\"atributo_"+selecao.val()+"\">"+
                    "<td width=\"80%\" class=\"atributoAdicional\" align=\"center\">"+
                    "<input type=\"hidden\" name=\"atributos_ids\" value=\""+
                    selecao.val()+"\">"+
                    selecao.text()+
                    "</td>"+
                    "<td width=\"20%\" align=\"center\">"+
                    "<a href=\"javascript:func_removeAtributo(\'"+selecao.val()+"\')\">"+
                    "["+
                    "<img src=\"images/222222_11x11_icon_minus.gif\" border=\"none\" >&nbsp;"+
                    "] Remover"+
                    "</a>"+
                    "</td></tr>");
                //esconde o objeto <option> selecionado acima do combo box frmCadEstrutCmbSelPergunta.
                esconde($(selecao).attr("value"));
            }
            $("#tabAtributos").sortable({items: 'tr:has(td.atributoAdicional)',cursor: "move"});
            $("#tabAtributos tr:has(td.atributoAdicional)").css("cursor", "pointer");
}
    

