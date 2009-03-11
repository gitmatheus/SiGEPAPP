/****************************************************************************************
* Project Name  : SiGEPAPP
* APPP_UPD_TIPO : Procedure para ATUALIZAÇÃO de dados de tipos
*                 vResult( 1=OK; -99=ErroGeral)
* Author        : WeeDo 
* History       : 02/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_TIPO(pCD_TIPO    IN NUMBER  ,
                                          pNM_TIPO    IN VARCHAR2,
                                          pDS_TIPO    IN VARCHAR2,
                                          pFL_EXP_REG IN VARCHAR2,
                                          vResult     out number) is
begin
    
   IF pNM_TIPO IS NOT NULL THEN
      UPDATE APPP_TB_TIPO 
      SET NM_TIPO = pNM_TIPO
      WHERE CD_TIPO = pCD_TIPO;
   END IF;  
   
   IF pDS_TIPO IS NOT NULL THEN
      UPDATE APPP_TB_TIPO 
      SET DS_TIPO = pDS_TIPO
      WHERE CD_TIPO = pCD_TIPO;
   END IF;
   
   IF pFL_EXP_REG IS NOT NULL THEN
      UPDATE APPP_TB_TIPO 
      SET FL_EXP_REG = pFL_EXP_REG
      WHERE CD_TIPO = pCD_TIPO;
   END IF;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_TIPO;
/