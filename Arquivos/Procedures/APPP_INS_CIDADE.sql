/**********************************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_INS_CIDADE : Procedure para cria��o de dados de CIDADES
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 03/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_INS_CIDADE(pCD_CIDADE IN OUT NUMBER,
                                            pNM_CIDADE IN VARCHAR2,
                                            pNM_ABREV  IN VARCHAR2,
                                            pCD_ESTADO IN NUMBER , 
                                            vResult    out number) is
begin
   
   insert into APPP_TB_CIDADE( CD_CIDADE,
                               NM_CIDADE, 
                               NM_ABREV,
                               CD_ESTADO
                             )
                       values( pCD_CIDADE,
                               pNM_CIDADE, 
                               pNM_ABREV,
                               pCD_ESTADO 
                             );
                             
   select APPP_SEQ_CIDADE.CURRVAL
   into pCD_CIDADE
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_CIDADE;
