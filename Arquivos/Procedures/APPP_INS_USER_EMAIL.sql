/**********************************************************************************************************************
* Project Name        : SiGEPAPP
* APPP_INS_USER_EMAIL : Procedure para cria��o de dados de EMAILS DE USU�RIOS
*                       vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_INS_USER_EMAIL(pCD_USER  IN NUMBER,
                                                pNM_EMAIL IN VARCHAR2,
                                                pTP_EMAIL IN VARCHAR2,
                                                vResult out number) is
begin
    
   insert into APPP_TB_USER_EMAIL(CD_USER  ,
                                  NM_EMAIL ,
                                  TP_EMAIL 
                                 )
                           values(pCD_USER  ,
                                  pNM_EMAIL ,
                                  pTP_EMAIL
                                 );
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_USER_EMAIL;
/