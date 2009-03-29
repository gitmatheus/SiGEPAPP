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

                var Maximo=0;
                var VetorNovo=Vetor;
                var maiorItem=0;
                var maiorPalavraDef=0;
                for(i=1;i<=palavra.toString().length && $(VetorNovo).length>0;i++){
                    maiorItem=0;
                    VetorNovo=$.grep(VetorNovo,function(item){
                        if(palavra.toString().substr(0, i).toLowerCase()==item.toString().substr(0, i).toLowerCase()){
                            maiorItem=max(maiorItem,item.toString().length);
                            return true;
                        }
                    });

                //    maiorPalavraDef=max(maiorItem.toString().length,palavra.toString().length);

                    if($(VetorNovo).length==0){
                        maiorPalavraDef=max(maiorItem.toString().length,palavra.toString().length);
                        i=i-1;
                    }

                }
                alert(maiorPalavraDef);
                return new Array(i-1, maiorPalavraDef);
            }

            function similaridade(){
                var Texto1;
                var Texto2;
                //if($("#texto1").val().length>=$("#texto2").val().length){
                Texto1=$("#texto1").val().split(" ");
                Texto2=$("#texto2").val().split(" ");
                // }else{
                //   Texto1=$("#texto2").val().split(" ");
                // Texto2=$("#texto1").val().split(" ");
                // }

                var totalChars=0;
                var comunsChars=0;
                var maiorPalavra=0;
                $(Texto1).each(function(indice, palavra, maiorPalavra){
                    ArrayResultado=buscaMaiorSubstringNoVetor(Texto2, palavra, maiorPalavra);
                    comunsChars+=$(ArrayResultado).get(0);
                    maiorPalavra+=$(ArrayResultado).get(1);
                    alert(comunsChars);
                    // alert(maiorPalavra);
                });
                //alert(comunsChars/maiorPalavra);

                //            alert(letrasDePalavrasIguais/total);
            }

            $(document).ready(function(){
                // alert(similaridade());

                $("#botao").click(function(){
                    similaridade();
                })

            });



        </script>
        <h1>Página teste para algoritmo de similaridade</h1>
        <table width="100%">
            <tr>
                <td>
                    <textarea rows="20" style="width:100%" id="texto1">Funciona</textarea>
                </td>
                <td>
                    <textarea rows="20" style="width:100%" id="texto2">Funcionando</textarea>
                </td>
            </tr>
            <input type="button" id="botao" value="Comparar">
        </table>



    </body>
</html>
