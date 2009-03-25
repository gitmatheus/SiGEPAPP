/******************************************************************************
* Project Name          : SiGEPAPP
* APPP_INS_ESTRUT_QUEST : Procedure para criação de dados de ESTRUT_QUEST
*                         vResult( 1=OK; -99=ErroGeral)                     
* Author                : WeeDo 
* History               : 24/03/2009 - Matheus Gonçalves
*******************************************************************************/
create or replace procedure APPP_INS_ESTRUT_QUEST(pCD_QUEST    IN NUMBER,
                                                  pCD_PERGUNTA IN NUMBER,
                                                  pNR_ORDEM    IN NUMBER,
                                                  vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_ESTRUT_QUEST(CD_QUEST    ,
                                      CD_PERGUNTA ,
                                      NR_ORDEM 
                                     )
                              values( pCD_QUEST    ,
                                      pCD_PERGUNTA ,
                                      pNR_ORDEM 
                                    );  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_ESTRUT_QUEST;
/
