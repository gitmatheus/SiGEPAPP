/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_MAIORSUB     : Function retorna a maior substring em comum entre uma palavra e um vetor
*                      : e o maior tamanho da palavra que tem essa maior substring em comum.
* Author               : WeeDo
* History              : 29/03/2009 - Guilherme Wachs Lopes
*                      : 02/04/2009 - Guilherme Wachs Lopes - Melhoria no algoritmo
***************************************************************************************************/
CREATE OR REPLACE
FUNCTION APPP_FN_MAIORSUB
( Vetor IN APPP_PKG_VETORES.CHAR_VECTOR
, Palavra IN VARCHAR2
, maxSimilar_Caracter OUT NUMBER
)
RETURN NUMBER AS

maxSimilar_Comum number:=0;

MaiorRelacao number:=0;
fl_continua boolean:=true;
indice_sub number;
maior_palavra number;
j number:=1;
BEGIN

maxSimilar_Caracter:=length(palavra);

  IF (length(palavra)>0) THEN
    FOR i IN REVERSE 1..length(palavra) LOOP

        FOR j IN 1..Vetor.Count LOOP

          indice_sub:=Least(i,length(Vetor(j)));

          IF Substr(Vetor(j),1, indice_sub)= substr(palavra, 1, indice_sub) THEN
              maior_palavra:=greatest(Length(Vetor(j)),Length(palavra));
              IF (i/maior_palavra) > maiorrelacao THEN
                  maxSimilar_Caracter:=maior_palavra;
                  MaiorRelacao:=i/maxSimilar_Caracter;
                  maxSimilar_comum:=i;

                  IF MaiorRelacao=1 THEN
                    fl_continua:=false;
                  END IF;

              END IF;
          END IF;

        EXIT WHEN fl_continua=false;
        END LOOP;
    END LOOP;

  END IF;

  RETURN maxSimilar_Comum;

END APPP_FN_MAIORSUB;
