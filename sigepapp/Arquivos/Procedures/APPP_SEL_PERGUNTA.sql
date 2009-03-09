/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_SEL_PERGUNTA : Procedure para SELECIONAR dados de PERGUNTAS
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                              pDS_PERGUNTA IN VARCHAR2,
                                              p_cursor OUT SYS_REFCURSOR) is
begin
    
    IF pCD_PERGUNTA IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_PERGUNTA , 
              DS_PERGUNTA 
       FROM APPP_TB_PERGUNTA
       WHERE CD_PERGUNTA = pCD_PERGUNTA;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_PERGUNTA , 
              DS_PERGUNTA  
       FROM APPP_TB_PERGUNTA AP
       WHERE (DS_PERGUNTA like ('%'|| pDS_PERGUNTA || '%') OR pDS_PERGUNTA IS NULL);     
        
   END IF;                
end APPP_SEL_PERGUNTA;
