/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_DEL_RELAC_PERG_RESP : Procedure para DELETAR dados de RESPOSTA X PERGUNTAS
*                            vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_RELAC_PERG_RESP(pCD_PERGUNTA IN NUMBER,
                                                     pCD_RESPOSTA IN NUMBER,
                                                     vResult     out number) is
                                                  
      
vERRO        VARCHAR2(600);
begin
    
      IF  pCD_PERGUNTA IS NOT NULL AND pCD_RESPOSTA IS NOT NULL THEN
      
           SELECT COUNT(*) INTO vResult
           FROM APPP_TB_RELAC_PERG_RESP
           WHERE CD_PERGUNTA = pCD_PERGUNTA
           AND   CD_RESPOSTA = pCD_RESPOSTA ;
             
           if vResult > 0 then
   
              DELETE FROM APPP_TB_RELAC_PERG_RESP
              WHERE CD_PERGUNTA = pCD_PERGUNTA
              AND   CD_RESPOSTA = pCD_RESPOSTA ;
              commit;
              
          end if;   
        
      ELSIF pCD_PERGUNTA IS NOT NULL THEN
           
           SELECT COUNT(*) INTO vResult
           FROM APPP_TB_RELAC_PERG_RESP
           WHERE CD_PERGUNTA = pCD_PERGUNTA;
             
           if vResult > 0 then
   
              DELETE FROM APPP_TB_RELAC_PERG_RESP
              WHERE CD_PERGUNTA = pCD_PERGUNTA;
              commit;
              
          end if;  
          
      ELSIF pCD_RESPOSTA IS NOT NULL THEN
          
           SELECT COUNT(*) INTO vResult
           FROM APPP_TB_RELAC_PERG_RESP
           WHERE CD_RESPOSTA = pCD_RESPOSTA;
             
           if vResult > 0 then
   
              DELETE FROM APPP_TB_RELAC_PERG_RESP
              WHERE CD_RESPOSTA = pCD_RESPOSTA;
              commit;
              
          end if;      
      
      END IF; 
      
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
               
end APPP_DEL_RELAC_PERG_RESP;
/
