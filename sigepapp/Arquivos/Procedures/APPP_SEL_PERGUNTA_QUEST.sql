/**********************************************************************************************************************
* Project Name            : SiGEPAPP
* APPP_SEL_PERGUNTA_QUEST : Procedure para SELECIONAR dados de PERGUNTA_QUEST
* Author                  : WeeDo 
* History                 : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_PERGUNTA_QUEST(pCD_QUEST    NUMBER,
                                                    pCD_PERGUNTA NUMBER,
                                                    pCD_RESPOSTA NUMBER,
                                                    p_cursor OUT SYS_REFCURSOR) is
begin
    
    
       open p_cursor FOR       
       SELECT CD_QUEST    ,
              CD_PERGUNTA ,
              CD_RESPOSTA 
       FROM APPP_TB_PERGUNTA_QUEST
       WHERE (CD_QUEST    = pCD_QUEST    OR pCD_QUEST    IS NULL)
       AND   (CD_PERGUNTA = pCD_PERGUNTA OR pCD_PERGUNTA IS NULL)
       AND   (CD_RESPOSTA = pCD_RESPOSTA OR pCD_RESPOSTA IS NULL);     
   
end APPP_SEL_PERGUNTA_QUEST;
