/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_MAIORSUB     : Function retorna a maior substring em comum entre uma palavra e um vetor
		       : e o maior tamanho da palavra que tem essa maior substring em comum.
* Author               : WeeDo 
* History              : 29/03/2009 - Guilherme Wachs Lopes
***************************************************************************************************/
CREATE OR REPLACE
FUNCTION APPP_FN_MAIORSUB
( Vetor IN APPP_PKG_VETORES.CHAR_VECTOR
, Palavra IN VARCHAR2
, MaiorTamanho OUT NUMBER
)
RETURN NUMBER AS

VetorNovo APPP_PKG_VETORES.CHAR_VECTOR:= vetor;
maiorItem number(10):=1;
subPalavra VARCHAR2(100);
subPalavraVet VARCHAR2(100);
VetorTemp APPP_PKG_VETORES.CHAR_VECTOR;
indice number(10):=1;
retorno number(10):=0;
BEGIN

  for i in 1..length(palavra) loop
  maiortamanho:= maioritem;
  maiorItem:=1;
  subPalavra:= substr(Palavra, 1, i);
  VetorTemp.DELETE;
  indice:=1;
        for j in 1..VetorNovo.count loop
          subPalavraVet:= substr(VetorNovo(j), 1, i);

            if(subpalavra=subpalavravet) then
                vetortemp(indice):=VetorNovo(j);
                indice:=indice+1;
                maiorItem:= greatest(maiorItem, length(VetorNovo(j)));
            end if;


        end loop;

        VetorNovo:=VetorTemp;
        retorno:=i;

        if (VetorNovo.count=0) then
          MaiorItem:=MaiorTamanho;
          MaiorTamanho:=greatest(maioritem, length(palavra));
          retorno:=i-1;
        end if;

  exit when VetorNovo.Count=0;
  end loop;

  RETURN retorno;

END APPP_FN_MAIORSUB;
