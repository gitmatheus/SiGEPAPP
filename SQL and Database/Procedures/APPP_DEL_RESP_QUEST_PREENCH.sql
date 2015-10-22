/**********************************************************************************************************************
* Project Name                : SiGEPAPP
* APPP_DEL_RESP_QUEST_PREENCH : Procedure para DELETAR dados de RESP_QUEST_PREENCH
*                               vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                      : WeeDo 
* History                     : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_RESP_QUEST_PREENCH(pCD_QUEST_PREENCH    NUMBER,
                                                        pCD_PERGUNTA NUMBER,
                                                        pCD_RESPOSTA NUMBER,
                                                        vResult     out number) is
vERRO        VARCHAR2(600);                                                  
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_RESP_QUEST_PREENCH
      WHERE CD_QUEST_PREENCH    = pCD_QUEST_PREENCH
      AND   CD_PERGUNTA = pCD_PERGUNTA
      AND   CD_RESPOSTA = pCD_RESPOSTA;
      
      if vResult > 0 then
         DELETE FROM APPP_TB_RESP_QUEST_PREENCH
         WHERE CD_QUEST_PREENCH    = pCD_QUEST_PREENCH
         AND   CD_PERGUNTA = pCD_PERGUNTA
         AND   CD_RESPOSTA = pCD_RESPOSTA;         
         commit;         
      end if;   
      
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- Não existe dado a ser deletado. 
        
     WHEN OTHERS THEN
         DECLARE
             error_code NUMBER := SQLCODE;
         BEGIN
             IF error_code = -2292 THEN
                ROLLBACK;
                vResult := -2292; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := SQLCODE; -- Erro generico.
                 vERRO   := SUBSTR(SQLERRM,600);
             END IF;
         END;    
               
end APPP_DEL_RESP_QUEST_PREENCH;
/
