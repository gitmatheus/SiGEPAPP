/**********************************************************************************************************************
* Project Name        : SiGEPAPP
* APPP_SEL_USER_EMAIL : Procedure para SELECIONAR dados de USER_EMAILS
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_USER_EMAIL(pCD_USER  IN NUMBER  ,
                                                pNM_EMAIL IN VARCHAR2,
                                                pTP_EMAIL IN VARCHAR2,
                                                p_cursor OUT SYS_REFCURSOR   ) is
begin
    
       open p_cursor FOR
       SELECT CD_USER  ,
              NM_EMAIL ,
              TP_EMAIL     
       FROM APPP_TB_USER_EMAIL
       WHERE CD_USER = pCD_USER
       AND   (NM_EMAIL like ('%'|| pNM_EMAIL || '%') OR pNM_EMAIL IS NULL)
       AND   (TP_EMAIL like ('%'|| pTP_EMAIL || '%') OR pTP_EMAIL IS NULL);     
            
end APPP_SEL_USER_EMAIL;
