/*****************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_DEL_ATRIBUTO_OBJ : Procedure para DELETAR dados de ATRIBUTOS
*                         vResult(0=NadaDeletado; 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_ATRIBUTO_OBJ(pCD_ATRIBUTO_OBJ IN NUMBER   ,
                                                  pNM_ATRIBUTO_OBJ IN VARCHAR2 , 
                                                  pDS_ATRIBUTO_OBJ IN VARCHAR2 ,
                                                  pCD_TIPO         IN NUMBER   ,
                                                  pFL_ATRIB_RELAC  IN VARCHAR2,
                                                  pNM_COLUNA       IN VARCHAR2,
                                                  vResult           out number) is
                                                  
  CURSOR C IS 
       SELECT CD_ATRIBUTO_OBJ
       FROM APPP_TB_ATRIBUTO_OBJ AO
       WHERE (AO.NM_ATRIBUTO_OBJ like ('%'|| pNM_ATRIBUTO_OBJ || '%') OR pNM_ATRIBUTO_OBJ  IS NULL)
       AND   (AO.DS_ATRIBUTO_OBJ like ('%'|| pDS_ATRIBUTO_OBJ || '%') OR pDS_ATRIBUTO_OBJ  IS NULL)
       AND   (AO.CD_TIPO         like ('%'|| pCD_TIPO || '%')         OR pCD_TIPO          IS NULL)                                                   
       AND   (AO.FL_ATRIB_RELAC  like ('%'|| pFL_ATRIB_RELAC || '%')  OR pFL_ATRIB_RELAC   IS NULL)
       AND   (AO.NM_COLUNA       LIKE ('%'|| pNM_COLUNA || '%')       OR pNM_COLUNA        IS NULL);
       
  vCD_TEMP NUMBER(20);     
begin
    
   if pCD_ATRIBUTO_OBJ is not null then
      --Se foi informado o código, é só fazer a exclusão dos dados se existirem.

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_ATRIBUTO_OBJ AO
      WHERE AO.CD_ATRIBUTO_OBJ  = pCD_ATRIBUTO_OBJ;
      
      if vResult > 0 then

         DELETE FROM APPP_TB_RELAC_ATRIB RA
         WHERE RA.CD_ATRIBUTO = pCD_ATRIBUTO_OBJ;
         
         DELETE FROM APPP_TB_ATRIBUTO_OBJ AO
         WHERE AO.CD_ATRIBUTO_OBJ  = pCD_ATRIBUTO_OBJ;

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
         WHERE RA.CD_ATRIBUTO = vCD_TEMP;
         
         DELETE FROM APPP_TB_ATRIBUTO_OBJ AO
         WHERE AO.CD_ATRIBUTO_OBJ  = vCD_TEMP;          
         
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
               
end APPP_DEL_ATRIBUTO_OBJ;

/
