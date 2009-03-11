/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_INS_TB_LOGIN : Procedure para criação de dados de login
*                     vResult( 1=OK; -99=ErroGeral)
* Author            : WeeDo 
* History           : 27/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_LOGIN(pCD_USER  in NUMBER, 
                                           pNM_LOGIN in VARCHAR2, 
                                           pPW_SENHA in VARCHAR2, 
                                           vResult   out number) is
begin
    
   insert into APPP_TB_LOGIN(cd_user,NM_LOGIN,PW_SENHA)
               values(pcd_user,pNM_LOGIN,pPW_SENHA);
   
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_LOGIN;
/