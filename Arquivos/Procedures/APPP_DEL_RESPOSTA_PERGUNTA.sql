/**********************************************************************************************************************
* Project Name               : SiGEPAPP
* APPP_DEL_RESPOSTA_PERGUNTA : Procedure para DELETAR dados de RESPOSTA X PERGUNTAS
*                              vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                     : WeeDo 
* History                    : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_RESPOSTA_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                                        vResult     out number) is
                                                  
      
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_RESPOSTA_PERGUNTA
      WHERE CD_PERGUNTA = pCD_PERGUNTA;
     
      
      if vResult > 0 then

         DELETE FROM APPP_TB_RESPOSTA_PERGUNTA
         WHERE CD_PERGUNTA = pCD_PERGUNTA;
         
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
                vResult := -99; -- Erro genérico.             
             END IF;
         END;    
               
end APPP_DEL_RESPOSTA_PERGUNTA;
