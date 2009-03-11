/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_UPD_USER_TELEFONE : Procedure para cria��o de dados de USER_TELEFONES
*                          vResult( 1=OK; -99=ErroGeral)
*                          DEVE-SE PASSAR O CD_USER + TP_TELEFONE
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_USER_TELEFONE(pCD_USER     IN NUMBER  ,
                                                   pNR_DDI      IN NUMBER  ,
                                                   pNR_DDD      IN NUMBER  ,
                                                   pNR_TELEFONE IN NUMBER  ,
                                                   pTP_TELEFONE IN VARCHAR2,
                                                   vResult   out number) is
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
        vResult := -99; -- Erro gen�rico.
               
end APPP_UPD_USER_TELEFONE;
/