/****************************************************************************************
* Project Name   : SiGEPAPP
* APPP_UPD_LOGIN : Procedure para ATUALIZAÇÃO de dados de LOGINS
*                  vResult( 1=OK; -99=ErroGeral)
* Author         : WeeDo 
* History        : 04/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_LOGIN(pCD_USER  in NUMBER, 
                                           pNM_LOGIN in VARCHAR2, 
                                           pPW_SENHA in VARCHAR2,
                                           vResult   out number) is
begin
    
   IF pNM_LOGIN IS NOT NULL THEN
      UPDATE APPP_TB_LOGIN 
      SET NM_LOGIN = pNM_LOGIN
      WHERE CD_USER = pCD_USER;
   END IF;  
   
    IF pPW_SENHA IS NOT NULL THEN
      UPDATE APPP_TB_LOGIN 
      SET PW_SENHA = pPW_SENHA
      WHERE CD_USER = pCD_USER;
   END IF;  
  
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_LOGIN;
