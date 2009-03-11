/*****************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_DEL_ATRIB_ESTRUTURA : Procedure para DELETAR dados de ATRIBUTOS X ESTRUTURAS
*                            vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Gon�alves
******************************************************************************************************/
create or replace procedure APPP_DEL_ATRIB_ESTRUTURA(pCD_ESTRUTURA    IN NUMBER, 
                                                     pCD_ATRIBUTO_OBJ IN NUMBER,
                                                     vResult           out number) is
                                                  
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_ATRIB_ESTRUTURA
      WHERE CD_ESTRUTURA  = pCD_ESTRUTURA
      AND CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_ATRIB_ESTRUTURA
         WHERE CD_ESTRUTURA  = pCD_ESTRUTURA
         AND CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;

         commit;
         
      end if;   
      
  
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- N�o existe dado a ser deletado. 
        
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_DEL_ATRIB_ESTRUTURA;

/
