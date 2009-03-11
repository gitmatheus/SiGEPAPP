/**********************************************************************************************************************
* Project Name        : SiGEPAPP
* APPP_DEL_USER_EMAIL : Procedure para DELETAR dados de EMAIL DE USUÁRIOS
*                       vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_USER_EMAIL(pCD_USER  IN NUMBER  ,
                                                pNM_EMAIL IN VARCHAR2,
                                                pTP_EMAIL IN VARCHAR2,
                                                vResult   out number) is
                                                  
     
begin
  
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_USER_EMAIL
      WHERE CD_USER  = pCD_USER
      AND   (NM_EMAIL like ('%'|| pNM_EMAIL || '%') OR pNM_EMAIL IS NULL)
      AND   (TP_EMAIL like ('%'|| pTP_EMAIL || '%') OR pTP_EMAIL IS NULL);
      
      
      if vResult > 0 then
         DELETE FROM APPP_TB_USER_EMAIL
         WHERE CD_USER  = pCD_USER
         AND   (NM_EMAIL like ('%'|| pNM_EMAIL || '%') OR pNM_EMAIL IS NULL)
         AND   (TP_EMAIL like ('%'|| pTP_EMAIL || '%') OR pTP_EMAIL IS NULL);        
       
        commit;
      end if;   
      
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- Não existe dado a ser deletado. 
        
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_DEL_USER_EMAIL;
/