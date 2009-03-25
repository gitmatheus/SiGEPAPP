/****************************************************************************************
* Project Name             : SiGEPAPP
* APPP_UPD_RELAC_QUEST_OBJ : Procedure para ATUALIZAÇÃO de dados de RELAC_QUEST_OBJ
*                            vResult( 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 24/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_RELAC_QUEST_OBJ(pCD_QUEST_PREENCH  in number,
                                                     pCD_QUEST          in number,
                                                     pCD_OBJETO         in number,         
                                                     pCD_USER           in NUMBER,
                                                     vResult           out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pCD_QUEST IS NOT NULL THEN
      UPDATE APPP_TB_RELAC_QUEST_OBJ 
      SET CD_QUEST = pCD_QUEST
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;   
   
   IF pCD_OBJETO  IS NOT NULL THEN
      UPDATE APPP_TB_RELAC_QUEST_OBJ 
      SET CD_OBJETO  = pCD_OBJETO 
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;
   
   IF pCD_USER IS NOT NULL THEN
      UPDATE APPP_TB_RELAC_QUEST_OBJ 
      SET CD_USER = pCD_USER
      WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;
   END IF;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_RELAC_QUEST_OBJ;
/
