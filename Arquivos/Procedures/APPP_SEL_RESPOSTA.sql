/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_SEL_RESPOSTA : Procedure para SELECIONAR dados de RESPOSTAS
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RESPOSTA(pCD_RESPOSTA IN NUMBER  ,
                                              pDS_RESPOSTA IN VARCHAR2 ,
                                              p_cursor OUT SYS_REFCURSOR) is
begin
    
    IF pCD_RESPOSTA IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_RESPOSTA , 
              DS_RESPOSTA 
       FROM APPP_TB_RESPOSTA
       WHERE CD_RESPOSTA = pCD_RESPOSTA;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_RESPOSTA , 
              DS_RESPOSTA 
       FROM APPP_TB_RESPOSTA AP
       WHERE (DS_RESPOSTA  like ('%'|| pDS_RESPOSTA || '%') OR pDS_RESPOSTA IS NULL);     
        
   END IF;                
end APPP_SEL_RESPOSTA;
/
