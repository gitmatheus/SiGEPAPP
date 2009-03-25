/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_UPD_ESTRUT_QUEST : Procedure para cria��o de dados de ESTRUT_QUEST
*                         vResult( 1=OK; -99=ErroGeral)
*                         � NECESS�RIO INFORMAR TODOS OS PAR�METROS
* Author                : WeeDo 
* History               : 24/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_ESTRUT_QUEST(pCD_QUEST_OLD    NUMBER,
                                                  pCD_PERGUNTA_OLD NUMBER,
                                                  pNR_ORDEM_OLD    NUMBER,                                                    
                                                  pCD_QUEST_NEW    NUMBER,
                                                  pCD_PERGUNTA_NEW NUMBER,
                                                  pNR_ORDEM_NEW    NUMBER,                                                    
                                                  vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   UPDATE APPP_TB_ESTRUT_QUEST 
   SET   CD_QUEST    = pCD_QUEST_NEW   ,
         CD_PERGUNTA = pCD_PERGUNTA_NEW,
         NR_ORDEM    = pNR_ORDEM_NEW
   WHERE CD_QUEST    = pCD_QUEST_OLD   
   AND   CD_PERGUNTA = pCD_PERGUNTA_OLD
   AND   NR_ORDEM    = pNR_ORDEM_OLD;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_ESTRUT_QUEST;
/
