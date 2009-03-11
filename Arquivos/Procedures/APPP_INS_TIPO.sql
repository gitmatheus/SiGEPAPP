/**********************************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_INS_TIPO : Procedure para cria��o de dados de TIPOS
*                         vResult( 1=OK; -99=ErroGeral)
* Author        : WeeDo 
* History       : 02/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_INS_TIPO(pCD_TIPO    IN OUT NUMBER  ,
                                          pNM_TIPO    IN VARCHAR2,
                                          pDS_TIPO    IN VARCHAR2,
                                          pFL_EXP_REG IN VARCHAR2,
                                          vResult     out number) is
begin
   
   insert into APPP_TB_TIPO( CD_TIPO    ,
                             NM_TIPO    ,
                             DS_TIPO    ,
                             FL_EXP_REG 
                            )
                     values( pCD_TIPO    ,
                             pNM_TIPO    ,
                             pDS_TIPO    ,
                             pFL_EXP_REG
                           );
   SELECT APPP_SEQ_TIPO.CURRVAL
   INTO pCD_TIPO
   FROM DUAL;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_TIPO;
/