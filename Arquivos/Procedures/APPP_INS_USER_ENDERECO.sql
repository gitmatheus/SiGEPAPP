/**************************************************************************************
* Project Name           : SiGEPAPP
* APPP_INS_USER_ENDERECO : Procedure para criação de dados de ENDERECOS DE USUÁRIOS
*                          vResult( 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gonçalves
***************************************************************************************/
create or replace procedure APPP_INS_USER_ENDERECO(pCD_USER        IN NUMBER  ,
                                                   pNR_CEP         IN NUMBER  ,
                                                   pNR_NUMERO      IN NUMBER  ,
                                                   pDS_COMPLEMENTO IN VARCHAR2,
                                                   pTP_ENDERECO    IN VARCHAR2,
                                                   vResult out number) is
begin
    
   insert into APPP_TB_USER_ENDERECO(CD_USER        ,
                                     NR_CEP         ,
                                     NR_NUMERO      ,
                                     DS_COMPLEMENTO ,
                                     TP_ENDERECO 
                                    )
                             values( pCD_USER        ,
                                     pNR_CEP         ,
                                     pNR_NUMERO      ,
                                     pDS_COMPLEMENTO ,
                                     pTP_ENDERECO 
                                   );
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_USER_ENDERECO;
