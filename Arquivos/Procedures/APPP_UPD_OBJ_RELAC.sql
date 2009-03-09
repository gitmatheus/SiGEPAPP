/****************************************************************************************
* Project Name        : SiGEPAPP
* APPP_UPD_OBJ_RELAC : Procedure para ATUALIZAÇÃO de dados de OBJ_RELACS
*                      vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gonçalves
******************************************************************************************/

create or replace procedure APPP_UPD_OBJ_RELAC(pCD_OBJETO       IN NUMBER,
                                               pCD_OBJETO_RELAC IN NUMBER,
                                               vResult     out number) is
begin
/*    
   UPDATE APPP_TB_OBJ_RELAC 
     SET CD_OBJETO_RELAC = pCD_OBJETO_RELAC
   WHERE CD_OBJETO = pCD_OBJETO;
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.*/
        
  -- NÃO SE APLICA ATUALIZAÇÃO EM RELAÇÃO DE OBJETOS
     null;
               
end APPP_UPD_OBJ_RELAC;
