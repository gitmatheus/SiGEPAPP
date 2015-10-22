/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_DEL_ESTRUT_QUEST : Procedure para DELETAR dados de ESTRUT_QUEST
*                         vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_ESTRUT_QUEST(pCD_QUEST    NUMBER,
                                                  pCD_PERGUNTA NUMBER,                                                  
                                                  vResult     out number) is
vERRO        VARCHAR2(600);                                                  
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_ESTRUT_QUEST
      WHERE CD_QUEST    = pCD_QUEST
      AND   CD_PERGUNTA = pCD_PERGUNTA;
      
      if vResult > 0 then
         DELETE FROM APPP_TB_ESTRUT_QUEST
         WHERE CD_QUEST    = pCD_QUEST
         AND   CD_PERGUNTA = pCD_PERGUNTA;
                  
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
               
end APPP_DEL_ESTRUT_QUEST;
/
