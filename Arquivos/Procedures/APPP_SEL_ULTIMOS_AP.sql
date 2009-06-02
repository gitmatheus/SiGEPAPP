/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_APPP_GEN  : Procedure para SELECIONAR Últimos Anti-Patterns Cadastrados
* Author             : WeeDo 
* History            : 24/05/2009 - Guilherme Wachs Lopes - Versão Inicial
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ULTIMOS_AP(p_cursor OUT SYS_REFCURSOR,
                                               vResult OUT NUMBER) is


  vCD_ESTRUTURA  APPP_TB_OBJETO.CD_ESTRUTURA%TYPE;
	vTP_ESTRUTURA  APPP_TB_ESTRUT_OBJ.TP_ESTRUTURA%TYPE;
	vCD_OBJETO     APPP_TB_OBJETO.CD_OBJETO%TYPE;

  vNM_COLUNA  APPP_TB_ATRIBUTO_OBJ.NM_COLUNA%TYPE;
  vNM_TABELA  APPP_TB_ESTRUT_OBJ.NM_TB_ESTRUT%TYPE;

  vSQL VARCHAR2(15000) := '';

  vERRO        VARCHAR2(600);

	CURSOR E IS
	 SELECT CD_ESTRUTURA,
	        TP_ESTRUTURA
	 FROM APPP_TB_ESTRUT_OBJ
	 WHERE TP_ESTRUTURA='AP';

	 CURSOR O IS
	   SELECT OB.CD_OBJETO
		 FROM APPP_TB_OBJETO OB
		 WHERE OB.CD_ESTRUTURA = vCD_ESTRUTURA;

	CURSOR TAB IS
	 SELECT EO.NM_TB_ESTRUT
	 FROM APPP_TB_ESTRUT_OBJ EO
	 WHERE EO.CD_ESTRUTURA = vCD_ESTRUTURA;

	CURSOR AOB IS
   SELECT TRIM(COLUMN_NAME) NM_COLUNA
   FROM ALL_TAB_COLUMNS
   WHERE TABLE_NAME = vNM_TABELA
   AND TRIM(COLUMN_NAME) IN ('DS_PROBLEMA', 'DS_SOLUCAO')
	 ORDER BY NM_COLUNA;


BEGIN

     vResult := 0;

     OPEN E;
		 FETCH E INTO vCD_ESTRUTURA, vTP_ESTRUTURA;
		 WHILE E%FOUND LOOP

					 -- PEGA O NOME DA TABELA DINAMICA
					 OPEN TAB;
					 FETCH TAB INTO vNM_TABELA;
					 CLOSE TAB;

					 vSQL := vSQL ||'SELECT  O.CD_OBJETO ' || chr(10);
           vSQL := vSQL ||'       ,'|| ''''|| vTP_ESTRUTURA || '''' ||' TP_ESTRUTURA '|| chr(10);
					 vSQL := vSQL ||'       ,O.NM_OBJETO ' || chr(10);
					 vSQL := vSQL ||'       ,O.DS_OBJETO ' || chr(10);

					IF    vCD_ESTRUTURA = 1 THEN
								 	 vSQL := vSQL ||'       ,P.DS_PROBLEMA PROBLEMA' || chr(10);
									 vSQL := vSQL ||'       ,P.DS_SOLUCAO  SOLUCAO'  || chr(10);
									 vSQL := vSQL ||'FROM   APPP_TB_OBJETO  O,'          || chr(10);
									 vSQL := vSQL ||'       APPP_TB_PATTERN P'           || chr(10);
									 vSQL := vSQL ||'WHERE  P.CD_PATTERN = O.CD_OBJETO'  || chr(10);

					ELSIF vCD_ESTRUTURA = 2 THEN
								 	 vSQL := vSQL ||'       ,AP.DS_PROBLEMA      PROBLEMA'    || chr(10);
									 vSQL := vSQL ||'       ,AP.DS_RECOMENDACOES SOLUCAO'     || chr(10);
									 vSQL := vSQL ||'FROM   APPP_TB_OBJETO  O,     '          || chr(10);
									 vSQL := vSQL ||'       APPP_TB_ANTI_PATTERN AP'          || chr(10);
									 vSQL := vSQL ||'WHERE  AP.CD_ANTI_PATTERN = O.CD_OBJETO' || chr(10);

					ELSE

									 OPEN AOB;
									 FETCH AOB INTO vNM_COLUNA;
									 WHILE AOB%FOUND AND AOB%ROWCOUNT <= 2 LOOP

									    IF    TRIM(vNM_COLUNA) = 'DS_PROBLEMA' THEN
													       vSQL := vSQL ||'       ,G.DS_PROBLEMA PROBLEMA' || chr(10);
											ELSIF TRIM(vNM_COLUNA) = 'DS_SOLUCAO' THEN
													vSQL := vSQL ||'       ,G.DS_SOLUCAO SOLUCAO' || chr(10);

                      END IF;

											FETCH AOB INTO vNM_COLUNA;
									 END LOOP;
									CLOSE AOB;
                   vSQL := vSQL ||'FROM   APPP_TB_OBJETO O,' || chr(10);
		               vSQL := vSQL ||'       '||TRIM(vNM_TABELA)|| ' G '   || chr(10);
                   vSQL := vSQL ||'WHERE  G.CD_OBJETO = O.CD_OBJETO' || chr(10);
					END IF;

					vSQL := vSQL ||'AND  O.FL_ATIVO = 1' || chr(10);

					FETCH E INTO vCD_ESTRUTURA, vTP_ESTRUTURA;
					IF E%FOUND THEN
					   vSQL := vSQL ||' UNION '||  chr(10);
          END IF;

		 END LOOP;

          vSQL := vSQL || ' order by CD_OBJETO desc';

     OPEN p_cursor FOR vSQL;
     vResult := 1;

     EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,300) || 'Tabela: ' || vNM_TABELA || '; Coluna: ' || vNM_COLUNA ;

END APPP_SEL_ULTIMOS_AP;
/