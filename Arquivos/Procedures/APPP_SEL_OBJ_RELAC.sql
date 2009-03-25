/***********************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_OBJ_RELAC : Procedure para SELECIONAR dados de OBJ_RELACS
* Author             : WeeDo 
* History            : 04/03/2009 - Matheus Goncalves
************************************************************************************/
create or replace procedure APPP_SEL_OBJ_RELAC(pCD_RELAC            IN NUMBER   ,
                                               pCD_OBJ_RELACIONADO  IN number   ,
                                               pCD_OBJ_RELACIONANDO IN number   , 
                                               pCD_ATRIBUTO_OBJ     IN NUMBER   ,
                                               p_cursor         OUT SYS_REFCURSOR) is
begin
       open p_cursor FOR
       SELECT CD_RELAC            ,
              CD_OBJ_RELACIONADO  ,
              CD_OBJ_RELACIONANDO , 
              CD_ATRIBUTO_OBJ     ,
              VL_RELAC     
       FROM APPP_TB_OBJ_RELAC
       WHERE (CD_OBJ_RELACIONADO  = pCD_OBJ_RELACIONADO  OR pCD_OBJ_RELACIONADO  IS NULL) 
       AND   (CD_OBJ_RELACIONANDO = pCD_OBJ_RELACIONANDO OR pCD_OBJ_RELACIONANDO IS NULL)
       AND   (CD_RELAC            = pCD_RELAC            OR pCD_RELAC            IS NULL)
       AND   (CD_ATRIBUTO_OBJ     = pCD_ATRIBUTO_OBJ     OR pCD_ATRIBUTO_OBJ     IS NULL);    
                    
end APPP_SEL_OBJ_RELAC;
/
