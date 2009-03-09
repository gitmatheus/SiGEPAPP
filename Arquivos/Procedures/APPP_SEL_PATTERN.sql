/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_SEL_PATTERN : Procedure para SELECIONAR dados de PATTERNS
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_PATTERN(pCD_PATTERN      in NUMBER  , 
                                             pDS_PAT_PROBLEMA IN VARCHAR2,
                                             pDS_PAT_SOLUCAO  in VARCHAR2,
                                             p_cursor OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_PATTERN IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_PATTERN      , 
              DS_PAT_PROBLEMA ,
              DS_PAT_SOLUCAO  
                
       FROM APPP_TB_PATTERN
       WHERE CD_PATTERN = pCD_PATTERN;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_PATTERN      , 
              DS_PAT_PROBLEMA ,
              DS_PAT_SOLUCAO     
       FROM APPP_TB_PATTERN AP
       WHERE (DS_PAT_PROBLEMA  like ('%'|| pDS_PAT_PROBLEMA || '%') OR pDS_PAT_PROBLEMA IS NULL)
       AND   (DS_PAT_SOLUCAO   like ('%'|| pDS_PAT_SOLUCAO || '%')  OR pDS_PAT_SOLUCAO  IS NULL);     
        
   END IF;                
end APPP_SEL_PATTERN;
