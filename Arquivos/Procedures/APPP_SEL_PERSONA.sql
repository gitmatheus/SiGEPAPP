/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_SEL_PERSONA : Procedure para SELECIONAR dados de PERSONAS
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_PERSONA(pCD_PERSONA NUMBER  ,
                                             pURL_FOTO   VARCHAR2,
                                             p_cursor OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_PERSONA IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_PERSONA , 
              NM_PERSONA ,
              URL_FOTO  
       FROM APPP_TB_PERSONA
       WHERE CD_PERSONA = pCD_PERSONA;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_PERSONA , 
              NM_PERSONA ,
              URL_FOTO     
       FROM APPP_TB_PERSONA AP
       WHERE (URL_FOTO   like ('%'|| pURL_FOTO || '%')   OR pURL_FOTO   IS NULL);     
        
   END IF;                
end APPP_SEL_PERSONA;
/
