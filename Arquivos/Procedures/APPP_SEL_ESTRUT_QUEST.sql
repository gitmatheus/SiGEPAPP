/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_SEL_ESTRUT_QUEST : Procedure para SELECIONAR dados de ESTRUT_QUEST
* Author                : WeeDo 
* History               : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ESTRUT_QUEST(pCD_QUEST    NUMBER,
                                                  pCD_PERGUNTA NUMBER,
                                                  pNR_ORDEM    NUMBER,
                                                  p_cursor OUT SYS_REFCURSOR) is
begin
    
    
       open p_cursor FOR       
       SELECT CD_QUEST    ,
              CD_PERGUNTA ,
              NR_ORDEM               
       FROM APPP_TB_ESTRUT_QUEST
       WHERE (CD_QUEST    = pCD_QUEST    OR pCD_QUEST    IS NULL)
       AND   (CD_PERGUNTA = pCD_PERGUNTA OR pCD_PERGUNTA IS NULL)
       AND   (NR_ORDEM    = pNR_ORDEM    OR pNR_ORDEM    IS NULL);     
   
end APPP_SEL_ESTRUT_QUEST;
/
