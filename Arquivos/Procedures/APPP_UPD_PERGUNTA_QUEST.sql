/**********************************************************************************************************************
* Project Name            : SiGEPAPP
* APPP_UPD_PERGUNTA_QUEST : Procedure para criação de dados de PERGUNTA_QUEST
*                           vResult( 1=OK; -99=ErroGeral)
*                           É NECESSÁRIO INFORMAR TODOS OS PARÂMETROS
* Author                  : WeeDo 
* History                 : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_PERGUNTA_QUEST(pCD_QUEST_OLD    NUMBER,
                                                    pCD_PERGUNTA_OLD NUMBER,
                                                    pCD_RESPOSTA_OLD NUMBER,                                                    
                                                    pCD_QUEST_NEW    NUMBER,
                                                    pCD_PERGUNTA_NEW NUMBER,
                                                    pCD_RESPOSTA_NEW NUMBER,                                                    
                                                    vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   UPDATE APPP_TB_PERGUNTA_QUEST 
   SET   CD_QUEST    = pCD_QUEST_NEW   ,
         CD_PERGUNTA = pCD_PERGUNTA_NEW,
         CD_RESPOSTA = pCD_RESPOSTA_NEW
   WHERE CD_QUEST    = pCD_QUEST_OLD   
   AND   CD_PERGUNTA = pCD_PERGUNTA_OLD
   AND   CD_RESPOSTA = pCD_RESPOSTA_OLD;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_PERGUNTA_QUEST;
/