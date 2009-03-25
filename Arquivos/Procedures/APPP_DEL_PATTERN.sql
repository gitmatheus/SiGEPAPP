/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_DEL_PATTERN : Procedure para DELETAR dados de PATTERNS
*                    vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_PATTERN(pCD_PATTERN      in NUMBER  , 
                                             pDS_PAT_PROBLEMA IN VARCHAR2,
                                             pDS_PAT_SOLUCAO  in VARCHAR2,
                                             vResult           out number) is
                                                  
  CURSOR C IS 
       SELECT CD_PATTERN
       FROM APPP_TB_PATTERN
       WHERE (DS_PAT_PROBLEMA  like ('%'|| pDS_PAT_PROBLEMA || '%') OR pDS_PAT_PROBLEMA IS NULL)
       AND   (DS_PAT_SOLUCAO   like ('%'|| pDS_PAT_SOLUCAO || '%')  OR pDS_PAT_SOLUCAO  IS NULL);     
 
 vCD_TEMP NUMBER(20);
 vERRO        VARCHAR2(600);
begin
    
   if pCD_PATTERN is not null then
      --Se foi informado o c�digo, � s� fazer a exclus�o dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_PATTERN
      WHERE CD_PATTERN  = pCD_PATTERN;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_PATTERN
         WHERE CD_PATTERN  = pCD_PATTERN;
         
         DELETE FROM APPP_TB_OBJ_RELAC ObR
         WHERE ObR.Cd_Obj_Relacionado  = pCD_PATTERN
         OR    ObR.Cd_Obj_Relacionando = pCD_PATTERN;
         
         DELETE FROM APPP_TB_OBJETO
         WHERE CD_OBJETO = pCD_PATTERN;
         
         commit;
         
      end if;   
      
   else 
       
       vResult := 0;
       OPEN C;
       --Se n�o foi informado o c�digo, 
       --Ele busca dados a serem apagados conforme os par�metros.
       --Com os c�digos em m�o � s� fazer a exclus�o dos dados.
       LOOP 
          FETCH C INTO vCD_TEMP;
          EXIT WHEN C%NOTFOUND;
          vResult := vResult + 1;

          DELETE FROM APPP_TB_PATTERN
          WHERE CD_PATTERN  = vCD_TEMP;
         
          DELETE FROM APPP_TB_OBJ_RELAC ObR
          WHERE ObR.Cd_Obj_Relacionado       = vCD_TEMP
          OR    ObR.Cd_Obj_Relacionando = vCD_TEMP;
         
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
        vResult := 0; -- N�o existe dado a ser deletado. 
        
     WHEN OTHERS THEN
         DECLARE
             error_code NUMBER := SQLCODE;
         BEGIN
             IF error_code = -2292 THEN
                ROLLBACK;
                vResult := -2292; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := SQLCODE; -- Erro generico.
                vERRO   := SUBSTR(SQLERRM,600);
             END IF;
         END;    
               
end APPP_DEL_PATTERN;
/
