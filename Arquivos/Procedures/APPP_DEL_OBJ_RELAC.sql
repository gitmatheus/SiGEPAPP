/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_OBJ_RELAC : Procedure para DELETAR dados de OBJ_RELACS
*                   vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -2292=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_OBJ_RELAC(pCD_OBJETO       IN NUMBER,
                                               pCD_OBJETO_RELAC IN NUMBER,
                                               vResult    out number) is
                                                  
  
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_OBJ_RELAC
      WHERE CD_OBJETO       = pCD_OBJETO 
      AND   CD_OBJETO_RELAC = PCD_OBJETO_RELAC;

      if vResult > 0 then

         DELETE FROM APPP_TB_OBJ_RELAC
         WHERE CD_OBJETO       = pCD_OBJETO 
         AND   CD_OBJETO_RELAC = PCD_OBJETO_RELAC;

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
               
end APPP_DEL_OBJ_RELAC;
/