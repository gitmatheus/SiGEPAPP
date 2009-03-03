/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_INS_CODIGO_POSTAL : Procedure para criação de dados de CODIGO_POSTAL
*                         vResult( 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 03/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_CODIGO_POSTAL(pCD_CEP    IN NUMBER   ,
                                                   pNM_RUA    IN VARCHAR2 ,
                                                   pCD_CIDADE IN NUMBER   ,
                                                   vResult     out number) is
begin
   
   insert into APPP_TB_CODIGO_POSTAL(CD_CEP    ,
                                     NM_RUA    ,
                                     CD_CIDADE 
                                    )
                             values( pCD_CEP    ,
                                     pNM_RUA    ,
                                     pCD_CIDADE
                                   );
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_CODIGO_POSTAL;
