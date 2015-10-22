/**********************************************************************************************************************
* Project Name        : SiGEPAPP
* APPP_UPD_USER_EMAIL : Procedure para cria��o de dados de USER_EMAILS
*                       vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_USER_EMAIL(pCD_USER  IN NUMBER  ,
                                                pNM_EMAIL IN VARCHAR2,
                                                pTP_EMAIL IN VARCHAR2,
                                                vResult   out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pNM_EMAIL IS NOT NULL THEN
      UPDATE APPP_TB_USER_EMAIL 
      SET NM_EMAIL = pNM_EMAIL
      WHERE CD_USER = pCD_USER;
   END IF;  
   
   IF pTP_EMAIL IS NOT NULL THEN
      UPDATE APPP_TB_USER_EMAIL 
      SET TP_EMAIL = pTP_EMAIL
      WHERE CD_USER = pCD_USER;
   END IF;     
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_USER_EMAIL;
/