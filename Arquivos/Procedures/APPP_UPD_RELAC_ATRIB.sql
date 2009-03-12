/*************************************************************************
* Project Name  : SiGEPAPP
* APPP_UPD_TIPO : Procedure para ATUALIZAÇÃO de dados de relacionamentos
*                 vResult( 1=OK; -99=ErroGeral)
* Author        : WeeDo 
* History       : 02/03/2009 - Matheus Gonçalves
***************************************************************************/
create or replace procedure APPP_UPD_RELAC_ATRIB(pCD_RELAC    in NUMBER,
                                                 pCD_ATRIBUTO in NUMBER,
                                                 pVL_RELAC    in VARCHAR2,
                                                 vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pCD_ATRIBUTO IS NOT NULL THEN
      UPDATE APPP_TB_RELAC_ATRIB 
      SET CD_ATRIBUTO = pCD_ATRIBUTO
      WHERE CD_RELAC = pCD_RELAC;
   END IF;  
   
  IF pVL_RELAC IS NOT NULL THEN
      UPDATE APPP_TB_RELAC_ATRIB 
      SET VL_RELAC = pVL_RELAC
      WHERE CD_RELAC = pCD_RELAC;
   END IF;
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_RELAC_ATRIB;
/