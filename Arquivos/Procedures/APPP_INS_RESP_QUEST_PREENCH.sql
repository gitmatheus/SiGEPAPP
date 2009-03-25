/******************************************************************************
* Project Name                : SiGEPAPP
* APPP_INS_RESP_QUEST_PREENCH : Procedure para criação de dados de RESP_QUEST_PREENCH
*                               vResult( 1=OK; -99=ErroGeral)                     
* Author                      : WeeDo 
* History                     : 24/03/2009 - Matheus Gonçalves
*******************************************************************************/
create or replace procedure APPP_INS_RESP_QUEST_PREENCH(pCD_QUEST_PREENCH    IN NUMBER,
                                                        pCD_PERGUNTA IN NUMBER,
                                                        pCD_RESPOSTA IN NUMBER,
                                                        vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_RESP_QUEST_PREENCH(CD_QUEST_PREENCH    ,
                                      CD_PERGUNTA ,
                                      CD_RESPOSTA 
                                     )
                              values( pCD_QUEST_PREENCH    ,
                                      pCD_PERGUNTA ,
                                      pCD_RESPOSTA 
                                    );  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_RESP_QUEST_PREENCH;
/
