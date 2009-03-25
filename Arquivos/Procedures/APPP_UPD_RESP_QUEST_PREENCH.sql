/**********************************************************************************************************************
* Project Name                : SiGEPAPP
* APPP_UPD_RESP_QUEST_PREENCH : Procedure para criação de dados de RESP_QUEST_PREENCH
*                              vResult( 1=OK; -99=ErroGeral)
*                              É NECESSÁRIO INFORMAR TODOS OS PARÂMETROS
* Author                      : WeeDo 
* History                     : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_RESP_QUEST_PREENCH(pCD_QUEST_PREENCH_OLD    NUMBER,
                                                        pCD_PERGUNTA_OLD NUMBER,
                                                        pCD_RESPOSTA_OLD NUMBER,                                                    
                                                        pCD_QUEST_PREENCH_NEW    NUMBER,
                                                        pCD_PERGUNTA_NEW NUMBER,
                                                        pCD_RESPOSTA_NEW NUMBER,                                                    
                                                        vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   UPDATE APPP_TB_RESP_QUEST_PREENCH 
   SET   CD_QUEST_PREENCH    = pCD_QUEST_PREENCH_NEW   ,
         CD_PERGUNTA = pCD_PERGUNTA_NEW,
         CD_RESPOSTA = pCD_RESPOSTA_NEW
   WHERE CD_QUEST_PREENCH    = pCD_QUEST_PREENCH_OLD   
   AND   CD_PERGUNTA = pCD_PERGUNTA_OLD
   AND   CD_RESPOSTA = pCD_RESPOSTA_OLD;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_RESP_QUEST_PREENCH;
/
