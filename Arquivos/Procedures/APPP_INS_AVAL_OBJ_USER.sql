/******************************************************************************
* Project Name           : SiGEPAPP
* APPP_INS_AVAL_OBJ_USER : Procedure para criacao de dados de AVAL_OBJ_USER
*                         vResult( 1=OK; -99=ErroGeral)                     
* Author                 : WeeDo 
* History                : 06/05/2009 - Matheus Goncalves
*******************************************************************************/
create or replace procedure APPP_INS_AVAL_OBJ_USER(pCD_USER    IN NUMBER,
                                                   pCD_OBJETO IN NUMBER,
                                                   vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_AVAL_OBJ_USER(CD_USER    ,
                                     CD_OBJETO
                                     )
                              values( pCD_USER    ,
                                      pCD_OBJETO 
                                    );  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_AVAL_OBJ_USER;
/
