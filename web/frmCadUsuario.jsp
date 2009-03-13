<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*,br.edu.fei.sigepapp.bancodedados.model.*,java.util.*" %>
<%
        EstadoDAO dao = new EstadoDAO();
        Collection<Estado> estados;
        estados = dao.APPP_SEL_ESTADO(new Estado());
        dao.fechaConexao();
%>
<%@include file="cabecalho.jsp"%>
<link rel="stylesheet" type="text/css" href="css/ui.all.css"/>
<script type="text/javascript" src="js/jquery-ui-1.5.3.js" ></script>
<script type="text/javascript" src="js/jquery.maskedinput-1.2.1.js"></script>
<script type="text/javascript" language="javascript" src="js/i18n/ui.datepicker-pt-BR.js"></script>
<script type="text/javascript" language="javascript" src="js/appp_frmCadUsuario.js"></script>
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
                            <div id="cadsenha" style="margin-left: 5px;">
                                <input id="frmCadUserSenha" type="password" name="frmCadUserSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite uma senha de acesso" />
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
                            <div id="cadconfsenha" style="margin-left: 5px;">
                                <input id="frmCadUserCSenha" type="password" name="frmCadUserCSenha" class="edit" style="width: 100px;" maxlength="30" title="Digite novamente a senha de acesso" />
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr><td colspan="2">
                            <div id="cademail">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                                    <tr>
                                        <td width="30%" align="right">
                                            <div style="margin-right: 10px;">
                                                <font class="texto"> E-mail: </font>
                                            </div>
                                        </td>
                                        <td width="70%" align="left">
                                            <div style="margin-left: 5px;">
                                                <input id="frmCadUserEmail" type="text" name="frmCadUserEmail" class="edit" style="width: 260px;" maxlength="100" title="Digite seu email" />
                                                <font class="texto"> Tipo: </font>
                                                <select id="frmCadUserTipoEmail" name="frmCadUserTipoEmail" class="edit" style="width: auto;">
                                                    <option value="Pessoal">Pessoal</option>
                                                    <option value="Comercial">Comercial</option>
                                                </select>
                                                <!-- &nbsp;&nbsp;<a href="#"><img id="adicionaemail" src="images/222222_11x11_icon_plus.gif" title="Adicionar outro email" border="0"></a> -->
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                    </td></tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> CPF: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserCPF" type="text" name="frmCadUserCPF" class="edit" style="width: 100px;" maxlength="15" title="Digite aqui seu cpf" />
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
                    <tr style="height:25px;">
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto" style=" vertical-align: top;"> Data de Nascimento: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserDataNasc" type="text" name="frmCadUserDataNasc" class="edit" style="width: 70px; vertical-align: middle;" maxlength="10" title="Digite ou escolha sua data de nascimento" />&nbsp;&nbsp;
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr><td colspan="2">
                        <div id="cadendereco">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
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
                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                <tr>
                                    <td width="30%" align="right">
                                        <div style="margin-right: 10px;">
                                            <font class="texto"> Complemento: </font>
                                        </div>
                                    </td>
                                    <td width="70%" align="left">
                                        <div  style="margin-left: 5px;">
                                            <input id="frmCadUserEndComplemento" type="text" name="frmCadUserEndComplemento" class="edit" style="width: 150px;" maxlength="80" title="Digite o complemento de seu endere&ccedil;o" />
                                            <font class="texto"> Tipo: </font>
                                            <select id="frmCadUserTipoEnd" name="frmCadUserTipoEnd" class="edit" style="width: auto;">
                                                <option value="Residencial">Residencial</option>
                                                <option value="Comercial">Comercial</option>
                                            </select>
                                            <!-- &nbsp;&nbsp;<a id="lnkaddendereco" href="#"><img id="adicionaendereco" src="images/222222_11x11_icon_plus.gif" title="Adicionar outro endere&ccedil;o" border="0"></a> -->
                                        </div>
                                    </td>
                                </tr>
                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                <tr>
                                    <td width="30%" align="right">
                                        <div style="margin-right: 10px;">
                                            <font class="texto"> CEP: </font>
                                        </div>
                                    </td>
                                    <td width="70%" align="left">
                                        <div  style="margin-left: 5px;">
                                            <input id="frmCadUserCEP" name="frmCadUserCEP" class="edit" style="width: 60px;" title="Digite aqui o cep do endere&ccedil;o acima"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                <tr>
                                    <td width="30%" align="right">
                                        <div style="margin-right: 10px;">
                                            <font class="texto"> Bairro: </font>
                                        </div>
                                    </td>
                                    <td width="70%" align="left">
                                        <div  style="margin-left: 5px;">
                                            <input id="frmCadUserBairro" name="frmCadUserBairro" class="edit" style="width: 150px;" maxlength="50" title="Digite o nome de seu bairro"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                <tr>
                                    <td width="30%" align="right">
                                        <div style="margin-right: 10px;">
                                            <font class="texto"> Estado: </font>
                                        </div>
                                    </td>
                                    <td width="70%" align="left">
                                        <div  style="margin-left: 5px;">
                                            <select id="frmCadUserEstado" name="frmCadUserEstado" class="edit" style="width: auto;">
                                                <option value="">Selecione aqui o seu estado</option>
                                                <% for (Estado e : estados) {%>
                                                <option value="<%= e.getCd_estado()%>"><%= e.getSg_sigla()%>&nbsp;-&nbsp;<%= e.getNm_estado()%></option>
                                                <%}%>
                                            </select>
                                        </div>
                                    </td>
                                </tr>
                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                <tr>
                                    <td width="30%" align="right">
                                        <div style="margin-right: 10px;">
                                            <font class="texto"> Cidade: </font>
                                        </div>
                                    </td>
                                    <td width="70%" align="left">
                                        <div id="cadcidade"  style="margin-left: 5px;">
                                            <select id="frmCadUserCidade" name="frmCadUserCidade" class="edit" style="width: auto;"></select>
                                        </div>
                                        <div id="alertaCadCidade" title="Cidades não cadastradas">
                                            Desculpe, mas não foram encontradas cidades cadastradas para este estado!
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </tr>
                    <!-- <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Pais: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserPais" name="frmCadUserPais" class="edit" style="width: 150px;" maxlength="50" title="Digite seu pais de origem"/>
                            </div>
                        </td>
                    </tr> -->
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <div id="cadtelefone">
                        <tr>
                            <td width="30%" align="right">
                                <div style="margin-right: 10px;">
                                    <font class="texto"> Telefone: </font>
                                </div>
                            </td>
                            <td width="70%" align="left">
                                <div  style="margin-left: 5px;">
                                    <input id="frmCadUserTelefone" name="frmCadUserTelefone" class="edit" style="width: 90px;" maxlength="15" title="Digite o número de telefone de seu interesse"/>
                                    <font class="texto"> Tipo: </font>
                                    <select id="frmCadUserTipoTel" name="frmCadUserTipoTel" class="edit" style="width: auto;">
                                        <option value="Residencial">Residencial</option>
                                        <option value="Comercial">Comercial</option>
                                        <option value="Celular">Celular</option>
                                    </select>
                                    <!--&nbsp;&nbsp;<a href="#"><img id="adicionatelefone" src="images/222222_11x11_icon_plus.gif" title="Adicionar outro telefone" border="0"></a>-->
                                </div>
                            </td>
                        </tr>
                    </div>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> MSN: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserMsn" name="frmCadUserMsn" class="edit" style="width: 150px;" maxlength="50" title="Digite seu endere&ccedil;o de msn"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> Skype: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <input id="frmCadUserSkype" name="frmCadUserSkype" class="edit" style="width: 150px;" maxlength="50" title="Digite seu identificador do Skype"/>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td width="30%" align="right">
                            <div style="margin-right: 10px;">
                                <font class="texto"> &Aacute;rea de interesse: </font>
                            </div>
                        </td>
                        <td width="70%" align="left">
                            <div  style="margin-left: 5px;">
                                <textarea id="frmCadUserAreaInt" name="frmCadUserAreaInt" class="edit" cols="60" rows="5" title="Digite sua &aacute;rea de interesse" >Digite aqui sua &aacute;rea de interesse...</textarea>
                            </div>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" id="envia_cad_user" name="envia_cad_user" class="botao" value="Confirmar" title="Confirmar cadastro de usuário">
                            &nbsp;&nbsp;
                            <input type="button" id="cancela_cad_user" name="cancela_cad_user" class="botao" value="Cancelar" title="Cancelar cadastro de usuário">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<%@include file="rodape.jsp"%>