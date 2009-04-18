<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <script type="text/javascript" src="js/jquery-1.3.2.js" ></script>
        <script type="text/javascript">
            function computePrefixFunction (pattern) {
                func=new Array(pattern.length);

                m    = pattern.length;

                func[0] = 0;

                k = 0;

                for (q = 1;  q < m;  q++) {

                    //while (k > 0 &&  ! charEquals (pattern[k], pattern[q])) {
                    while (k > 0  &&  pattern[k] != pattern[q]) {
                        k = func[k];
                    }


                    //if (charEquals (pattern[k], pattern[q])) {
                    if (pattern[k] == pattern[q]) {
                        k ++;
                    }

                    func[q] = k;
                }

                return func;
            }


            function   similaridade(text,padrao)
            {

                pattern = padrao;
                prefixFunc = new Array();
                prefixFunc = computePrefixFunction(padrao);
                n = text.length;
                m = padrao.length;
                q = 0;
                shift = -1;

                for (i = 0;  i < n;  i++) {

                    while (q > 0  &&  pattern[q]!=text[i]) {
                        // while (q > 0  &&  pattern[q] != text[i]) {

                        q = prefixFunc[q];
                    }

                    //if (charEquals (pattern[q], text[i]))
                    if (pattern[q] == text[i])
                        q ++;

                    if (q == m) {
                        shift = i - m + 1;
                        break;
                    }
                }

                return shift;
            }



            $(document).ready(function(){
                alert(similaridade("guilherme alberto wachs","wachs"));
            });

        </script>
        <h1>Página teste para algoritmo de similaridade</h1>
        <table width="100%">
            <tr>
                <td>
                    <textarea rows="20" style="width:100%" id="texto1">É preciso ter muito claro para todos na empresa que não existe
                    </textarea>
                </td>
                <td>

                    <textarea rows="20" style="width:100%" id="texto2">Portanto precisamos desenvolver um critério(ou conjunto de critérios)
                        que permita avaliar os candidatos à solução de maneira a medir,
                        com precisão esse grau de atendimento ao negócio da empresa de modo
                        a escolher aquele sistema que reuna as qualificações para garantir o
                        sucesso de nosso projeto.
                    </textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">A similaridade é:<br><input type="text" id="resultado" size="5"></td>
                <div style=""></div>
            </tr>
            <tr>
                <td colspan="2" align="center">Foi executado em (ms):<br><input type="text" id="tempo" size="5"></td>
            </tr>
            <tr>
                <td colspan="2" align="center">Valores usados para teste<br><input type="text" id="resultado1" size="5"></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="text" id="resultado2" size="5"></td>
            </tr>


        </table>
        <div>

        </div>
        <table>

        </table>

    </body>
</html>
