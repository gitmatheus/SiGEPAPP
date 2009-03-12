/******************************************************************************
* Project Name            : SiGEPAPP
* APPP_INS_PERGUNTA_QUEST : Procedure para criação de dados de PERGUNTA_QUEST
*                           vResult( 1=OK; -99=ErroGeral)                     
* Author                  : WeeDo 
* History                 : 06/03/2009 - Matheus Gonçalves
*******************************************************************************/
create or replace procedure APPP_INS_PERGUNTA_QUEST(pCD_QUEST    IN NUMBER,
                                                    pCD_PERGUNTA IN NUMBER,
                                                    pCD_RESPOSTA IN NUMBER,
                                                    vResult     out number) is
vERRO        VARCHAR2(600);
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
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_PERGUNTA_QUEST;
/