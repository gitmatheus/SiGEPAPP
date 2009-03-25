/**********************************************************************************************************************
* Project Name                : SiGEPAPP
* APPP_SEL_RESP_QUEST_PREENCH : Procedure para SELECIONAR dados de RESP_QUEST_PREENCH
* Author                      : WeeDo 
* History                     : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RESP_QUEST_PREENCH(pCD_QUEST_PREENCH    NUMBER,
                                                        pCD_PERGUNTA NUMBER,
                                                        pCD_RESPOSTA NUMBER,
                                                        p_cursor OUT SYS_REFCURSOR) is
begin
    
    
       open p_cursor FOR       
       SELECT CD_QUEST_PREENCH    ,
              CD_PERGUNTA ,
              CD_RESPOSTA 
       FROM APPP_TB_RESP_QUEST_PREENCH
       WHERE (CD_QUEST_PREENCH    = pCD_QUEST_PREENCH    OR pCD_QUEST_PREENCH    IS NULL)
       AND   (CD_PERGUNTA = pCD_PERGUNTA OR pCD_PERGUNTA IS NULL)
       AND   (CD_RESPOSTA = pCD_RESPOSTA OR pCD_RESPOSTA IS NULL);     
   
end APPP_SEL_RESP_QUEST_PREENCH;
/
