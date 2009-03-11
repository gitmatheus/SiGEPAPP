/*****************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_DEL_RELAC_ATRIB : Procedure para DELETAR dados de RELAC_ATRIBS
*                 vResult(0=NadaDeletado; xx=QTDE DELETADA; -99=ErroGeral)
* Author        : WeeDo 
* History       : 03/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_RELAC_ATRIB(pCD_RELAC    in NUMBER,
                                                 pCD_ATRIBUTO in NUMBER,
                                                 pVL_RELAC    in VARCHAR2,
                                                 vResult     out number) IS
                                                  
  CURSOR C IS 
       SELECT CD_RELAC
       FROM APPP_TB_RELAC_ATRIB RA
       WHERE (RA.CD_ATRIBUTO = pCD_ATRIBUTO OR pCD_ATRIBUTO IS NULL)
       AND   (RA.VL_RELAC    = pVL_RELAC    OR pVL_RELAC    IS NULL);
       
       
  vCD_TEMP NUMBER(20);     
begin
    
   if pCD_RELAC is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_RELAC_ATRIB RA
      WHERE RA.CD_RELAC = pCD_RELAC;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_RELAC_ATRIB RA
         WHERE RA.CD_RELAC = pCD_RELAC;

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

         DELETE FROM APPP_TB_RELAC_ATRIB RA
         WHERE RA.CD_RELAC = vCD_TEMP;
         
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
               
end APPP_DEL_RELAC_ATRIB;
/