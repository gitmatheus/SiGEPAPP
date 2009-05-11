/**********************************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_SEL_TIPO : Procedure para SELECIONAR dados de TIPOS
* 
* Author        : WeeDo 
* History       : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_TIPO(pCD_TIPO    IN NUMBER  ,
                                          pNM_TIPO    IN VARCHAR2,
                                          pDS_TIPO    IN VARCHAR2,
                                          pFL_EXP_REG IN VARCHAR2,
                                          p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_TIPO IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_TIPO    ,
              NM_TIPO    , 
              DS_TIPO    , 
              FL_EXP_REG     
       FROM APPP_TB_TIPO
       WHERE CD_TIPO = pCD_TIPO;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_TIPO    ,
              NM_TIPO    , 
              DS_TIPO    , 
              FL_EXP_REG     
       FROM APPP_TB_TIPO T
       WHERE (lower(T.NM_TIPO) LIKE ('%'|| lower(pNM_TIPO) || '%') OR pNM_TIPO    IS NULL)
       AND   (lower(T.DS_TIPO) LIKE ('%'|| lower(pDS_TIPO) || '%') OR pDS_TIPO    IS NULL)
       AND   (T.FL_EXP_REG = pFL_EXP_REG             OR pFL_EXP_REG IS NULL);
       
   END IF;                
end APPP_SEL_TIPO;
/