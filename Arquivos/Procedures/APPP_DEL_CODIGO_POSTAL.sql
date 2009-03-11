/*****************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_DEL_CODIGO_POSTAL : Procedure para DELETAR dados de CODIGO_POSTAL
*                          vResult(0=NadaDeletado; 
                                   1=OK; 
                                   -99=ErroGeral
                                   -90=Não pode excluir)
* Author                 : WeeDo 
* History                : 03/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_CODIGO_POSTAL(pCD_CEP    IN NUMBER   ,
                                                   pNM_RUA    IN VARCHAR2 ,
                                                   pCD_CIDADE IN NUMBER   ,
                                                   vResult    out number) is
                                                  
  CURSOR C IS 
       SELECT CD_CEP
       FROM APPP_TB_CODIGO_POSTAL 
       WHERE (NM_RUA LIKE ('%'|| pNM_RUA || '%') OR pNM_RUA IS NULL)
       AND   (CD_CIDADE = pCD_CIDADE or pCD_CIDADE IS NULL);
       
  vCD_TEMP NUMBER(20);     
begin
    
   if pCD_CEP is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_CODIGO_POSTAL 
      WHERE CD_CEP  = pCD_CEP;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_CODIGO_POSTAL
         WHERE CD_CEP  = pCD_CEP;

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

         DELETE FROM APPP_TB_CODIGO_POSTAL
         WHERE CD_CEP  = vCD_TEMP;
         
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
                vResult := -90; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := -99; -- Erro genérico.             
             END IF;
         END;      
               
end APPP_DEL_CODIGO_POSTAL;
/
