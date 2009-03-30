/*****************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_FN_CONTA_PALAVRAS : Function retorna a quantidade de palavras em um texto.
* Author                 : WeeDo 
* History                : 30/03/2009 - Matheus Goncalves - Versão Inicial
******************************************************************************************************/

create or replace FUNCTION APPP_FN_CONTA_PALAVRAS( pTexto     IN VARCHAR2,
                                                   pSeparador IN VARCHAR2                                                   
                                                ) RETURN NUMBER IS
                                                
  vTexto VARCHAR2(30000);
  vQntPalavras NUMBER(10) := 0;
  vRETORNO NUMBER(10) := 0;
  vSepa VARCHAR2(1) := NVL(pSeparador,' ');
  
BEGIN

 vTexto := trim(pTexto);

 IF vTexto IS NULL OR length(vTexto) <= 0 THEN
    vRETORNO := 0;
 ELSE 
     
     if INSTR(vTexto,vSepa) = 0 THEN
         vRETORNO := 1;        
     ELSE
         vRETORNO := vRETORNO + 1;
         for i in 1..length(vTexto)
         LOOP
             vTexto := substr(vTexto,INSTR(vTexto,vSepa)+1,length(vTexto));
             vRETORNO := vRETORNO + 1; 
             EXIT WHEN INSTR(vTexto,vSepa) <= 0 or vTexto is null;             
         END LOOP;         
     END IF;
 END IF;    
 RETURN vRETORNO;
 
END APPP_FN_CONTA_PALAVRAS;
