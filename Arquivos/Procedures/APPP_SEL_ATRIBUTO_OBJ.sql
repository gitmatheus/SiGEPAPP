/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_SEL_ATRIBUTO_OBJ : Procedure para SELECIONAR dados de ATRIBUTO_OBJS
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ATRIBUTO_OBJ(pCD_ATRIBUTO_OBJ IN NUMBER   ,
                                                  pNM_ATRIBUTO_OBJ IN VARCHAR2 , 
                                                  pDS_ATRIBUTO_OBJ IN VARCHAR2 ,
                                                  pCD_TIPO         IN NUMBER   ,
                                                  pFL_ATRIB_RELAC  IN VARCHAR2 ,
                                                  p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_ATRIBUTO_OBJ IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_ATRIBUTO_OBJ    ,
              NM_ATRIBUTO_OBJ    , 
              DS_ATRIBUTO_OBJ    , 
              CD_TIPO            ,
              FL_ATRIB_RELAC     ,
              NM_COLUNA
       FROM APPP_TB_ATRIBUTO_OBJ
       WHERE CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_ATRIBUTO_OBJ    ,
              NM_ATRIBUTO_OBJ    , 
              DS_ATRIBUTO_OBJ    , 
              CD_TIPO            ,
              FL_ATRIB_RELAC     ,
              NM_COLUNA
       FROM APPP_TB_ATRIBUTO_OBJ AO
       WHERE (AO.NM_ATRIBUTO_OBJ LIKE ('%'|| pNM_ATRIBUTO_OBJ || '%') OR pNM_ATRIBUTO_OBJ IS NULL)
       AND   (AO.DS_ATRIBUTO_OBJ LIKE ('%'|| pDS_ATRIBUTO_OBJ || '%') OR pDS_ATRIBUTO_OBJ IS NULL)
       AND   (AO.CD_TIPO        = pCD_TIPO        OR pCD_TIPO        IS NULL)
       AND   (AO.FL_ATRIB_RELAC = pFL_ATRIB_RELAC OR pFL_ATRIB_RELAC IS NULL);

       
   END IF;                
end APPP_SEL_ATRIBUTO_OBJ;
/