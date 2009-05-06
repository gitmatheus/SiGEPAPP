/****************************************************************************************
* Project Name           : SiGEPAPP
* APPP_UPD_QUEST_PREENCH : Procedure para ATUALIZAÇÃO de dados de QUEST_PREENCH
*                          vResult( 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 24/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_QUEST_PREENCH(pCD_QUEST_PREENCH IN NUMBER   ,
                                                   pDT_APLICACAO     IN DATE     ,
                                                   pVL_AVALIACAO     IN NUMBER   ,
                                                   pDS_PROJ_APLIC    IN VARCHAR2 ,
																									 pCD_USER          IN NUMBER   ,
																									 pCD_OBJETO        IN NUMBER   ,																									 
                                                   vResult           out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pDT_APLICACAO IS NOT NULL THEN
      UPDATE APPP_TB_QUEST_PREENCH 
      SET DT_APLICACAO = pDT_APLICACAO
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;   
   
   IF pVL_AVALIACAO IS NOT NULL THEN
      UPDATE APPP_TB_QUEST_PREENCH 
      SET VL_AVALIACAO = pVL_AVALIACAO
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;
   
   IF pDS_PROJ_APLIC IS NOT NULL THEN
      UPDATE APPP_TB_QUEST_PREENCH 
      SET DS_PROJ_APLIC = pDS_PROJ_APLIC
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;

   IF pCD_USER IS NOT NULL THEN
      UPDATE APPP_TB_QUEST_PREENCH 
      SET CD_USER = pCD_USER
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;

   IF pCD_OBJETO IS NOT NULL THEN
      UPDATE APPP_TB_QUEST_PREENCH 
      SET CD_OBJETO = pCD_OBJETO
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_QUEST_PREENCH ;
/
