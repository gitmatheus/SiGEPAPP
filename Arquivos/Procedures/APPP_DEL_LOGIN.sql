/*****************************************************************************************************
* Project Name   : SiGEPAPP
* APPP_DEL_LOGIN : Procedure para DELETAR dados de LOGINS
*                  vResult( 0=NadaDeletado; 
*                           xx=OK (Quantidade de registros apagados); 
*                           -99=ErroGeral; 
*                           -90=Existem Registros Filhos;
*                          )
* Author         : WeeDo 
* History        : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_LOGIN(pCD_USER  IN NUMBER,
                                           vResult   out number) is
                                                  
 begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_LOGIN
      WHERE CD_USER  = pCD_USER;

      if vResult > 0 then

         DELETE FROM APPP_TB_LOGIN
         WHERE CD_USER  = pCD_USER;

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
                vResult := -90; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := -99; -- Erro genérico.             
             END IF;
         END;      
               
end APPP_DEL_LOGIN;
