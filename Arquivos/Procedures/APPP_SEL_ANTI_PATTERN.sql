/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_SEL_ANTI_PATTERN : Procedure para SELECIONAR dados de ANTI-PATTERNS
* 
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ANTI_PATTERN(pCD_ANTI_PATTERN  in NUMBER  , 
                                                  pDS_SINTOMAS      in VARCHAR2, 
                                                  pDS_RECOMENDACOES in VARCHAR2,
                                                  pDS_CONSEQUENCIAS in VARCHAR2,
                                                  pDS_BARREIRAS     in VARCHAR2,
                                                  p_cursor OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_ANTI_PATTERN IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_ANTI_PATTERN  ,
              DS_SINTOMAS      ,
              DS_RECOMENDACOES ,
              DS_CONSEQUENCIAS ,
              DS_BARREIRAS     
       FROM APPP_TB_ANTI_PATTERN
       WHERE CD_ANTI_PATTERN = pCD_ANTI_PATTERN;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_ANTI_PATTERN  ,
              DS_SINTOMAS      ,
              DS_RECOMENDACOES ,
              DS_CONSEQUENCIAS ,
              DS_BARREIRAS     
       FROM APPP_TB_ANTI_PATTERN AP
       WHERE (AP.DS_SINTOMAS      like ('%'|| pDS_SINTOMAS || '%')      OR pDS_SINTOMAS      IS NULL)
       AND   (AP.DS_RECOMENDACOES like ('%'|| pDS_RECOMENDACOES || '%') OR pDS_RECOMENDACOES IS NULL)
       AND   (AP.DS_CONSEQUENCIAS like ('%'|| pDS_CONSEQUENCIAS || '%') OR pDS_CONSEQUENCIAS IS NULL)
       AND   (AP.DS_BARREIRAS     like ('%'|| pDS_BARREIRAS || '%')     OR pDS_BARREIRAS     IS NULL);
       
   END IF;                
end APPP_SEL_ANTI_PATTERN;
/