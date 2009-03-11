/****************************************************************************************
* Project Name          : SiGEPAPP
* APPP_UPD_QUESTIONARIO : Procedure para ATUALIZAÇÃO de dados de QUESTIONARIO
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_QUESTIONARIO(pCD_QUEST      IN NUMBER  ,
                                                  pDT_APLICACAO  IN DATE     ,
                                                  pVL_AVALIACAO  IN NUMBER   ,
                                                  pDS_PROJ_APLIC IN VARCHAR2 ,
                                                  pCD_USER       IN NUMBER ,
                                                  vResult           out number) is
begin
    
   IF pDT_APLICACAO IS NOT NULL THEN
      UPDATE APPP_TB_QUESTIONARIO 
      SET DT_APLICACAO = pDT_APLICACAO
      WHERE CD_QUEST = pCD_QUEST;
   END IF;   
   
   IF pVL_AVALIACAO IS NOT NULL THEN
      UPDATE APPP_TB_QUESTIONARIO 
      SET VL_AVALIACAO = pVL_AVALIACAO
      WHERE CD_QUEST = pCD_QUEST;
   END IF;
   
   IF pDS_PROJ_APLIC IS NOT NULL THEN
      UPDATE APPP_TB_QUESTIONARIO 
      SET DS_PROJ_APLIC = pDS_PROJ_APLIC
      WHERE CD_QUEST = pCD_QUEST;
   END IF;
   
   IF pCD_USER IS NOT NULL THEN
      UPDATE APPP_TB_QUESTIONARIO 
      SET CD_USER = pCD_USER
      WHERE CD_QUEST = pCD_QUEST;
   END IF;   
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_QUESTIONARIO;
/