/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_UPD_PERSONA : Procedure para criação de dados de PERSONAS
*                    vResult( 1=OK; -99=ErroGeral)
* Author           : WeeDo 
* History          : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_PERSONA(pCD_PERSONA NUMBER  ,
                                             pNM_PERSONA VARCHAR2,
                                             pURL_FOTO   VARCHAR2,
                                             vResult     out number) is
begin
    
   IF pNM_PERSONA IS NOT NULL THEN
      UPDATE APPP_TB_PERSONA 
      SET NM_PERSONA = pNM_PERSONA
      WHERE CD_PERSONA = pCD_PERSONA;
   END IF;   
   
   IF pURL_FOTO IS NOT NULL THEN
      UPDATE APPP_TB_PERSONA 
      SET URL_FOTO = pURL_FOTO
      WHERE CD_PERSONA = pCD_PERSONA;
   END IF;
     
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_PERSONA;
/