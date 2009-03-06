/*****************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_DEL_QUESTIONARIO : Procedure para DELETAR dados de ATRIBUTOS
*                         vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_QUESTIONARIO(pCD_QUEST         IN NUMBER   ,
                                                  pDT_APLICACAOINI  IN DATE     ,
                                                  pDT_APLICACAOFIM  IN DATE     ,
                                                  pVL_AVALIACAOINI  IN NUMBER   ,
                                                  pVL_AVALIACAOFIM  IN NUMBER   ,
                                                  pDS_PROJ_APLIC    IN VARCHAR2 ,
                                                  pCD_USER          IN NUMBER   ,
                                                  vResult           out number) is
                                                  
  CURSOR C IS 
       SELECT CD_QUEST
       FROM APPP_TB_QUESTIONARIO
       WHERE (CD_USER = pCD_USER OR pCD_USER IS NULL)
       AND   (DT_APLICACAO >= pDT_APLICACAOINI or pDT_APLICACAOINI IS NULL)
       AND   (DT_APLICACAO <= pDT_APLICACAOFIM or pDT_APLICACAOFIM IS NULL)
       AND   (VL_AVALIACAO >= pVL_AVALIACAOINI OR pVL_AVALIACAOINI IS NULL)
       AND   (VL_AVALIACAO <= pVL_AVALIACAOFIM OR pVL_AVALIACAOFIM IS NULL)
       AND   (DS_PROJ_APLIC like ('%'|| pDS_PROJ_APLIC || '%') OR pDS_PROJ_APLIC  IS NULL);
       
       
  vCD_TEMP NUMBER(20);     
begin
    
   if pCD_QUEST is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_QUESTIONARIO 
      WHERE CD_QUEST  = pCD_QUEST;
      
      if vResult > 0 then

          DELETE APPP_TB_QUESTIONARIO 
          WHERE CD_QUEST  = pCD_QUEST;

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
         
         DELETE FROM APPP_TB_QUESTIONARIO
         WHERE CD_QUEST  = vCD_TEMP;          
         
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
        vResult := -99; -- Erro genérico.
               
end APPP_DEL_QUESTIONARIO;
