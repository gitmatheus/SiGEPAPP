/*****************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_DEL_TIPO : Procedure para DELETAR dados de TIPOS
*                 vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author        : WeeDo 
* History       : 02/03/2009 - Matheus Gon�alves
******************************************************************************************************/
create or replace procedure APPP_DEL_TIPO(pCD_TIPO    IN NUMBER  ,
                                          pNM_TIPO    IN VARCHAR2,
                                          pDS_TIPO    IN VARCHAR2,
                                          pFL_EXP_REG IN VARCHAR2,
                                          vResult     out number) is
                                                  
  CURSOR C IS 
       SELECT CD_TIPO
       FROM APPP_TB_TIPO T
       WHERE (T.NM_TIPO    like ('%'|| pNM_TIPO || '%')    OR pNM_TIPO  IS NULL)
       AND   (T.DS_TIPO    like ('%'|| pDS_TIPO || '%')    OR pDS_TIPO  IS NULL)
       AND   (T.FL_EXP_REG = pFL_EXP_REG OR pFL_EXP_REG  IS NULL);
       
       
  vCD_TEMP NUMBER(20);     
begin
    
   if pCD_TIPO is not null then
      --Se foi informado o c�digo, � s� fazer a exclus�o dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_TIPO T
      WHERE T.CD_TIPO  = pCD_TIPO;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_RELAC_ATRIB RA
         WHERE RA.CD_ATRIBUTO IN (SELECT AO.CD_ATRIBUTO_OBJ
                                  FROM APPP_TB_ATRIBUTO_OBJ AO
                                  WHERE AO.CD_TIPO = pCD_TIPO
                                 );
      
         DELETE FROM APPP_TB_ATRIBUTO_OBJ AO
         WHERE AO.CD_TIPO = pCD_TIPO;
         
         DELETE FROM APPP_TB_TIPO T
         WHERE T.CD_TIPO  = pCD_TIPO;

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

         DELETE FROM APPP_TB_RELAC_ATRIB RA
         WHERE RA.CD_ATRIBUTO IN (SELECT AO.CD_ATRIBUTO_OBJ
                                  FROM APPP_TB_ATRIBUTO_OBJ AO
                                  WHERE AO.CD_TIPO = vCD_TEMP
                                 );
      
         DELETE FROM APPP_TB_ATRIBUTO_OBJ AO
         WHERE AO.CD_TIPO = vCD_TEMP;
         
         DELETE FROM APPP_TB_TIPO T
         WHERE T.CD_TIPO  = vCD_TEMP;
         
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
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_DEL_TIPO;
