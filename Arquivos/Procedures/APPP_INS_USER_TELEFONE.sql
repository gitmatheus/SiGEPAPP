/**************************************************************************************
* Project Name           : SiGEPAPP
* APPP_INS_USER_TELEFONE : Procedure para criação de dados de TELEFONES DE USUÁRIOS
*                          vResult( 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gonçalves
***************************************************************************************/
create or replace procedure APPP_INS_USER_TELEFONE(pCD_USER    IN NUMBER  ,
                                                   pNR_DDI      IN NUMBER  ,
                                                   pNR_DDD      IN NUMBER  ,
                                                   pNR_TELEFONE IN NUMBER  ,
                                                   pTP_TELEFONE IN VARCHAR2,
                                                   vResult out number) is
begin
    
   insert into APPP_TB_USER_TELEFONE(CD_USER    ,
                                     NR_DDI     ,
                                     NR_DDD     ,
                                     NR_TELEFONE,
                                     TP_TELEFONE
                                    )
                             values( pCD_USER    ,
                                     pNR_DDI     ,
                                     pNR_DDD     ,
                                     pNR_TELEFONE,
                                     pTP_TELEFONE
                                   );
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_USER_TELEFONE;
