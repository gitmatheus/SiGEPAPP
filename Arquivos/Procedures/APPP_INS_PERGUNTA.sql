/******************************************************************************
* Project Name     : SiGEPAPP
* APPP_INS_PERGUNTA : Procedure para cria��o de dados de PERGUNTAS
*                    vResult( 1=OK; -99=ErroGeral)                     
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gon�alves
*******************************************************************************/
create or replace procedure APPP_INS_PERGUNTA(pCD_PERGUNTA OUT NUMBER,
                                              pDS_PERGUNTA IN VARCHAR2,
                                              vResult     out number) is
begin
    
   insert into APPP_TB_PERGUNTA(CD_PERGUNTA ,
                                DS_PERGUNTA 
                               )
                        values( pCD_PERGUNTA ,
                                pDS_PERGUNTA
                              );
  
   select APPP_SEQ_PERGUNTA.CURRVAL
   into pCD_PERGUNTA
   from dual;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_PERGUNTA;
