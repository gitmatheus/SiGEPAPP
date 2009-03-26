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
            function similaridade(){
                Texto1=$("#texto1").text().split(" ");
                Texto2=$("#texto2").text().split(" ");
                var letrasDePalavrasIguais=0;

                $(Texto1).each(function(palavra, indice){
                    $(Texto2).each(function(palavra2, indice2){
                        if($(palavra).text().toLowerCase()==$(palavra2).text().toLowerCase()){
                            letrasDePalavrasIguais+=$(palavra2).text().length;
                        }
                    });
                });
                return letrasDePalavrasIguais;
            }

            $(document).ready(function(){
                // alert(similaridade());

                Texto1=$("#texto1").text().split(" ");
                Texto2=$("#texto2").text().split(" ");

                var letrasDePalavrasIguais=0;

                alert(Texto1);
                $(Texto1).each(function(indice, palavra){
                    $(Texto2).each(function(indice2, palavra2){
                        if($(palavra).text().toLowerCase()==$(palavra2).text().toLowerCase()){
                            letrasDePalavrasIguais+=$(palavra2).text().toString().length;
                        }
                    });

                });


                alert(letrasDePalavrasIguais);
            });



        </script>
        <h1>Página teste para algoritmo de similaridade</h1>
        <table width="100%">
            <tr>
                <td>
                    <textarea rows="20" style="width:100%" id="texto1">Texto 1. Este texto serve para comparar com o texto 2
                a idéia é desconsiderar a caixa do texto.A fórmula é baseada  na relação de palavras
                iguas por todas as palavras comparadas.
                    </textarea>
                </td>
                <td>
                    <textarea rows="20" style="width:100%" id="texto2">Texto 2. Este texto serve para comparar com o texto 1
                a idéia é desconsiderar a caixa do texto.A fórmula é baseada  na relação de palavras
                    iguas por todas as palavras comparadas.</textarea>
                </td>
            </tr>

        </table>



    </body>
</html>
