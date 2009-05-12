/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_APPP_GEN  : Procedure para SELECIONAR dados de PATTERNS OU ANTI-PATTERNS OU PERSONAS GENERICAS
* Author             : WeeDo 
* History            : 11/05/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_APPP_GEN(pCD_OBJETO   IN NUMBER  , 
                                              p_cursor OUT SYS_REFCURSOR   ) is

  vCD_ESTRUTURA  APPP_TB_OBJETO.CD_ESTRUTURA%TYPE;
  vCD_ATRIBUTO_OBJ  APPP_TB_ATRIB_ESTRUTURA.CD_ATRIBUTO_OBJ%TYPE;
  vNM_COLUNA  APPP_TB_ATRIBUTO_OBJ.NM_COLUNA%TYPE;
  vNM_ATRIBUTO  APPP_TB_ATRIBUTO_OBJ.NM_ATRIBUTO_OBJ%TYPE; 
	vNM_TABELA  APPP_TB_ESTRUT_OBJ.NM_TB_ESTRUT%TYPE;
  
  vSQL VARCHAR2(15000);
  
  CURSOR C IS 
     SELECT O.CD_ESTRUTURA 
     FROM   APPP_TB_OBJETO O 
     WHERE O.CD_OBJETO = pCD_OBJETO; 
     
  CURSOR AOB IS
   SELECT TRIM(COLUMN_NAME) NM_COLUNA
   FROM ALL_TAB_COLUMNS 
   WHERE TABLE_NAME = vNM_TABELA;
		
	CURSOR TAB IS
	 SELECT EO.NM_TB_ESTRUT 
	 FROM APPP_TB_ESTRUT_OBJ EO
	 WHERE EO.CD_ESTRUTURA = vCD_ESTRUTURA;
	 
     
BEGIN
   
   OPEN C;
   FETCH C INTO vCD_ESTRUTURA;
   CLOSE C;
   
   IF vCD_ESTRUTURA IS NOT NULL THEN
       
	     -- PEGA O NOME DA TABELA DINAMICA
			 OPEN TAB;
			 FETCH TAB INTO vNM_TABELA;
			 CLOSE TAB; 
	        
       vSQL :=        'SELECT O.CD_OBJETO,' || chr(10);
       vSQL := vSQL ||'       O.NM_OBJETO,' || chr(10);
       vSQL := vSQL ||'       O.DS_OBJETO, ' || chr(10);
       vSQL := vSQL ||'       O.DT_CRIACAO, ' || chr(10);
       vSQL := vSQL ||'       O.CD_USER_CRIADOR, ' || chr(10);
       vSQL := vSQL ||'       O.FL_ATIVO  ' || chr(10);
  
       OPEN AOB;
       FETCH AOB INTO vNM_COLUNA;
       WHILE AOB%FOUND LOOP  
			 
 			    -- INCREMENTA O SQL DIN�MICO COM A COLUNA.
				  vSQL := vSQL ||'        ,G.' ||trim(vNM_COLUNA)||  chr(10);
						 
					FETCH AOB INTO vNM_COLUNA;
						 
       END LOOP;
			 
			 CLOSE AOB; 
       vSQL := vSQL ||'FROM   APPP_TB_OBJETO O,' || chr(10);

		   vSQL := vSQL ||'       '||TRIM(vNM_TABELA)|| ' G '   || chr(10);	 
			 
			 IF vCD_ESTRUTURA = 1     THEN
    			vSQL := vSQL ||'WHERE  G.CD_PATTERN = O.CD_OBJETO'      || chr(10);
			 ELSIF vCD_ESTRUTURA = 2  THEN
          vSQL := vSQL ||'WHERE  G.CD_ANTI_PATTERN = O.CD_OBJETO' || chr(10);
       ELSIF vCD_ESTRUTURA = 3  THEN
          vSQL := vSQL ||'WHERE  G.CD_PERSONA = O.CD_OBJETO'      || chr(10);					
			 ELSE
          vSQL := vSQL ||'WHERE  G.CD_OBJETO = O.CD_OBJETO'       || chr(10);		
 			 END IF;
			 					    		 
			 vSQL := vSQL ||'AND    O.CD_OBJETO = ' || pCD_OBJETO || chr(10); 
			 
			 OPEN p_cursor FOR vSQL;
			 
   END IF; 

END APPP_SEL_APPP_GEN;

/
