/****************************************************************************************
* Project Name          : SiGEPAPP
* APPP_UPD_ATRIBUTO_OBJ : Procedure para ATUALIZAÇÃO de dados de ATRIBUTOS DE OBJETOS
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_ATRIBUTO_OBJ(pCD_ATRIBUTO_OBJ IN NUMBER   ,
                                                  pNM_ATRIBUTO_OBJ IN VARCHAR2 , 
                                                  pDS_ATRIBUTO_OBJ IN VARCHAR2 ,
                                                  pCD_TIPO         IN NUMBER   ,
                                                  pFL_ATRIB_RELAC  IN VARCHAR2 ,
                                                  pNM_COLUNA       IN VARCHAR2 ,
                                                  vResult           out number) is
begin
    
   IF pNM_ATRIBUTO_OBJ IS NOT NULL THEN
      UPDATE APPP_TB_ATRIBUTO_OBJ 
      SET NM_ATRIBUTO_OBJ = pNM_ATRIBUTO_OBJ
      WHERE CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;
   END IF;   
   
   IF pDS_ATRIBUTO_OBJ IS NOT NULL THEN
      UPDATE APPP_TB_ATRIBUTO_OBJ 
      SET DS_ATRIBUTO_OBJ = pDS_ATRIBUTO_OBJ
      WHERE CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;
   END IF;
   
   IF pCD_TIPO IS NOT NULL THEN
      UPDATE APPP_TB_ATRIBUTO_OBJ 
      SET CD_TIPO = pCD_TIPO
      WHERE CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;
   END IF;
   
   IF pFL_ATRIB_RELAC IS NOT NULL THEN
      UPDATE APPP_TB_ATRIBUTO_OBJ 
      SET FL_ATRIB_RELAC = pFL_ATRIB_RELAC
      WHERE CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;
   END IF;   
   
   IF pNM_COLUNA IS NOT NULL THEN
      UPDATE APPP_TB_ATRIBUTO_OBJ 
      SET NM_COLUNA = pNM_COLUNA
      WHERE CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ;
   END IF;   
   
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_ATRIBUTO_OBJ;
