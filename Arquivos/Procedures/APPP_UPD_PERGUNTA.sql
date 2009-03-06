/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_UPD_PERGUNTA : Procedure para criação de dados de PERGUNTAS
*                     vResult( 1=OK; -99=ErroGeral)
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_PERGUNTA(pCD_PERGUNTA NUMBER,
                                              pDS_PERGUNTA VARCHAR2,
                                              vResult     out number) is
begin
    
   IF pDS_PERGUNTA IS NOT NULL THEN
      UPDATE APPP_TB_PERGUNTA 
      SET DS_PERGUNTA = pDS_PERGUNTA
      WHERE CD_PERGUNTA = pCD_PERGUNTA;
   END IF;   
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_PERGUNTA;
