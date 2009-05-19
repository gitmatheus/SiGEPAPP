create or replace
procedure APPP_SEL_APP_SIMILARIDADE(p_cursor out SYS_REFCURSOR,
                                                 nome_procurado VARCHAR2,
                                                 contexto_procurado VARCHAR2,
                                                 problema_procurado VARCHAR2,
                                                 solucao_procurado VARCHAR2,
                                                 peso_nome VARCHAR2,
                                                 peso_contexto VARCHAR2,
                                                 peso_problema VARCHAR2,
                                                 peso_solucao VARCHAR2,
                                                 vResult out number) is


vCD_ESTRUTURA  APPP_TB_OBJETO.CD_ESTRUTURA%TYPE;
  vTP_ESTRUTURA  APPP_TB_ESTRUT_OBJ.TP_ESTRUTURA%TYPE;
  vCD_OBJETO     APPP_TB_OBJETO.CD_OBJETO%TYPE;

  vNM_COLUNA  APPP_TB_ATRIBUTO_OBJ.NM_COLUNA%TYPE;
  vNM_TABELA  APPP_TB_ESTRUT_OBJ.NM_TB_ESTRUT%TYPE;

  vSQL VARCHAR2(30000) := '';

  vERRO        VARCHAR2(600);

  CURSOR E IS
   SELECT CD_ESTRUTURA,
          TP_ESTRUTURA
   FROM APPP_TB_ESTRUT_OBJ
   WHERE TP_ESTRUTURA IN ('AP','PA');

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

--Para similaridade--

--nome_procurado        VARCHAR2(2000):= ' ';
--contexto_procurado    VARCHAR2(2000):= ' ';
--problema_procurado    VARCHAR2(2000):= ' ';
--solucao_procurado     VARCHAR2(2000):= ' ';

--peso_nome         varchar(5):='0.25';
--peso_contexto     varchar(5):='0.25';
--peso_problema     varchar(5):='0.25';
--peso_solucao      varchar(5):='0.25';


BEGIN

     vResult := 0;

--Inicia o comando sql principal fazendo a selecao dos campos

vSQL:='SELECT  APPP_PKG_SIMILARIDADE.SIMILARIDADE(nm_objeto,' || CHR(39) || nome_procurado || CHR(39) || ')*' || peso_nome || '+ ' || CHR(10);
vSQL:=vSQL ||' APPP_PKG_SIMILARIDADE.SIMILARIDADE(ds_objeto,' || CHR(39) || contexto_procurado || CHR(39) || ')*' || peso_contexto || '+ ' || CHR(10);
vSQL:=vSQL ||' APPP_PKG_SIMILARIDADE.SIMILARIDADE(problema,' || CHR(39) || problema_procurado || CHR(39) || ')*' || peso_problema || '+ ' || CHR(10);
vSQL:=vSQL ||' APPP_PKG_SIMILARIDADE.SIMILARIDADE(solucao,' || CHR(39) || solucao_procurado || CHR(39) || ')*' || peso_solucao || ' SIMILARIDADE ' || CHR(10);
vSQL:=vSQL ||' , o.*';
vSQL:=vSQL ||' FROM (';

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
                    vSQL := vSQL ||'       ,P.DS_PAT_PROBLEMA PROBLEMA' || chr(10);
                   vSQL := vSQL ||'       ,P.DS_PAT_SOLUCAO  SOLUCAO'  || chr(10);
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



          FETCH E INTO vCD_ESTRUTURA, vTP_ESTRUTURA;
          IF E%FOUND THEN
             vSQL := vSQL ||' UNION '||  chr(10);
          END IF;
		  
     END LOOP;
	 CLOSE E;
--Fim da selecao de todas os APP(Pattern, Anti-Pattern e outras estruturas que utilizam Pattern ou Anti-Pattern como estrutura minima)
vSQL:=vSQL || ') o ORDER BY SIMILARIDADE DESC';

      --DBMS_OUTPUT.PUT_LINE(vSQL);
     OPEN p_cursor FOR vSQL;
     vResult := 1;

     EXCEPTION
     WHEN OTHERS THEN
       rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,300) || 'Tabela: ' || vNM_TABELA || '; Coluna: ' || vNM_COLUNA ;
        
end APPP_SEL_APP_SIMILARIDADE;
/