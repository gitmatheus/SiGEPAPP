/**
 * @{#}appp_funcoes.js 0.01 09/01/18
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * 
 * Este código apresenta as funções dos scripts encontradas no sistema SiGePAPP
 * e parte integrante do projeto de formatura, do curso de ciências da computação,
 * do Centro Universitário da FEI, sob orientação do Prof. Dr. Plinio T. Aquino Jr.
 *
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * |  Andrey     |  09/01/18   | Criação do Arquivo                   |
 * |------------------------------------------------------------------|
 * | Guilherme   |  09/02/21   | Alteracao da funcao de carregamento: |
 * |             |             |trocado $("menubv li") p/ $(menubv td)|
 * |------------------------------------------------------------------|
 *
 */

/** As funções contidas dentro do método ready, são poderam ser executadas após o carregamento da página */
$(document).ready(function(){
    /** Função que da o efeito de fadein e fadeout no elemento li do menubv e também da classe botao */
    $(".menubv td, .botao").hover(function () {
        $(this).fadeTo("slow", 0.4) // Quando o mouse for posicionado sobre o elemento
        },function () {
        $(this).fadeTo("slow", 1); // Após a retirada do mouse de cima do elemento
    });
});

/** A função Data retorna por extenso a data, e.g.: Segunda-Feira, 19 de janeiro de 2009 */
function Data(){
    function SetNameArray(item) {
        this.length = item
        return this
    }
    Month = new SetNameArray(12)
    Month[1] = "janeiro"
    Month[2] = "fevereiro"
    Month[3] = "mar&ccedil;o"
    Month[4] = "abril"
    Month[5] = "maio"
    Month[6] = "junho"
    Month[7] = "julho"
    Month[8] = "agosto"
    Month[9] = "setembro"
    Month[10] = "outubro"
    Month[11] = "novembro"
    Month[12] = "dezembro"

    WeekDay = new SetNameArray(7)
    WeekDay[1] = "Domingo"
    WeekDay[2] = "Segunda-feira"
    WeekDay[3] = "Ter&ccedil;a-feira"
    WeekDay[4] = "Quarta-feira"
    WeekDay[5] = "Quinta-feira"
    WeekDay[6] = "Sexta-feira"
    WeekDay[7] = "S&aacute;bado"

    theDate = new Date()
    var theWeekDay = WeekDay[theDate.getDay() + 1]
    var theMonth = Month[theDate.getMonth() + 1]
    var theYear = theDate.getYear() + 1900
    if (theYear>3000)
        theYear=theYear-1900;
    document.write(theWeekDay);
    document.write(",&nbsp;");
    document.write(theDate.getDate() + " de " + theMonth)
    document.write(" de " +theYear);
}