<%@include file="cabecalho.jsp"%>
<script type="text/javascript" language="javascript">
$(document).ready(function(){
	$("#frmCadUserLogin").blur(function(){
			if($("#frmCadUserLogin").val() != ""){
				verificaExisteLogin();
			}
	});
});
</script>
<form name="frmCadUser" method="post">
<table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
<tr>
	<td align="center" class="titulo" style="height: 25px; vertical-align: middle;"> <font class="titulo">..:: Cadastro de Usu&aacute;rio ::..</font> </td>
</tr>
<tr>
	<td align="center">
	<br />
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="30%" align="right">
				<div style="margin-right: 10px;">
					<font class="texto"> Login: </font>
				</div>
			</td>
			<td width="70%" align="left" valign="middle">
				<div id="existelogin" style="margin-left: 5px;">
					<input id="frmCadUserLogin" type="text" name="frmCadUserLogin" class="edit" style="width: 100px;" maxlength="30" title="Digite o login desejado" />
				</div>
			</td>
		</tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr>
			<td width="30%" align="right">
				<div style="margin-right: 10px;">
					<font class="texto"> Senha: </font>
				</div>
			</td>
			<td width="70%" align="left">
				<div  style="margin-left: 5px;">
					<input id="frmCadUserSenha" type="text" name="frmCadUserSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite uma senha de acesso" />
				</div>
			</td>
		</tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr>
			<td width="30%" align="right">
				<div style="margin-right: 10px;">
					<font class="texto"> Confirmar senha: </font>
				</div>
			</td>
			<td width="70%" align="left">
				<div  style="margin-left: 5px;">
					<input id="frmCadUserCSenha" type="text" name="frmCadUserCSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite novamente a senha de acesso" />
				</div>
			</td>
		</tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr>
			<td width="30%" align="right">
				<div style="margin-right: 10px;">
					<font class="texto"> Nome: </font>
				</div>
			</td>
			<td width="70%" align="left">
				<div  style="margin-left: 5px;">
					<input id="frmCadUserNome" type="text" name="frmCadUserNome" class="edit" style="width: 250px;" maxlength="50" title="Digite seu nome" />
				</div>
			</td>
		</tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr>
			<td width="30%" align="right">
				<div style="margin-right: 10px;">
					<font class="texto"> Sobrenome: </font>
				</div>
			</td>
			<td width="70%" align="left">
				<div  style="margin-left: 5px;">
					<input id="frmCadUserSobrenome" type="text" name="frmCadUserSobrenome" class="edit" style="width: 250px;" maxlength="50" title="Digite seu sobrenome" />
				</div>
			</td>
		</tr>
		<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr>
			<td width="30%" align="right">
				<div style="margin-right: 10px;">
					<font class="texto"> Endere&ccedil;o: </font>
				</div>
			</td>
			<td width="70%" align="left">
				<div  style="margin-left: 5px;">
					<input id="frmCadUserEndereco" type="text" name="frmCadUserEndereco" class="edit" style="width: 300px;" maxlength="80" title="Digite seu endere&ccedil;o" />
					<font class="texto"> n.º: </font>
					<input id="frmCadUserNumEnd" type="text" name="frmCadUserNumEnd" class="edit" style="width: 40px;" maxlength="6" title="Digite o n&uacute;mero de sua resid&ecirc;ncia" />
				</div>
			</td>
		</tr>
	</table>
	</td>
</tr>
</table>
</form>
<%@include file="rodape.jsp"%>