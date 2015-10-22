/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_DEL_RESPOSTA : Procedure para DELETAR dados de RESPOSTAS
*                     vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_RESPOSTA(pCD_RESPOSTA IN NUMBER  ,
                                              pDS_RESPOSTA IN VARCHAR2 ,
                                              vResult     out number) is
                                                  
  CURSOR C IS 
       SELECT CD_RESPOSTA
       FROM APPP_TB_RESPOSTA
       WHERE (DS_RESPOSTA  like ('%'|| pDS_RESPOSTA || '%') OR pDS_RESPOSTA IS NULL);
 
 vCD_TEMP NUMBER(20);
 vERRO        VARCHAR2(600);    
begin
    
   if pCD_RESPOSTA is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_RESPOSTA
      WHERE CD_RESPOSTA  = pCD_RESPOSTA;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_RESPOSTA
         WHERE CD_RESPOSTA  = pCD_RESPOSTA;
         
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

          DELETE FROM APPP_TB_RESPOSTA
          WHERE CD_RESPOSTA  = vCD_TEMP;
         
         
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
                vResult := SQLCODE; -- Erro generico.
                vERRO   := SUBSTR(SQLERRM,600);
             END IF;
         END;    
               
end APPP_DEL_RESPOSTA;
/
