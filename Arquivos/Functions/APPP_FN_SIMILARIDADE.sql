/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_SIMILARIDADE : Function retorna um número de 0 à 1 de acordo com a similaridade de 2 textos
* Author               : WeeDo 
* History              : 29/03/2009 - Guilherme Wachs Lopes - Versao Inicial
*                      : 30/03/2009 - Matheus Goncalves - Verificacao de acentos e case sensitive
***************************************************************************************************/

create or replace FUNCTION APPP_FN_SIMILARIDADE( Texto1 IN VARCHAR2
                                               , Texto2 IN VARCHAR2
                                               ) RETURN NUMBER IS

    comumChars NUMBER(10):=0;
    totalChars NUMBER(10):=0;
    Vetor1 APPP_PKG_VETORES.CHAR_VECTOR := appp_fn_split(appp_fn_remove_acento_pont(UPPER(texto1)),' ');
    Vetor2 APPP_PKG_VETORES.CHAR_VECTOR := appp_fn_split(appp_fn_remove_acento_pont(UPPER(texto2)),' ');
    VetorTemp APPP_PKG_VETORES.CHAR_VECTOR;
    saida NUMBER;

BEGIN

    if(Vetor1.count<Vetor2.count) then
      VetorTemp:=Vetor1;
      Vetor1:=Vetor2;
      Vetor2:= VetorTemp;
    end if;

    for i in 1 .. vetor1.Count loop
        comumChars:=comumChars+appp_fn_maiorsub(Vetor2,vetor1(i),saida);
        totalChars:=totalChars+ saida;
        dbms_output.put_line(comumchars);
        dbms_output.put_line(totalChars);
    end loop;


  RETURN (comumchars/totalchars);




END APPP_FN_SIMILARIDADE;

/