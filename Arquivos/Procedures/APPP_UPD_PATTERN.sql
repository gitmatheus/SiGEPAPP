/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_UPD_PATTERN : Procedure para criação de dados de PATTERNS
*                    vResult( 1=OK; -99=ErroGeral)
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_PATTERN(pCD_PATTERN      in NUMBER  , 
                                             pDS_PAT_PROBLEMA IN VARCHAR2,
                                             pDS_PAT_SOLUCAO  in VARCHAR2,
                                             vResult          out number) is
begin
    
   IF pDS_PAT_PROBLEMA IS NOT NULL THEN
      UPDATE APPP_TB_PATTERN 
      SET DS_PAT_PROBLEMA = pDS_PAT_PROBLEMA
      WHERE CD_PATTERN = pCD_PATTERN;
   END IF;   
   
   IF pDS_PAT_SOLUCAO IS NOT NULL THEN
      UPDATE APPP_TB_PATTERN 
      SET DS_PAT_SOLUCAO = pDS_PAT_SOLUCAO
      WHERE CD_PATTERN = pCD_PATTERN;
   END IF;
     
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_PATTERN;
/