/****************************************************************************************
* Project Name    : SiGEPAPP
* APPP_UPD_OBJETO : Procedure para ATUALIZA��O de dados de OBJETOS
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gon�alves
******************************************************************************************/
create or replace procedure APPP_UPD_OBJETO(pCD_OBJETO       IN NUMBER ,
                                            pNM_OBJETO       IN VARCHAR2,
                                            pCD_ESTRUTURA    IN NUMBER  ,
                                            pDS_OBJETO       IN VARCHAR2,
                                            --CAMPOS N�O ATUALIZ�VEIS
                                            --pDT_CRIACAO      IN DATE  , 
                                            --pCD_USER_CRIADOR IN NUMBER,
                                            vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pNM_OBJETO IS NOT NULL THEN
      UPDATE APPP_TB_OBJETO 
      SET NM_OBJETO = pNM_OBJETO
      WHERE CD_OBJETO = pCD_OBJETO;
   END IF;  
   
    IF pCD_ESTRUTURA IS NOT NULL THEN
      UPDATE APPP_TB_OBJETO 
      SET CD_ESTRUTURA = pCD_ESTRUTURA
      WHERE CD_OBJETO = pCD_OBJETO;
   END IF;  
  
   IF pDS_OBJETO IS NOT NULL THEN
      UPDATE APPP_TB_OBJETO 
      SET DS_OBJETO = pDS_OBJETO
      WHERE CD_OBJETO = pCD_OBJETO;
   END IF; 
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_OBJETO;
/