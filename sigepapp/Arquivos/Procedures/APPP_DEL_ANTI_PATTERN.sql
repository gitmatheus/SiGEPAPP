/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_DEL_ANTI_PATTERN : Procedure para DELETAR dados de ANTI-PATTERNS
*                         vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_ANTI_PATTERN(vCD_ANTI_PATTERN  in NUMBER  , 
                                                  vDS_SINTOMAS      in VARCHAR2, 
                                                  vDS_RECOMENDACOES in VARCHAR2,
                                                  vDS_CONSEQUENCIAS in VARCHAR2,
                                                  vDS_BARREIRAS     in VARCHAR2,
                                                  vResult           out number) is
                                                  
  CURSOR C IS 
       SELECT CD_ANTI_PATTERN
       FROM APPP_TB_ANTI_PATTERN AP
       WHERE (AP.DS_SINTOMAS      like ('%'|| vDS_SINTOMAS || '%')      OR vDS_SINTOMAS      IS NULL)
       AND   (AP.DS_RECOMENDACOES like ('%'|| vDS_RECOMENDACOES || '%') OR vDS_RECOMENDACOES IS NULL)
       AND   (AP.DS_CONSEQUENCIAS like ('%'|| vDS_CONSEQUENCIAS || '%') OR vDS_CONSEQUENCIAS IS NULL)
       AND   (AP.DS_BARREIRAS     like ('%'|| vDS_BARREIRAS || '%')     OR vDS_BARREIRAS     IS NULL);                                                   

  vCD_TEMP NUMBER(20);     
begin
    
   if vCD_ANTI_PATTERN is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_ANTI_PATTERN AP
      WHERE AP.CD_ANTI_PATTERN  = vCD_ANTI_PATTERN;
      
      if vResult > 0 then
         DELETE FROM APPP_TB_ANTI_PATTERN AP
         WHERE AP.CD_ANTI_PATTERN  = vCD_ANTI_PATTERN;
         
         DELETE FROM APPP_TB_OBJ_RELAC ObR
         WHERE ObR.CD_OBJETO       = vCD_ANTI_PATTERN
         OR    ObR.CD_OBJETO_RELAC = vCD_ANTI_PATTERN;
         
         DELETE FROM APPP_TB_OBJETO
         WHERE CD_OBJETO = vCD_ANTI_PATTERN;
         
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

          DELETE FROM APPP_TB_ANTI_PATTERN AP
          WHERE AP.CD_ANTI_PATTERN  = vCD_TEMP;
         
          DELETE FROM APPP_TB_OBJ_RELAC ObR
          WHERE ObR.CD_OBJETO       = vCD_TEMP
          OR    ObR.CD_OBJETO_RELAC = vCD_TEMP;
         
          DELETE FROM APPP_TB_OBJETO
          WHERE CD_OBJETO = vCD_TEMP;          
         
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
               
end APPP_DEL_ANTI_PATTERN;
