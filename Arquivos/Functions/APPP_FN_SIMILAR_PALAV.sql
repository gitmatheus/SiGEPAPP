/*****************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_FN_SIMILAR_PALAV : Function retorna um número de 0 à 1 de acordo com a similaridade de 2 textos
* Author                : WeeDo 
* History               : 30/03/2009 - Matheus Goncalves - Versão Inicial
******************************************************************************************************/

create or replace FUNCTION APPP_FN_SIMILAR_PALAV( TextoProcurado IN VARCHAR2
                                                , TextoBase      IN VARCHAR2
                                                ) RETURN NUMBER IS
                                                
 vTextoProcurado  APPP_TB_OBJETO.DS_OBJETO%TYPE;
 vTextoBase       APPP_TB_OBJETO.DS_OBJETO%TYPE;
 
 vPalavra                  varchar2(100);
 vQntPalavrasEncontradas   number(10) := 0;
 vQntPalavrasProcurado     number(10) := 0;
 vQntPalavrasBase          number(10) := 0;
 vRetorno                  number(10,2) := 0;
 vDivisor                  number(10,2) := 0;
 
 
BEGIN
 
 vTextoProcurado := UPPER(APPP_FN_REMOVE_ACENTO_PONT(TextoProcurado));
 vTextoBase :=      UPPER(APPP_FN_REMOVE_ACENTO_PONT(TextoBase));
 
 vQntPalavrasProcurado := APPP_FN_CONTA_PALAVRAS(vTextoProcurado, ' ');
 vQntPalavrasBase      := APPP_FN_CONTA_PALAVRAS(vTextoBase, ' ');
 
 IF vQntPalavrasProcurado <=0 or vQntPalavrasBase <= 0 THEN
    RETURN 0;
 ELSE 
     vQntPalavrasEncontradas := 0;
     if vQntPalavrasProcurado > 1 THEN
         for i in 1..vQntPalavrasProcurado 
         LOOP
             vPalavra := substr(vTextoProcurado,1,INSTR(vTextoProcurado,' ')-1);
             if vPalavra is null then
                vPalavra :=  vTextoProcurado;
             end if;  
             vTextoProcurado := substr(vTextoProcurado,INSTR(vTextoProcurado,' ')+1,length(vTextoProcurado) );
             if INSTR(vTextoBase, vPalavra) > 0 THEN
                vQntPalavrasEncontradas := vQntPalavrasEncontradas + 1;                
             END IF; 
         END LOOP;
     END IF;
     if vQntPalavrasBase > vQntPalavrasProcurado then
        vDivisor := vQntPalavrasBase; 
     else
        vDivisor := vQntPalavrasProcurado;
     end if;   
     vRetorno := vQntPalavrasEncontradas / vDivisor;
     
 END IF;    
    RETURN vRetorno;
     
END APPP_FN_SIMILAR_PALAV;
