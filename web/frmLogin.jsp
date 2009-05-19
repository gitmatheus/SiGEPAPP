<% if (request.getSession().getAttribute("codigo_usuario") == null || request.getSession().getAttribute("codigo_usuario") == "0") {%>
<fieldset style="background:#FFFFFF;">
    <legend style="font-weight:bold">
        Efetuar login:
    </legend>
    <br />
    <table align="right">
        <tr>
            <td align="right">
                Login:
            </td>
            <td>
                <input id="usuario" type="text" name="usuario" class="edit" width="150px" title="Digite seu usu&aacute;rio" />
            </td>
        </tr>
        <tr>
            <td align="right">
                Senha:
            </td>
            <td>
                <input id="senha" type="password" name="senha" class="edit" width="150px" title="Digite sua senha" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <table align="center">
                    <tr>
                        <td align="right">
                            <input id="enviar_login" type="button" class="botao" title="Confirmar login" value="&nbsp;OK&nbsp;" />
                        </td>
                        <td align="center">
                            <input id="limpar" type="button" class="botao" title="Limpar dados" value="&nbsp;Limpar&nbsp;"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="right" colspan="2">
                <div style="margin-right: 5px;">
                    Você não possui registro? <br /> <a href="/sigepapp/frmCadUsuario.jsp" style="color: #CC0000;"> Clique aqui</a> para registrar-se.
                </div>
            </td>
        </tr>
    </table>
</fieldset>
<table align="right">

</table>
<%} else {%>
<h2>Seja bemvindo,<br /> <% out.print(request.getSession().getAttribute("usuario"));%></h2>
<div align='right' style='margin-right: 10px;'>
    <!-- |<a id='envia_avaliacoes' href='frmAvaliacoesPendentes.jsp' class='painelcontrole' title='Avaliar APPP pendentes'>Avalia&ccedil;&otilde;es</a>&nbsp;-->|
    <a id='envia_logoff' href='#' class='painelcontrole' title='Sair do sistema' onclick='javascript:LogoffSigepapp();' >Sair</a>
</div> 
<input type='hidden' id='status' value='logoff' />
<%}%> 