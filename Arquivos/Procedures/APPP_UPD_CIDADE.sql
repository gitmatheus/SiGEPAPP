/****************************************************************************************
* Project Name    : SiGEPAPP
* APPP_UPD_CIDADE : Procedure para ATUALIZAÇÃO de dados de CIDADEs
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 03/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_CIDADE(pCD_CIDADE IN NUMBER,
                                            pNM_CIDADE IN VARCHAR2,
                                            pNM_ABREV  IN VARCHAR2,
                                            pCD_ESTADO IN NUMBER,
                                            vResult     out number) is
begin
    
   IF pNM_CIDADE IS NOT NULL THEN
      UPDATE APPP_TB_CIDADE 
      SET NM_CIDADE = pNM_CIDADE
      WHERE CD_CIDADE = pCD_CIDADE;
   END IF;  
   
    IF pNM_ABREV IS NOT NULL THEN
      UPDATE APPP_TB_CIDADE 
      SET NM_ABREV = pNM_ABREV
      WHERE CD_CIDADE = pCD_CIDADE;
   END IF;  
   
   IF pCD_ESTADO IS NOT NULL THEN
      UPDATE APPP_TB_CIDADE 
      SET CD_ESTADO = pCD_ESTADO
      WHERE CD_CIDADE = pCD_CIDADE;
   END IF;    
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_CIDADE;
/