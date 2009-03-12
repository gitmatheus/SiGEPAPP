/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_UPD_USER_TELEFONE : Procedure para criação de dados de USER_TELEFONES
*                          vResult( 1=OK; -99=ErroGeral)
*                          DEVE-SE PASSAR O CD_USER + TP_TELEFONE
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_USER_TELEFONE(pCD_USER     IN NUMBER  ,
                                                   pNR_DDI      IN NUMBER  ,
                                                   pNR_DDD      IN NUMBER  ,
                                                   pNR_TELEFONE IN NUMBER  ,
                                                   pTP_TELEFONE IN VARCHAR2,
                                                   vResult   out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pNR_DDI IS NOT NULL THEN
      UPDATE APPP_TB_USER_TELEFONE 
      SET NR_DDI = pNR_DDI
      WHERE CD_USER     = pCD_USER
      AND   TP_TELEFONE = pTP_TELEFONE;
   END IF;  
   
   IF pNR_DDD IS NOT NULL THEN
      UPDATE APPP_TB_USER_TELEFONE 
      SET NR_DDD = pNR_DDD
      WHERE CD_USER     = pCD_USER
      AND   TP_TELEFONE = pTP_TELEFONE;
   END IF;     

   IF pNR_TELEFONE IS NOT NULL THEN
      UPDATE APPP_TB_USER_TELEFONE 
      SET NR_TELEFONE = pNR_TELEFONE
      WHERE CD_USER     = pCD_USER
      AND   TP_TELEFONE = pTP_TELEFONE;
   END IF;     
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_USER_TELEFONE;
/