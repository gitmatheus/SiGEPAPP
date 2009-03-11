/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_DEL_PERGUNTA : Procedure para DELETAR dados de PERGUNTAS
*                     vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_PERGUNTA(pCD_PERGUNTA IN NUMBER,
                                              pDS_PERGUNTA IN VARCHAR2,
                                              vResult     out number) is
                                                  
  CURSOR C IS 
       SELECT CD_PERGUNTA
       FROM APPP_TB_PERGUNTA
       WHERE (DS_PERGUNTA  like ('%'|| pDS_PERGUNTA || '%') OR pDS_PERGUNTA IS NULL);
 
 vCD_TEMP NUMBER(20);     
begin
    
   if pCD_PERGUNTA is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_PERGUNTA
      WHERE CD_PERGUNTA  = pCD_PERGUNTA;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_PERGUNTA
         WHERE CD_PERGUNTA  = pCD_PERGUNTA;
         
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

          DELETE FROM APPP_TB_PERGUNTA
          WHERE CD_PERGUNTA  = vCD_TEMP;
         
         
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
         DECLARE
             error_code NUMBER := SQLCODE;
         BEGIN
             IF error_code = -2292 THEN
                ROLLBACK;
                vResult := -2292; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := -99; -- Erro genérico.             
             END IF;
         END;    
               
end APPP_DEL_PERGUNTA;
/