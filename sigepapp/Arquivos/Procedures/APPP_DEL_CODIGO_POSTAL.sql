/*****************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_DEL_CODIGO_POSTAL : Procedure para DELETAR dados de CODIGO_POSTAL
*                          vResult(0=NadaDeletado; 
                                   1=OK; 
                                   -99=ErroGeral
                                   -90=N�o pode excluir)
* Author                 : WeeDo 
* History                : 03/03/2009 - Matheus Gon�alves
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
      --Se foi informado o c�digo, � s� fazer a exclus�o dos dados se existirem.

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
       --Se n�o foi informado o c�digo, 
       --Ele busca dados a serem apagados conforme os par�metros.
       --Com os c�digos em m�o � s� fazer a exclus�o dos dados.
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
        vResult := 0; -- N�o existe dado a ser deletado. 
        
     WHEN OTHERS THEN
         
         DECLARE
             error_code NUMBER := SQLCODE;
         BEGIN
             IF error_code = -2292 THEN
                ROLLBACK;
                vResult := -90; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := -99; -- Erro gen�rico.             
             END IF;
         END;      
               
end APPP_DEL_CODIGO_POSTAL;
