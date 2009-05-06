/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_DEL_AVAL_OBJ_USER : Procedure para DELETAR dados de AVAL_OBJ_USER
*                         vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 06/05/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_AVAL_OBJ_USER(pCD_USER   NUMBER,
                                                   pCD_OBJETO NUMBER,                                                  
                                                   vResult     out number) is
vERRO        VARCHAR2(600);                                                  
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_AVAL_OBJ_USER
      WHERE CD_USER    = pCD_USER
      AND   CD_OBJETO = pCD_OBJETO;
      
      if vResult > 0 then
         DELETE FROM APPP_TB_AVAL_OBJ_USER
         WHERE CD_USER    = pCD_USER
         AND   CD_OBJETO = pCD_OBJETO;
                  
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
               
end APPP_DEL_AVAL_OBJ_USER;
/
