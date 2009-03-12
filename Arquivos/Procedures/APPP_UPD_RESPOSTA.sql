/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_UPD_RESPOSTA : Procedure para criação de dados de RESPOSTAS
*                     vResult( 1=OK; -99=ErroGeral)
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_RESPOSTA(pCD_RESPOSTA IN NUMBER  ,
                                              pDS_RESPOSTA IN VARCHAR2 ,
                                              pNR_PESO_RESPOSTA NUMBER , 
                                              vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pDS_RESPOSTA IS NOT NULL THEN
      UPDATE APPP_TB_RESPOSTA 
      SET DS_RESPOSTA = pDS_RESPOSTA
      WHERE CD_RESPOSTA = pCD_RESPOSTA;
   END IF;   

   IF pNR_PESO_RESPOSTA IS NOT NULL THEN
      UPDATE APPP_TB_RESPOSTA 
      SET NR_PESO_RESPOSTA = pNR_PESO_RESPOSTA
      WHERE CD_RESPOSTA = pCD_RESPOSTA;
   END IF; 
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_RESPOSTA;
/