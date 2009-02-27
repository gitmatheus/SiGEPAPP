<%        /**
         * @{#}cabecalho.jsp 0.01 09/01/18
         *
         * Copyright (c) 2009 Equipe SiGePAPP
         *
         * Este codigo apresenta os estilos de formatacao encontrados no sistema SiGePAPP
         * e parte integrante do projeto de formatura, do curso de ciencias da computacao,
         * do Centro Universitario da FEI, sob orientacao do Prof. Dr. Plinio T. Aquino Jr.
         *
         * |------------------------------------------------------------------|
         * |                   Modificacoes no Codigo                         |
         * |------------------------------------------------------------------|
         * |   Autor     |   Data      |   Descricao                          |
         * |------------------------------------------------------------------|
         * |  Tom e Gui  |  09/02/25   | Definicao do Cadastro                |
         * |------------------------------------------------------------------|
         * |  Guilherme  |  09/02/26   | Criacao do Arquivo e dos Fildsets    |
         * |------------------------------------------------------------------|
         * |  Tom Mix    |  09/02/27   |                                      |
         * |------------------------------------------------------------------|
         **/
%>
<%@include file="cabecalho.jsp"%>
<script type="text/javascript" language="javascript">
    $(document).ready(function(){
        $("#formEscolheAtributos").hide();

    });
</script>

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro&nbsp;de&nbsp;Estruturas APPP ::..</font> </td>
    </tr>
    <tr>
        <td align="center">
            <br>
            <fieldset style="width: 500px">
                <legend><b>Escolha da estrutura:</b></legend>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Nome da estrutura:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input class="edit" type="text" size="20"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Descri&ccedil;&atilde;o:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input class="edit" type="text" size="20"/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>

                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                Tipo de Estrutura:
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <select id="frmCadEstrTipo" name="frmCadEstrTipo" class="edit" width="150px" maxlength="30" title="Escolha o tipo de Estrutura">
                                    <option label="" >Pattern</option>
                                    <option label="" >Anti-Pattern</option>
                                    <option label="" >Persona</option>
                                    <option label="" style="background: #EEEEEE" onclick="alert('Aqui abre janela para procurar por estruturas existentes')" >Importar de Estrutura Existente...</option>
                                </select>
                            </div>
                        </td>

                    </tr>

                </table>
            </fieldset>

            <!-- Inicio da customizacao de atributos -->
            <fieldset style="width: 500px;">
                <legend><b>Escolha dos atributos:</b></legend>
                <table border="0" cellpadding="0" cellspacing="0" width="500">
                    <tr>
                        <td colspan="2" width="30%" align="center">
                            <div style="margin-right: 10px;">
                                Nome
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="2" width="30%" align="center">
                            <div style="margin-right: 10px;">
                                Contexto
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>

                    <tr>
                        <td colspan="2" width="30%" align="center">
                        <div style="margin-right: 10px;">
                            Problema
                        </div>


                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td></td>
                    </tr>

                    <tr>
                        <td colspan="2" width="30%" align="center">
                        <div style="margin-right: 10px;">
                            Solução
                        </div>


                    </tr>
                    <tr>
                        <td colspan="2"><a href="#" onclick="javascript: $('#formEscolheAtributos').show('normal').css('left', event.screenX).css('top', event.screenY-200);">+Adicionar Atributo...</a></td>
                    </tr>
                </table>
            </fieldset>

        </td>
    </tr>
</table>

<div id="formEscolheAtributos" style="position: absolute; left: 50%; top: 50%; background-color:silver; width: auto; height:auto;">
    <fieldset>
        <legend>Selecionar atributos:</legend>
        <table width="200">
            <tr><td align="center">Busca de Atributo:</td><td><input type="text" style="width: 145px"></input></td></tr>
            <tr><td>Atributo:</td><td>
                    <select size="8" style="width: 150px">
                        <option>At1</option>
                        <option>At2</option>
                        <option>At3</option>
                        <option>At4</option>
                    </select>
            </td></tr>
            <tr><td colspan="2" align="center">Ou crie um atributo novo:</td></tr>
            <tr><td>Nome:</td><td><input type="text"></input></td></tr>
            <tr><td>Descrição:</td><td><input type="text"></input></td></tr>
            <tr><td>Tipo:</td><td><select id="frmCadAtribTipo" name="frmCadAtribTipo" class="edit" width="100px" maxlength="50" title="Escolha o tipo de dados do atributo">
                                    <option label="" >data</option>
                                    <option label="" >numero</option>
                                    <option label="" >texto</option>
                                    <option label="" style="background: #EEEEEE" onclick="alert('Aqui abre janela para procurar por estruturas existentes')" >Novo atributo</option>
                                    </select><p align="right"><a onclick="alert('Adiciona o novo atributo e inclui')" href="#">Adicionar</a></p></td></tr>
            <tr><td colspan="2"><p align="right"><a onclick="$('#formEscolheAtributos').hide();" href="#">Fechar</a></p></td></tr>
        </table>
    </fieldset>
</div>
<%@include file="rodape.jsp"%>
