<%        /**
         * @{#}cadastraEstrutura.jsp 0.01 09/02/21
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
         * |  Guilherme  |  09/02/21   | Criacao do Arquivo                   |
         * |------------------------------------------------------------------|
         **/
%>
<%@page import="br.edu.fei.sigepapp.bancodedados.dao.*, br.edu.fei.sigepapp.bancodedados.model.*, java.util.List" %>
<%@include file="cabecalho.jsp" %>

<form>
    <table border="0" cellpadding="0" cellspacing="0" width="100%" align="right">
        <tr>
            <td class="titulo"><div style="margin-left: 10px; text-align:left"> <font class="titulo">.: 1: Tipo de Estrutura</font> </div></td>
        </tr>
        <tr>
            <td align="center" valign="top" style="border-right: 1px dotted #3d414c;"><p>Escolher Tipo:</p>
                <p>
                    <select name="cb_tipo_estrutura" class="edit" id="cb_tipo_estrutura">
                        <option value="pattern">Pattern</option>
                        <option value="antipattern">Anti-Pattern</option>
                        <option value="persona">Persona</option>
                    </select>
            </p></td>
        </tr>
        <tr>
            <td class="titulo" style="border-right: 1px dotted #3d414c;"><div style="margin-left: 10px; text-align:left"> <font class="titulo">.: 2: Defini&ccedil;&atilde;o da Estrutura</font>: </div></td>
        </tr>
        <tr>
            <td style="border-right: 1px dotted #3d414c;"><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>Nome:</td>
                        <td><input type="textfield" size="50"/></td>
                    </tr>
                    <tr><td height="15"></td></tr>
                    <tr>
                        <td>Descrição:</td>
                        <td><textarea name="textarea" id="textarea" cols="50" rows="5"></textarea></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                    </tr>

                    
            </table>                  <p>&nbsp;</p></td>
        </tr>
        <tr>
            <td class="titulo" style="border-right: 1px dotted #3d414c;"><div style="margin-left: 10px; text-align:left"> <font class="titulo">.: 3: Atributos Complementares</font></div></td>
        </tr>
        <tr>
            <td style="border-right: 1px dotted #3d414c;"><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="13%" align="right">&nbsp;</td>
                <td width="60%">NOME</td>
                <td width="27%">&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>CONTEXTO</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>PROBLEMA</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>SOLUÇÃO</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </table></td>
        </tr>
    </table>
</form>
<%@include file="rodape.jsp" %>