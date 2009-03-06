/**********************************************************************************************************************
* Project Name            : SiGEPAPP
* APPP_UPD_PERGUNTA_QUEST : Procedure para cria��o de dados de PERGUNTA_QUEST
*                           vResult( 1=OK; -99=ErroGeral)
*                           � NECESS�RIO INFORMAR TODOS OS PAR�METROS
* Author                  : WeeDo 
* History                 : 06/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_PERGUNTA_QUEST(pCD_QUEST_OLD    NUMBER,
                                                    pCD_PERGUNTA_OLD NUMBER,
                                                    pCD_RESPOSTA_OLD NUMBER,                                                    
                                                    pCD_QUEST_NEW    NUMBER,
                                                    pCD_PERGUNTA_NEW NUMBER,
                                                    pCD_RESPOSTA_NEW NUMBER,                                                    
                                                    vResult     out number) is
begin
    
   UPDATE APPP_TB_PERGUNTA_QUEST 
   SET   CD_QUEST    = pCD_QUEST_NEW   ,
         CD_PERGUNTA = pCD_PERGUNTA_NEW,
         CD_RESPOSTA = pCD_RESPOSTA_NEW
   WHERE CD_QUEST    = pCD_QUEST_OLD   ,
         CD_PERGUNTA = pCD_PERGUNTA_OLD,
         CD_RESPOSTA = pCD_RESPOSTA_OLD;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_UPD_PERGUNTA_QUEST;
