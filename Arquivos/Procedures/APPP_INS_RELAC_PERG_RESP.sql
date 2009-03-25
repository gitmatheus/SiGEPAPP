/**************************************************************************************
* Project Name             : SiGEPAPP
* APPP_INS_RELAC_PERG_RESP : Procedure para cria��o de dados de RESPOSTA x PERGUNTAS
*                            vResult( 1=OK; -99=ErroGeral)                     
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Gon�alves
***************************************************************************************/
create or replace procedure APPP_INS_RELAC_PERG_RESP(pCD_PERGUNTA   IN NUMBER,
                                                     pCD_RESPOSTA   IN NUMBER,
                                                     pNR_VALOR_RESP IN NUMBER,
                                                     vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_RELAC_PERG_RESP(CD_PERGUNTA ,
                                       CD_RESPOSTA,
                                       NR_VALOR_RESP   
                                        )
                                 values( pCD_PERGUNTA ,
                                         pCD_RESPOSTA ,
                                         pNR_VALOR_RESP 
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_RELAC_PERG_RESP;
/
