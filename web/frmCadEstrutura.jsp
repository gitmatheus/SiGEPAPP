<%@include file="cabecalho.jsp"%>

<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
    <tr>
        <td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro&nbsp;de&nbsp;Estruturas APPP ::..</font> </td>
    </tr>
    <tr>
        <td align="center">
            <br />
            <fieldset style="width: 500 px">
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
            <fieldset style="width: 500 px">
                <legend><b>Escolha dos atributos:</b></legend>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
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
                        <td colspan="2"><a href="#" onclick="javascript:alert('Abre Janela de Atributos')">+Adicionar Atributo...</a></td>
                    </tr>
                </table>
            </fieldset>

        </td>
    </tr>

</table>
<div style="position: absolute; top: 20%; left: 20%">
    Testetsetsetse
</div>
<%@include file="rodape.jsp"%>