/**********************************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_SEL_CIDADE : Procedure para SELECIONAR dados de CIDADES
* Author          : WeeDo 
* History         : 03/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_CIDADE(pCD_CIDADE IN NUMBER,
                                            pNM_CIDADE IN VARCHAR2,
                                            pNM_ABREV  IN VARCHAR2,
                                            pCD_ESTADO IN NUMBER,
                                            p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_CIDADE IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_CIDADE    ,
              NM_CIDADE    , 
              NM_ABREV     ,
              CD_ESTADO     
       FROM APPP_TB_CIDADE
       WHERE CD_CIDADE = pCD_CIDADE;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_CIDADE    ,
              NM_CIDADE    , 
              NM_ABREV     ,
              CD_ESTADO     
       FROM APPP_TB_CIDADE
       WHERE (NM_CIDADE LIKE ('%'|| pNM_CIDADE || '%') OR pNM_CIDADE IS NULL)
       AND   (NM_ABREV  LIKE ('%'|| pNM_ABREV || '%')  OR pNM_ABREV  IS NULL)
       AND   (CD_ESTADO = pCD_ESTADO                   OR pCD_ESTADO IS NULL);
       
   END IF;                
end APPP_SEL_CIDADE;
/