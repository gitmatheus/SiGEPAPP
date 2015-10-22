/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_UPD_PERSONA : Procedure para cria��o de dados de PERSONAS
*                    vResult( 1=OK; -99=ErroGeral)
* Author           : WeeDo 
* History          : 06/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_UPD_PERSONA(pCD_PERSONA NUMBER  ,
                                             pURL_FOTO   VARCHAR2,
                                             vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
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
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_PERSONA;
/
