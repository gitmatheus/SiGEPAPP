/******************************************************************************
* Project Name            : SiGEPAPP
* APPP_INS_PERGUNTA_QUEST : Procedure para cria��o de dados de PERGUNTA_QUEST
*                           vResult( 1=OK; -99=ErroGeral)                     
* Author                  : WeeDo 
* History                 : 06/03/2009 - Matheus Gon�alves
*******************************************************************************/
create or replace procedure APPP_INS_PERGUNTA_QUEST(pCD_QUEST    IN NUMBER,
                                                    pCD_PERGUNTA IN NUMBER,
                                                    pCD_RESPOSTA IN NUMBER,
                                                    vResult     out number) is
begin
    
   insert into APPP_TB_PERGUNTA_QUEST(CD_QUEST    ,
                                      CD_PERGUNTA ,
                                      CD_RESPOSTA 
                                     )
                              values( pCD_QUEST    ,
                                      pCD_PERGUNTA ,
                                      pCD_RESPOSTA 
                                    );  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_PERGUNTA_QUEST;
