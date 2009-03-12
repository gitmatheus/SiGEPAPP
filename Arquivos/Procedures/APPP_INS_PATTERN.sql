/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_INS_PATTERN : Procedure para criação de dados de PATTERNS
*                    vResult( 1=OK; -99=ErroGeral)
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_PATTERN(pCD_PATTERN      in NUMBER  , 
                                             pDS_PAT_PROBLEMA IN VARCHAR2,
                                             pDS_PAT_SOLUCAO  in VARCHAR2,
                                             vResult           out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_PATTERN(CD_PATTERN      ,
                               DS_PAT_PROBLEMA ,
                               DS_PAT_SOLUCAO
                              )
                        values(pCD_PATTERN     ,
                               pDS_PAT_PROBLEMA,
                               pDS_PAT_SOLUCAO
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_PATTERN;
/