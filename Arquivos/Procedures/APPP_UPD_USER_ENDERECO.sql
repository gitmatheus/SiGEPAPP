/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_UPD_USER_ENDERECO : Procedure para criação de dados de USER_ENDERECOS
*                          vResult( 1=OK; -99=ErroGeral)
*                          DEVE-SE PASSAR O CD_USER + TP_ENDERECO
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_USER_ENDERECO(pCD_USER        IN NUMBER  ,
                                                   pNR_CEP         IN NUMBER  ,
                                                   pNR_NUMERO      IN NUMBER  ,
                                                   pDS_COMPLEMENTO IN VARCHAR2,
                                                   pTP_ENDERECO    IN VARCHAR2,
                                                   vResult   out number) is
begin
    
   IF pNR_CEP IS NOT NULL THEN
      UPDATE APPP_TB_USER_ENDERECO 
      SET NR_CEP = pNR_CEP
      WHERE CD_USER     = pCD_USER
      AND   TP_ENDERECO = pTP_ENDERECO;
   END IF;  
   
   IF pNR_NUMERO IS NOT NULL THEN
      UPDATE APPP_TB_USER_ENDERECO 
      SET NR_NUMERO = pNR_NUMERO
      WHERE CD_USER     = pCD_USER
      AND   TP_ENDERECO = pTP_ENDERECO;
   END IF;     

   IF pDS_COMPLEMENTO IS NOT NULL THEN
      UPDATE APPP_TB_USER_ENDERECO 
      SET DS_COMPLEMENTO = pDS_COMPLEMENTO
      WHERE CD_USER     = pCD_USER
      AND   TP_ENDERECO = pTP_ENDERECO;
   END IF;     
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_USER_ENDERECO;
