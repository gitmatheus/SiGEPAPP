/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_APPP_GEN  : Procedure para SELECIONAR dados de PATTERNS OU ANTI-PATTERNS OU PERSONAS GENERICAS
* Author             : WeeDo 
* History            : 11/05/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_APPP_GEN(pCD_OBJETO   IN NUMBER  , 
                                              p_cursor OUT SYS_REFCURSOR   ) is

  vCD_ESTRUTURA AS APPP_TB_OBJETO.CD_ESTRUTURA%TYPE;
  vCD_ATRIBUTO_OBJ AS APPP_TB_ATRIB_ESTRUTURA.CD_ATRIBUTO_OBJ%TYPE;
  vNM_COLUNA AS APPP_TB_ATRIBUTO_OBJ.NM_COLUNA%TYPE;
  vNM_ATRIBUTO AS APPP_TB_ATRIBUTO_OBJ.NM_ATRIBUTO_OBJ%TYPE;
  
  vSQL VARCHAR2(15000);
  
  CURSOR C IS 
     SELECT O.CD_ESTRUTURA 
     FROM   APPP_TB_OBJETO O 
     WHERE O.CD_OBJETO = pCD_OBJETO; 
     
  CURSOR ESxAT IS
     SELECT AE.CD_ATRIBUTO_OBJ 
     FROM APPP_TB_ATRIB_ESTRUTURA AE
     WHERE AE.CD_ESTRUTURA = vCD_ESTRUTURA;
     
  CURSOR AOB IS
   SELECT NM_COLUNA,
          NM_ATRIBUTO_OBJ
    FROM APPP_TB_ATRIBUTO_OBJ AO
    WHERE AO.CD_ATRIBUTO_OBJ = vCD_ATRIBUTO_OBJ;
     
BEGIN
   
   OPEN C;
   FETCH C INTO vCD_ESTRUTURA;
   CLOSE C;
   
   IF vCD_ESTRUTURA IS NOT NULL THEN
       
       vSQL :=        'SELECT O.CD_OBJETO,' || chr(10);
       vSQL := vSQL ||'       O.NM_OBJETO,' || chr(10);
       vSQL := vSQL ||'       O.DS_OBJETO, ' || chr(10);
       vSQL := vSQL ||'       O.DT_CRIACAO, ' || chr(10);
       vSQL := vSQL ||'       O.CD_USER_CRIADOR, ' || chr(10);
       vSQL := vSQL ||'       O.FL_ATIVO  ' || chr(10);
      
                 

       OPEN ESxAT;
       FETCH ESxAT INTO vCD_ATRIBUTO_OBJ;
       LOOP WHILE ESxAT%FOUND
            OPEN AOB;
            FETCH AOB INTO vNM_COLUNA, vNM_ATRIBUTO;
            
             if vNM_COLUNA is null then
                  SELECT appp_fn_nm_col_atrib(vNM_ATRIBUTO) INTO vNOME_COLUNA FROM DUAL;
                  update APPP_TB_ATRIBUTO_OBJ AO
                  SET AO.NM_COLUNA = vNOME_COLUNA
                  where AO.CD_ATRIBUTO_OBJ = vCD_ATRIBUTO_OBJ;
                  COMMIT;
             end if; 
            
           FETCH ESxAT INTO vCD_ATRIBUTO_OBJ;
       END LOOP;

   END IF; 

END APPP_SEL_APPP_GEN;

/
