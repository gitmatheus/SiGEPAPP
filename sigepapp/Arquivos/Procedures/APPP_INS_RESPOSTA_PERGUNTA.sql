/**************************************************************************************
* Project Name               : SiGEPAPP
* APPP_INS_RESPOSTA_PERGUNTA : Procedure para cria��o de dados de RESPOSTA x PERGUNTAS
*                              vResult( 1=OK; -99=ErroGeral)                     
* Author                     : WeeDo 
* History                    : 06/03/2009 - Matheus Gon�alves
***************************************************************************************/
create or replace procedure APPP_INS_RESPOSTA_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                                       pCD_RESPOSTA IN NUMBER,
                                                       vResult     out number) is
begin
    
   insert into APPP_TB_RESPOSTA_PERGUNTA(CD_PERGUNTA ,
                                         CD_RESPOSTA 
                                        )
                                 values( pCD_PERGUNTA ,
                                         pCD_RESPOSTA
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_RESPOSTA_PERGUNTA;
