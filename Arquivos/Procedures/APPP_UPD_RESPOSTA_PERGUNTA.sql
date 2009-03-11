/**********************************************************************************************************************
* Project Name               : SiGEPAPP
* APPP_UPD_RESPOSTA_PERGUNTA : Procedure para criação de dados de RESPOSTA X PERGUNTAS
*                              vResult( 1=OK; -99=ErroGeral)
* Author                     : WeeDo 
* History                    : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_RESPOSTA_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                                       pCD_RESPOSTA IN NUMBER,
                                                       vResult     out number) is
begin
    
   IF pCD_RESPOSTA IS NOT NULL THEN

      UPDATE APPP_TB_RESPOSTA_PERGUNTA 
      SET CD_RESPOSTA = pCD_RESPOSTA
      WHERE CD_PERGUNTA = pCD_PERGUNTA;

      commit;

   END IF;   
   
   vResult := 1; -- OK
   
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_RESPOSTA_PERGUNTA;
/