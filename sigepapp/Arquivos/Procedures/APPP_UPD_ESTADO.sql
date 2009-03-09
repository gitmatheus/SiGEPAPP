/****************************************************************************************
* Project Name    : SiGEPAPP
* APPP_UPD_ESTADO : Procedure para ATUALIZAÇÃO de dados de ESTADOS
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_ESTADO(pCD_ESTADO IN NUMBER  ,
                                            pNM_ESTADO IN VARCHAR2,
                                            pSG_SIGLA  VARCHAR2   ,
                                            vResult     out number) is
begin
    
   IF pNM_ESTADO IS NOT NULL THEN
      UPDATE APPP_TB_ESTADO 
      SET NM_ESTADO = pNM_ESTADO
      WHERE CD_ESTADO = pCD_ESTADO;
   END IF;  
   
    IF pSG_SIGLA IS NOT NULL THEN
      UPDATE APPP_TB_ESTADO 
      SET SG_SIGLA = pSG_SIGLA
      WHERE CD_ESTADO = pCD_ESTADO;
   END IF;  
  
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_ESTADO;
