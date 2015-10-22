/**********************************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_SEL_CODIGO_POSTAL : Procedure para SELECIONAR dados de CODIGO_POSTAL
* 
* Author        : WeeDo 
* History       : 03/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_CODIGO_POSTAL(pCD_CEP    IN NUMBER   ,
                                                   pNM_RUA    IN VARCHAR2 ,
                                                   pCD_CIDADE IN NUMBER   ,
                                                   p_cursor   OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_CEP IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_CEP    ,
              NM_RUA    , 
              CD_CIDADE              
       FROM APPP_TB_CODIGO_POSTAL
       WHERE CD_CEP = pCD_CEP;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_CEP    ,
              NM_RUA    , 
              CD_CIDADE  
       FROM APPP_TB_CODIGO_POSTAL
       WHERE (NM_RUA LIKE  ('%'|| pNM_RUA || '%') OR pNM_RUA IS NULL)
       AND   (CD_CIDADE = pCD_CIDADE OR pCD_CIDADE IS NULL);     
       
   END IF;                
end APPP_SEL_CODIGO_POSTAL;
/