/***********************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_OBJ_RELAC : Procedure para SELECIONAR dados de OBJ_RELACS
* Author             : WeeDo 
* History            : 04/03/2009 - Matheus Gonçalves
************************************************************************************/
create or replace procedure APPP_SEL_OBJ_RELAC(pCD_OBJETO       IN NUMBER,
                                               pCD_OBJETO_RELAC IN NUMBER,
                                               p_cursor         OUT SYS_REFCURSOR) is
begin
       open p_cursor FOR
       SELECT CD_OBJETO      ,
              CD_OBJETO_RELAC    
       FROM APPP_TB_OBJ_RELAC
       WHERE (CD_OBJETO       = pCD_OBJETO       OR pCD_OBJETO       IS NULL) 
       AND   (CD_OBJETO_RELAC = pCD_OBJETO_RELAC OR pCD_OBJETO_RELAC IS NULL);    
                    
end APPP_SEL_OBJ_RELAC;
/