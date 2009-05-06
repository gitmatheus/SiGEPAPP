/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_INS_QUEST_PREENCH : Procedure para criacao de dados de QUEST_PREENCH
*                          vResult( 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 06/03/2009 - Matheus Goncalves
*                        : 06/05/2009 - Matheus Goncalves - Adicao de Campos CD_USER e CD_OBJETO
***********************************************************************************************************************/
create or replace procedure APPP_INS_QUEST_PREENCH(pCD_QUEST_PREENCH  IN NUMBER   ,
                                                   pDT_APLICACAO      IN DATE     ,
                                                   pVL_AVALIACAO      IN NUMBER   ,
                                                   pDS_PROJ_APLIC     IN VARCHAR2 ,
																									 pCD_USER           IN NUMBER   ,
																									 pCD_OBJETO         IN NUMBER   ,
                                                   vResult            out number) is
vERRO        VARCHAR2(600);
begin
   
   insert into APPP_TB_QUEST_PREENCH( CD_QUEST_PREENCH ,
                                      DT_APLICACAO     ,
                                      VL_AVALIACAO     ,
                                      DS_PROJ_APLIC    ,
																			CD_USER          ,
																			CD_OBJETO 
                                    )
                             values( pCD_QUEST_PREENCH ,
                                     pDT_APLICACAO     ,
                                     pVL_AVALIACAO     ,
                                     pDS_PROJ_APLIC    ,
																		 pCD_USER          ,
																		 pCD_OBJETO                                                
                                    );
                                    
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_QUEST_PREENCH;
/
