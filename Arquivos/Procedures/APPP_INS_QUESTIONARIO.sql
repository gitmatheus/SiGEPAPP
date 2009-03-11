/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_INS_QUESTIONARIO : Procedure para criação de dados de QUESTIONARIO
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_QUESTIONARIO(pCD_QUEST      OUT NUMBER  ,
                                                  pDT_APLICACAO  IN DATE     ,
                                                  pVL_AVALIACAO  IN NUMBER   ,
                                                  pDS_PROJ_APLIC IN VARCHAR2 ,
                                                  pCD_USER       IN NUMBER   ,
                                                  vResult        out number) is
begin
   
   insert into APPP_TB_QUESTIONARIO( CD_QUEST      ,
                                     DT_APLICACAO  ,
                                     VL_AVALIACAO  ,
                                     DS_PROJ_APLIC ,
                                     CD_USER
                                    )
                             values( pCD_QUEST      ,
                                     pDT_APLICACAO  ,
                                     pVL_AVALIACAO  ,
                                     pDS_PROJ_APLIC ,
                                     pCD_USER        
                                    );
                                    
   select APPP_SEQ_QUESTIONARIO.CURRVAL
   into pCD_QUEST
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_QUESTIONARIO;
/