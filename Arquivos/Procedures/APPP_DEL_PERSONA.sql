/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_DEL_PERSONA : Procedure para DELETAR dados de PERSONAS
*                    vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_DEL_PERSONA(pCD_PERSONA NUMBER  ,
                                             pNM_PERSONA VARCHAR2,
                                             vResult     out number) is
                                                  
  CURSOR C IS 
       SELECT CD_PERSONA
       FROM APPP_TB_PERSONA
       WHERE (NM_PERSONA  like ('%'|| pNM_PERSONA || '%') OR pNM_PERSONA IS NULL);
 
 vCD_TEMP NUMBER(20);     
begin
    
   if pCD_PERSONA is not null then
      --Se foi informado o c�digo, � s� fazer a exclus�o dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_PERSONA
      WHERE CD_PERSONA  = pCD_PERSONA;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_PERSONA
         WHERE CD_PERSONA  = pCD_PERSONA;
         
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

          DELETE FROM APPP_TB_PERSONA
          WHERE CD_PERSONA  = vCD_TEMP;
         
         
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
                vResult := -99; -- Erro gen�rico.             
             END IF;
         END;    
               
end APPP_DEL_PERSONA;
