/*******************************************************************************
* Project Name       : SiGEPAPP
* APPP_INS_OBJ_RELAC : Procedure para cria��o de dados de OBJ_RELAC
*                      vResult( 1=OK; -99=ErroGeral)
* Author             : WeeDo 
* History            : 04/03/2009 - Matheus Gon�alves
********************************************************************************/
create or replace procedure APPP_INS_OBJ_RELAC(pCD_OBJETO       IN NUMBER,
                                               pCD_OBJETO_RELAC IN NUMBER, 
                                               vResult          out number) is
begin
   
   insert into APPP_TB_OBJ_RELAC(CD_OBJETO        ,
                                 CD_OBJETO_RELAC
                                )
                          values( pCD_OBJETO       ,
                                  pCD_OBJETO_RELAC 
                                );                             
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_OBJ_RELAC;
