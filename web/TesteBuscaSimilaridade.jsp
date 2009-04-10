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
            function max(val1, val2){
                return val1>val2?val1:val2;
            }
            function min(val1, val2){
                return val1<val2?val1:val2;
            }
            function buscaMaiorSubstringNoVetor(Vetor, palavra){
                var maxSimilar_Comum=0;
                var maxSimilar_Caracter=palavra.toString().length;
                var MaiorRelacao=0;
                var fl_continua=true;

                if(palavra!=" " && palavra!="" && palavra!=null){
                    //$(document).find("div:last").append("<hr><h2><b>Palavra: "+palavra+"</b></h2>");
                    //Caracter por caracter
                    for(i=palavra.toString().length;i>=0 && fl_continua;i--){
                        //Varrendo o texto2 na busca por i caracteres
                        for(j=0;j<Vetor.length && fl_continua;j++){
                            indiceSub=min(i,Vetor[j].toString().length);
                            if(Vetor[j].toString().substr(0, indiceSub)==palavra.toString().substr(0, i)){
                                if((i/max(Vetor[j].toString().length,palavra.toString().length))>MaiorRelacao){
                                    maxSimilar_Caracter=max(Vetor[j].toString().length,palavra.toString().length);
                                    MaiorRelacao=i/maxSimilar_Caracter;
                                    if(MaiorRelacao==1){
                                        fl_continua=false;
                                    }
                                    maxSimilar_Comum=i;
                                    //$(document).find("div:last").append("<br>Comparando: <i>"+Vetor[j]+"</i>\tComuns="+(i)+"\tTotal:"+maxSimilar_Caracter+"Relação: <b>"+MaiorRelacao+"</b>");
                                }
                            }

                        }
                    }
                }
                //alert(maxSimilar_Caracter);
                return new Array(maxSimilar_Comum, maxSimilar_Caracter);

            }

            function similaridade(){
                var tempoComeco=new Date().getTime();

                var Texto1;
                var Texto2;
                $(document).find("div:last").empty();
                Texto1=$("#texto1").val().replace('\n', " ");
                Texto2=$("#texto2").val().replace('\n', " ");

                Texto1=$.trim(Texto1);
                Texto2=$.trim(Texto2);

                Texto1=Texto1.split(" ");
                Texto2=Texto2.split(" ");

                var Temp;
                if(Texto1.length<Texto2.length){
                    Temp=Texto1;
                    Texto1=Texto2;
                    Texto2=Temp;
                }

                var comunsChars=0;
                var maiorPalavra=0;
                $(Texto1).each(function(indice, palavra){
                    ArrayResultado=buscaMaiorSubstringNoVetor(Texto2, palavra);

                    comunsChars+=$(ArrayResultado).get(0);
                    maiorPalavra+=$(ArrayResultado).get(1);

                });

                $("#resultado1").val(comunsChars);
                $("#resultado2").val(maiorPalavra);
                $("#resultado1").val($("#texto1").val().toString().length);
                $("#resultado2").val($("#texto2").val().toString().length);
                $("#resultado").val(comunsChars/maiorPalavra);
                $("#tempo").val(new Date().getTime()-tempoComeco);

                $("table:last").append("<tr>");
                $("table tr:last").append("<td>");
                $("table td:last").append($("#texto1").val().toString().length);
                $("table tr:last").append("</td>");
                $("table tr:last").append("<td>");
                $("table td:last").append($("#texto2").val().toString().length);
                $("table tr:last").append("</td>");
                $("table tr:last").append("<td>");
                $("table td:last").append($("#tempo").val());
                $("table tr:last").append("</td>");
                $("table tr:last").append("</tr>");
                $("table:last").append("</table>");

            }

            $(document).ready(function(){
                similaridade();

                $("#texto1,#texto2").keyup(function(){
                    similaridade();
                });

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
