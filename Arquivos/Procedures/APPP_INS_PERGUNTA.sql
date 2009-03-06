/******************************************************************************
* Project Name     : SiGEPAPP
* APPP_INS_PERGUNTA : Procedure para criação de dados de PERGUNTAS
*                    vResult( 1=OK; -99=ErroGeral)                     
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gonçalves
*******************************************************************************/
create or replace procedure APPP_INS_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                              pDS_PERGUNTA IN VARCHAR2,
                                              vResult     out number) is
begin
    
   insert into APPP_TB_PERGUNTA(CD_PERGUNTA ,
                                DS_PERGUNTA 
                               )
                        values( pCD_PERGUNTA ,
                                pDS_PERGUNTA
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_PERGUNTA;
