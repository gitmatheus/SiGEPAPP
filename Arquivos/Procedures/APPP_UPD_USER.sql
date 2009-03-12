/**********************************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_UPD_USER : Procedure para criação de dados de USERS
*                 vResult( 1=OK; -99=ErroGeral)
* Author        : WeeDo 
* History       : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_USER(pCD_USER           IN NUMBER       ,
                                          pNM_PRIM_NOME      IN VARCHAR2     ,
                                          pNM_ULT_NOME       IN VARCHAR2     , 
                                          pDT_NASC           IN DATE         ,
                                          pNR_NOTA           IN NUMBER       ,
                                          --pDT_CADASTRO       IN DATE         , 
                                          pDS_AREA_INTERESSE IN VARCHAR2     ,
                                          pNM_MSN            IN VARCHAR2     ,
                                          pNM_SKYPE          IN VARCHAR2     ,
                                          vResult           out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pNM_PRIM_NOME IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET NM_PRIM_NOME = pNM_PRIM_NOME
      WHERE CD_USER = pCD_USER;
   END IF;   

   IF pNM_ULT_NOME IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET NM_PRIM_NOME = pNM_ULT_NOME
      WHERE CD_USER = pCD_USER;
   END IF;    
 
   IF pDT_NASC IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET DT_NASC = pDT_NASC
      WHERE CD_USER = pCD_USER;
   END IF;  
   
   IF pNR_NOTA IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET NR_NOTA = pNR_NOTA
      WHERE CD_USER = pCD_USER;
   END IF;   
   
   IF pDS_AREA_INTERESSE IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET DS_AREA_INTERESSE = pDS_AREA_INTERESSE
      WHERE CD_USER = pCD_USER;
   END IF;     
 
   IF pNM_MSN IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET NM_MSN = pNM_MSN
      WHERE CD_USER = pCD_USER;
   END IF;  

   IF pNM_SKYPE IS NOT NULL THEN
      UPDATE APPP_TB_USER
      SET NM_SKYPE = pNM_SKYPE
      WHERE CD_USER = pCD_USER;
   END IF;  
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_USER;
/