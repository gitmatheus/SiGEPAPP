/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_SEL_RELAC_QUEST_OBJ : Procedure para SELECIONAR dados de RELAC_QUEST_OBJS
* Author                   : WeeDo 
* History                  : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RELAC_QUEST_OBJ(pCD_QUEST_PREENCH  in number,
                                                     pCD_QUEST          in number,
                                                     pCD_OBJETO         in number,         
                                                     pCD_USER           in NUMBER,
                                                     p_cursor OUT SYS_REFCURSOR) is
begin
    
    IF pCD_QUEST_PREENCH IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT  CD_QUEST_PREENCH  ,
               CD_QUEST          ,
               CD_OBJETO         ,         
               CD_USER           
       FROM APPP_TB_RELAC_QUEST_OBJ
       WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_QUEST_PREENCH  ,
               CD_QUEST          ,
               CD_OBJETO         ,         
               CD_USER              
       FROM APPP_TB_RELAC_QUEST_OBJ
       WHERE (CD_USER   = pCD_USER   OR pCD_USER   IS NULL)
       AND   (CD_QUEST  = pCD_QUEST  OR pCD_QUEST  IS NULL)          
       AND   (CD_OBJETO = pCD_OBJETO OR pCD_OBJETO IS NULL);
       
   END IF;                
end APPP_SEL_RELAC_QUEST_OBJ;
/
