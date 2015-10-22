/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_UPD_AVAL_OBJ_USER : Procedure para atualizacao de dados de AVAL_OBJ_USER
*                         vResult( 1=OK; -99=ErroGeral)
*                         E NECESSARIO INFORMAR TODOS OS PARAMETROS
* Author                : WeeDo 
* History               : 06/05/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_AVAL_OBJ_USER(pCD_USER_OLD    NUMBER,
                                                   pCD_OBJETO_OLD NUMBER,
                                                   pCD_USER_NEW    NUMBER,
                                                   pCD_OBJETO_NEW NUMBER,
                                                   vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   UPDATE APPP_TB_AVAL_OBJ_USER 
   SET   CD_USER    = pCD_USER_NEW   ,
         CD_OBJETO = pCD_OBJETO_NEW         
   WHERE CD_USER    = pCD_USER_OLD   
   AND   CD_OBJETO = pCD_OBJETO_OLD;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_AVAL_OBJ_USER;
/
