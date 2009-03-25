/*****************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_DEL_QUEST_PREENCH : Procedure para DELETAR dados de ATRIBUTOS
*                          vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                 : WeeDo 
* History                : 24/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_QUEST_PREENCH(pCD_QUEST_PREENCH         IN NUMBER   ,
                                                  pDT_APLICACAOINI  IN DATE     ,
                                                  pDT_APLICACAOFIM  IN DATE     ,
                                                  pVL_AVALIACAOINI  IN NUMBER   ,
                                                  pVL_AVALIACAOFIM  IN NUMBER   ,
                                                  pDS_PROJ_APLIC    IN VARCHAR2 ,
                                                  vResult           out number) is
                                                  
  CURSOR C IS 
       SELECT CD_QUEST_PREENCH
       FROM APPP_TB_QUEST_PREENCH
       WHERE (DT_APLICACAO >= pDT_APLICACAOINI or pDT_APLICACAOINI IS NULL)
       AND   (DT_APLICACAO <= pDT_APLICACAOFIM or pDT_APLICACAOFIM IS NULL)
       AND   (VL_AVALIACAO >= pVL_AVALIACAOINI OR pVL_AVALIACAOINI IS NULL)
       AND   (VL_AVALIACAO <= pVL_AVALIACAOFIM OR pVL_AVALIACAOFIM IS NULL)
       AND   (DS_PROJ_APLIC like ('%'|| pDS_PROJ_APLIC || '%') OR pDS_PROJ_APLIC  IS NULL);
       
       
  vCD_TEMP NUMBER(20);
  vERRO        VARCHAR2(600);   
begin
    
   if pCD_QUEST_PREENCH is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_QUEST_PREENCH 
      WHERE CD_QUEST_PREENCH  = pCD_QUEST_PREENCH;
      
      if vResult > 0 then

          DELETE APPP_TB_QUEST_PREENCH 
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
         
         DELETE FROM APPP_TB_QUEST_PREENCH
         WHERE CD_QUEST_PREENCH  = vCD_TEMP;          
         
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
               
end APPP_DEL_QUEST_PREENCH;
/
