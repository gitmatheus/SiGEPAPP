/******************************************************************************
* Project Name      : SiGEPAPP
* APPP_INS_RESPOSTA : Procedure para criação de dados de RESPOSTAS
*                    vResult( 1=OK; -99=ErroGeral)                     
* Author            : WeeDo 
* History           : 04/03/2009 - Matheus Gonçalves
*******************************************************************************/
create or replace procedure APPP_INS_RESPOSTA(pCD_RESPOSTA OUT NUMBER  ,
                                              pDS_RESPOSTA IN VARCHAR2,                                              
                                              vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_RESPOSTA(CD_RESPOSTA     ,
                                DS_RESPOSTA    
                               )
                        values( pCD_RESPOSTA     ,
                                pDS_RESPOSTA     
                              );
  
   select APPP_SEQ_RESPOSTA.CURRVAL
   into pCD_RESPOSTA
   from dual;  
   

   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_RESPOSTA;
/
