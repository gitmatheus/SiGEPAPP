function show_CadastraAtributo(){
    $(document).scrollTop(0);
    $("#divfrmCadAtributo").dialog('open');
}



function show_CadastraTipo(){
    $(document).scrollTop(0);
    $("#divfrmCadTipo").dialog('open');
}

function getTipos(){
    $("#frmCadAtributoSelTipo option").remove();
    $.post('GetTiposServlet',null,function(xml){
        $(xml).find("tipo").each(function(indice, item){
            $("#frmCadAtributoSelTipo").append("<option value='"+
                $(item).find("cod").text()+"'>"+
                $(item).find("nome").text()+
                "</option>");
        });
        $("#frmCadAtributoSelTipo").append(
            "<option value='-1' style='background:#eeeeee'>"+
            "Cadastrar novo tipo..."+
            "</option>");
    });
}
function informa(Texto, Titulo){
    $("#alertPadrao").dialog('option','title',Titulo);
    $("#alertPadrao").html("<table width='100%'><tr><td><img src='images/m2bralerta.png' style='vertical-align:middle;'/></td><td>" + Texto+"</td>");
    $(document).scrollTop(0);
    $("#alertPadrao").dialog("open");
}

function funcIncluiAtributoDisponivel(Nome, Descricao, ID){
    $("#frmCadEstrutCmbSelAtributo:selected").removeAttr("selected");
    $("#frmCadEstrutCmbSelAtributo").append("<option selected value='"+ID+"' title='"+Descricao+"'>"+Nome+"</option>");
    $("#frmCadEstrutCmbSelAtributo").dblclick();
}

//Funções de Validações

//Valida campo Nome da estrutura
function validaNome(){
    var msg=null;
    if($.trim($("#frmCadEstrutNome").val())!=""){
        $.post("ExisteEstruturaServlet", {
            nome: $("#frmCadEstrutNome").val()
        }, function(dados){
            if($.trim($(dados).find("existente").text())=="sim"){
                msg="Nome de estrutura já existe";
            }
        }, "xml");
    }else{
        msg="Preencha o nome da estrutura";
    }

    return msg;
}
$(document).ready(function(){
    $.ajaxSetup({
        async: false
    });
    $("#alertInsAtrib").dialog({
        autoOpen: false
    });

    $("#alertPadrao").dialog({
        autoOpen: false,
        modal: false,
        buttons: {
            Ok: function(){
                $(this).dialog("close");
            }
        }
    });

    $("#linkAbreCadastroAtributo").click(function(){
        show_CadastraAtributo();
    });
    //Evento de clique para abrir a janela de cadastro de tipos
    $("#frmCadAtributoSelTipo").change(function(){
        if($("#frmCadAtributoSelTipo option:selected").attr("value")=="-1"){
            show_CadastraTipo();
        }
    });
    $("#divfrmCadAtributo").dialog({
        width: 520,
        modal: true,
        autoOpen: false,
        buttons: {
            Cancelar: function() {
                $(this).dialog('close');
            },
            Cadastrar: function() {
                var relacionavel;
                if($("#frmCadAtributoChkRel").is(":checked")){
                    relacionavel="S";
                }else{
                    relacionavel="N";
                }

                if($("#frmCadAtributoTxtNome").val()==""){
                    informa("Nome do atributo n&atilde;o preenchido", "Erro");
                    $("#frmCadAtributoTxtNome").focus();
                }else if($("#frmCadAtributoTxtDesc").val()==""){
                    informa("Descrição não preenchida", "Erro");
                    $("#frmCadAtributoTxtDesc").focus();
                }else if($("#frmCadAtributoSelTipo").val()=="" || $("#frmCadAtributoSelTipo").val()=="-1"){
                    informa("Tipo de atributo não selecionado", "Erro");
                }else{
                    $.post("ExisteAtributoServlet", {
                        nome: $.trim($("#frmCadAtributoTxtNome").val())
                    }, function(dados){
                        //Caso o atributo exista....
                        if($.trim($(dados).find("existente").text())=="sim"){
                            informa("Nome do atributo j&aacute; existe", "Erro");
                        }
                        //Caso não exista...Cadastra
                        else{
                            var nome=$("#frmCadAtributoTxtNome").val();
                            var desc=$("#frmCadAtributoTxtDesc").val();
                            var cod_atrib;

                            $.post("CadAtributoServlet",{
                                nome:   $("#frmCadAtributoTxtNome").val(),
                                descricao: $("#frmCadAtributoTxtDesc").val(),
                                codTipo: $("#frmCadAtributoSelTipo").val(),
                                relac: relacionavel
                            } , function(dados, msgstatus){
                                if(msgstatus=="success"){
                                    cod_atrib=$(dados).find("codAtrib").text();
                                    funcIncluiAtributoDisponivel(nome, desc, cod_atrib);
                                    $("#divfrmCadAtributo").dialog("close");
                                    informa("Atributo cadastrado com sucesso", "Cadastro de atributo");
                                }
                            });
                        }
                    }, "xml");
                }
            }
        },
        close: function(){
            $("#frmCadAtributoTxtNome").val("");
            $("#frmCadAtributoTxtDesc").val("");
            $("#frmCadAtributoSelTipo:selected").removeAttr("selected");
            $("#frmCadAtributoSelTipo:first").attr("selected","selected");
            $("frmCadAtributoSelTipo").removeAttr("checked");
        },
        open: function(){
            getTipos();
        }
    });

    $("#divfrmCadTipo").dialog({
        width: 520,
        modal: false,
        autoOpen: false,
        buttons: {
            Cancelar: function() {
                $("#divfrmCadTipo").dialog('close');
            },
            Cadastrar: function() {
                if($("#frmCadTipoTxtNome").val()==""){
                    informa("Nome do tipo n&atilde;o preenchido", "Erro");
                }else if($("#frmCadTipoTxtExpReg").val()==""){
                    informa("Express&atilde;o n&atilde;o preenchido", "Erro");
                }else if($("#frmCadTipoTxtExpReg").hasClass("erro")){
                    informa("A express&atilde;o regular cont&eacute;m erros","Erro");
                }else{
                    $.post("ExisteTipoServlet",{
                        nome: $("#frmCadTipoTxtNome").val()
                    },function(dados){
                        if($.trim($(dados).find("existente").text())=="sim"){
                            informa("Nome do tipo j&aacute; existe", "Erro");
                        }else{
                            $.post("CadTipoServlet",{
                                nome:   $("#frmCadTipoTxtNome").val(),
                                expreg: $("#frmCadTipoTxtExpReg").val()
                            } , function(dados, msgstatus){
                                if(msgstatus=="success"){
                                    getTipos();
                                    informa(dados, "Cadastro");
                                    $("#divfrmCadTipo").dialog('close');
                                }
                            });
                        
                        }
                    },"xml");
                }
            }
        },
        close: function(){
            $("#frmCadTipoTxtNome").val("");
            $("#frmCadTipoTxtExpReg").val("");
        }

    });
    $("#frmCadTipoTxtExpReg").keyup(function(){
        //$("#frmCadTipoTxtTesteExpReg").filter(function(){
        $("#frmCadTipoTxtExpReg").removeClass("erro");

        $("#frmCadTipoTxtTesteExpReg").keyup(function(){
            try{
                var txtRG=new RegExp($("#frmCadTipoTxtExpReg").val());
                var txtTest=$("#frmCadTipoTxtTesteExpReg").val();

                if(!txtTest.match(txtRG)){
                    $("#frmCadTipoTxtTesteExpReg").addClass("erro");
                }else{
                    $("#frmCadTipoTxtTesteExpReg").removeClass("erro");
                }
            }catch(e){
                $("#frmCadTipoTxtExpReg").addClass("erro");
            }
        });

        $("#frmCadTipoTxtTesteExpReg").keyup();

    });

});