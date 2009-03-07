/**********************************************************************************************************************
* Project Name               : SiGEPAPP
* APPP_SEL_RESPOSTA_PERGUNTA : Procedure para SELECIONAR dados de RESPOSTA_PERGUNTAS
* Author                     : WeeDo 
* History                    : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RESPOSTA_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                                       pCD_RESPOSTA IN NUMBER,
                                                       p_cursor OUT SYS_REFCURSOR) is
begin
    
       open p_cursor FOR
       SELECT CD_PERGUNTA , 
              CD_RESPOSTA  
       FROM APPP_TB_RESPOSTA_PERGUNTA
       WHERE (CD_PERGUNTA = pCD_PERGUNTA OR pCD_PERGUNTA IS NULL)
       AND   (CD_RESPOSTA = pCD_RESPOSTA OR pCD_RESPOSTA IS NULL);
        
                
end APPP_SEL_RESPOSTA_PERGUNTA;
