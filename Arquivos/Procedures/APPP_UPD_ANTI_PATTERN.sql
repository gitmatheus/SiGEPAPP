/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_UPD_ANTI_PATTERN : Procedure para criação de dados de ANTI-PATTERNS
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_ANTI_PATTERN(vCD_ANTI_PATTERN  in NUMBER  , 
                                                  vDS_SINTOMAS      in VARCHAR2, 
                                                  vDS_RECOMENDACOES in VARCHAR2,
                                                  vDS_CONSEQUENCIAS in VARCHAR2,
                                                  vDS_BARREIRAS     in VARCHAR2,
                                                  vResult           out number) is
vERRO        VARCHAR2(600);
begin
    
   IF vDS_SINTOMAS IS NOT NULL THEN
      UPDATE APPP_TB_ANTI_PATTERN 
      SET DS_SINTOMAS = vDS_SINTOMAS
      WHERE CD_ANTI_PATTERN = vCD_ANTI_PATTERN;
   END IF;   
   
   IF vDS_RECOMENDACOES IS NOT NULL THEN
      UPDATE APPP_TB_ANTI_PATTERN 
      SET DS_RECOMENDACOES = vDS_RECOMENDACOES
      WHERE CD_ANTI_PATTERN = vCD_ANTI_PATTERN;
   END IF;
   
   IF vDS_CONSEQUENCIAS IS NOT NULL THEN
      UPDATE APPP_TB_ANTI_PATTERN 
      SET DS_CONSEQUENCIAS = vDS_CONSEQUENCIAS
      WHERE CD_ANTI_PATTERN = vCD_ANTI_PATTERN;
   END IF; 
  
   IF vDS_BARREIRAS IS NOT NULL THEN
      UPDATE APPP_TB_ANTI_PATTERN 
      SET DS_BARREIRAS = vDS_BARREIRAS
      WHERE CD_ANTI_PATTERN = vCD_ANTI_PATTERN;
   END IF;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_ANTI_PATTERN;
/