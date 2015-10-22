/**********************************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_SEL_OBJ_PATTERN : Procedure para SELECIONAR PATTERNS COMPLETOS
* Author               : WeeDo 
* History              : 16/04/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_PATTERN(pCD_PATTERN      IN NUMBER,
                                             pNM_OBJETO       IN VARCHAR2,
                                             pCD_ESTRUTURA    IN NUMBER,
                                             pDS_OBJETO       IN VARCHAR2,
                                             pCD_USER_CRIADOR IN NUMBER,
                                             pDS_PAT_PROBLEMA IN VARCHAR2,
                                             pDS_PAT_SOLUCAO  IN VARCHAR2,
                                             p_cursor OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_PATTERN IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT P.CD_PATTERN      , 
              O.NM_OBJETO       ,
              O.CD_ESTRUTURA    ,
              O.DS_OBJETO       ,
              O.CD_USER_CRIADOR ,
              P.DS_PROBLEMA ,
              P.DS_SOLUCAO                  
       FROM APPP_TB_PATTERN P,
            APPP_TB_OBJETO  O
       WHERE P.CD_PATTERN = pCD_PATTERN
       AND   O.CD_OBJETO = P.CD_PATTERN;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT P.CD_PATTERN      , 
              O.NM_OBJETO       ,
              O.CD_ESTRUTURA    ,
              O.DS_OBJETO       ,
              O.CD_USER_CRIADOR ,
              P.DS_PROBLEMA ,
              P.DS_SOLUCAO                  
       FROM APPP_TB_PATTERN P,
            APPP_TB_OBJETO  O
       WHERE (P.DS_PROBLEMA      LIKE ('%'|| pDS_PAT_PROBLEMA || '%') OR pDS_PAT_PROBLEMA IS NULL)
       AND   (P.DS_SOLUCAO       LIKE ('%'|| pDS_PAT_SOLUCAO  || '%') OR pDS_PAT_SOLUCAO  IS NULL)
       AND   (O.NM_OBJETO        LIKE ('%'|| pNM_OBJETO       || '%') OR pNM_OBJETO       IS NULL)    
       AND   (O.CD_ESTRUTURA     =           pCD_ESTRUTURA            OR pCD_ESTRUTURA    IS NULL)
       AND   (O.CD_USER_CRIADOR  =           pCD_USER_CRIADOR         OR pCD_USER_CRIADOR IS NULL)       
       AND   (P.DS_OBJETO        LIKE ('%'|| pDS_OBJETO       || '%') OR pDS_OBJETO       IS NULL); 
   END IF;                
end APPP_SEL_PATTERN;
/
