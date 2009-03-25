/*****************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_DEL_RELAC_QUEST_OBJ : Procedure para DELETAR dados de RELAC_QUEST_OBJ
*                            vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 24/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_RELAC_QUEST_OBJ(pCD_QUEST_PREENCH  in number,
                                                     pCD_QUEST          in number,
                                                     pCD_OBJETO         in number,         
                                                     pCD_USER           in NUMBER,
                                                     vResult           out number) is
                                                  
  CURSOR C IS 
       SELECT CD_QUEST_PREENCH
       FROM APPP_TB_RELAC_QUEST_OBJ
       WHERE (CD_USER   = pCD_USER   OR pCD_USER   IS NULL)
       AND   (CD_QUEST  = pCD_QUEST  OR pCD_QUEST  IS NULL)
       AND   (CD_OBJETO = pCD_OBJETO OR pCD_OBJETO IS NULL);
       
       
  vCD_TEMP NUMBER(20);
  vERRO    VARCHAR2(600);   
begin
    
   if pCD_QUEST_PREENCH is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_RELAC_QUEST_OBJ 
      WHERE CD_QUEST_PREENCH  = pCD_QUEST_PREENCH;
      
      if vResult > 0 then

          DELETE APPP_TB_RELAC_QUEST_OBJ 
          WHERE CD_QUEST_PREENCH  = pCD_QUEST_PREENCH;

         commit;
         
      end if;   
      
   else 
       
       vResult := 0;
       OPEN C;
       --Se não foi informado o código, 
       --Ele busca dados a serem apagados conforme os parâmetros.
       --Com os códigos em mão é só fazer a exclusão dos dados.
       LOOP 
          FETCH C INTO vCD_TEMP;
          EXIT WHEN C%NOTFOUND;
          vResult := vResult + 1;
         
         DELETE FROM APPP_TB_RELAC_QUEST_OBJ
         WHERE CD_QUEST_PREENCH  = pCD_QUEST_PREENCH;          
         
       END LOOP; 
       CLOSE C;  

       if vResult > 0 then
          commit;
       end if;   
       
   end if;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- Não existe dado a ser deletado. 
        
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_DEL_RELAC_QUEST_OBJ;
/
