/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_PES_PARAM_PROCEDURE  : Procedure para PESQUISAR PARAMETROS DE UMA DETERMINADA PROCEDURE.
* Author                    : WeeDo 
* History                   : 26/03/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_PES_PARAM_PROCEDURE(pPROCEDURE_NAME IN VARCHAR2, 
                                                     p_cursor        OUT SYS_REFCURSOR   ) is
begin
    
       open p_cursor FOR
       SELECT AA.ARGUMENT_NAME PARAMETRO  ,
              AA.DATA_TYPE     ORACLETYPE ,
              AA.in_out        IN_OUT   
       FROM ALL_ARGUMENTS AA
       where aa.object_name = UPPER(pPROCEDURE_NAME)
       ORDER BY AA.SEQUENCE;
       
end APPP_PES_PARAM_PROCEDURE;
/
