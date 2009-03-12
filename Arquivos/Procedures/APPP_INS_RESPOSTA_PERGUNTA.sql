/**************************************************************************************
* Project Name               : SiGEPAPP
* APPP_INS_RESPOSTA_PERGUNTA : Procedure para criação de dados de RESPOSTA x PERGUNTAS
*                              vResult( 1=OK; -99=ErroGeral)                     
* Author                     : WeeDo 
* History                    : 06/03/2009 - Matheus Gonçalves
***************************************************************************************/
create or replace procedure APPP_INS_RESPOSTA_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                                       pCD_RESPOSTA IN NUMBER,
                                                       vResult     out number) is
vERRO        VARCHAR2(600);
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
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_RESPOSTA_PERGUNTA;
/