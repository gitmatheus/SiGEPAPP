/*****************************************************************************************
* Project Name            : SiGEPAPP
* APPP_CRIA_TABELA_ESTRUT : Procedure para criacao dinamica de tabelas de estrutura.
*                           vResult( 0=Estrutura + Atributos nao encontrados; 
*                                    1=Tabela Criada; 
*                                    2=PK CRIADA;
*                                    3=FK CRIADA;
*                                    4=PROCEDURE DE INS CRIADA;
*                                    5=PROCEDURE DE SEL CRIADA;  
*                                    6=PROCEDURE DE DEL CRIADA;
*                                    7=PROCEDURE DE UPD CRIADA;   
*                                    -50= TABELA JA EXISTE;
*                                    -xx=ErroGeral)
* Author                  : WeeDo 
* History                 : 10/03/2009 - Matheus Goncalves
******************************************************************************************/
create or replace procedure APPP_CRIA_TABELA_ESTRUT(pCD_ESTRUTURA IN NUMBER,
                                                    vResult       OUT NUMBER ) is

  cursor c is 
  select EO.CD_ESTRUTURA,
         EO.NM_TB_ESTRUT,
         EO.TP_ESTRUTURA,
         AO.NM_COLUNA,
         AO.NM_ATRIBUTO_OBJ,
         AO.DS_ATRIBUTO_OBJ,
         DECODE(T.FL_EXP_REG,'S','VARCHAR2',
                              'N',upper(T.DS_TIPO)) T_TYPE            
  from appp_tb_estrut_obj EO,
       appp_tb_atrib_estrutura AE,
       appp_tb_atributo_obj AO,
       APPP_TB_TIPO T
  where AE.CD_ESTRUTURA    = EO.CD_ESTRUTURA
  AND   AO.CD_ATRIBUTO_OBJ = AE.CD_ATRIBUTO_OBJ
  AND   T.CD_TIPO          = AO.CD_TIPO
  and   EO.cd_estrutura    = pCD_ESTRUTURA;
  
  vSQL         VARCHAR2(10000);
  vERRO        VARCHAR2(600);
  
  --VARIAVEIS DE INSERCAO
  vSQL_INS     VARCHAR2(8000); -- TODO O SQL
  vSQL_INS_CAB VARCHAR2(2000); -- SQL DO CABECALHO
  vSQL_INS_ATR VARCHAR2(2000); -- SQL DOS ATRIBUTOS
  vSQL_INS_VAL VARCHAR2(2000); -- SQL DOS VALORES
  
  
  --VARIAVEIS DE SELECAO
  vSQL_SEL     VARCHAR2(8000); -- TODO O SQL
  vSQL_SEL_CAB VARCHAR2(2000); -- SQL DO CABECALHO
  vSQL_SEL_ATR VARCHAR2(2000); -- SQL DOS ATRIBUTOS
  vSQL_SEL_WHE VARCHAR2(2000); -- SQL DA CONDICAO WHERE 
  
  --VARIAVEIS DE DELETE
  vSQL_DEL     VARCHAR2(8000); -- TODO O SQL
  vSQL_DEL_CAB VARCHAR2(2000); -- SQL DO CABECALHO
  vSQL_DEL_ATR VARCHAR2(2000); -- SQL DOS ATRIBUTOS
  vSQL_DEL_WHE VARCHAR2(2000); -- SQL DA CONDICAO WHERE 
  
  --VARIAVEIS DE UPDATE
  vSQL_UPD     VARCHAR2(8000); -- TODO O SQL
  vSQL_UPD_CAB VARCHAR2(2000); -- SQL DO CABECALHO
  vSQL_UPD_ATR VARCHAR2(2000); -- SQL DOS ATRIBUTOS
  vSQL_UPD_WHE VARCHAR2(2000); -- SQL DA CONDICAO WHERE 
  
  vNOME_TABELA VARCHAR2(60);
  vMAXTAM      VARCHAR2(15);
  vTEMP        VARCHAR2(2);
  
begin
  vResult := 0; -- Inicia zerado.   

  /***************************************************************** 
    ESSE CURSOR E RESPONSAVEL PELA CRIACAO DINAMICA DA TABELA,
        DAS PROCEDURES DE ACESSO A DADOS E DAS CONSTRAINTS
   ****************************************************************/  
  vSQL := '';
  FOR vCURSOR IN C LOOP
      -- COMANDO INICIAL
      if vSQL = '' OR vSQL IS NULL then

         vNOME_TABELA := vCURSOR.NM_TB_ESTRUT;

         -- VERIFICA SE A TABELA EXISTE
         SELECT COUNT(*) INTO vTEMP
         FROM ALL_TABLES ATB
         WHERE ATB.TABLE_NAME = vNOME_TABELA;
         
         IF vTEMP > 0 THEN
            vResult := -50; -- Tabela ja existe
            EXIT;
         END IF;
         
         -- CREATE TABLE - INICIO
         vSQL := vSQL || 'CREATE TABLE '|| vNOME_TABELA || '(';
         vSQL := vSQL || 'CD_OBJETO NUMBER(10) NOT NULL';  
         
         -- CREATE PROCEDURE INS -- INICIO
         vSQL_INS_CAB := 'create or replace procedure ' || 'APPP_INS' || SUBSTR(vNOME_TABELA,8,18) || '( pCD_OBJETO IN NUMBER ' || chr(10);
         vSQL_INS_ATR := '   INSERT INTO '|| vNOME_TABELA || '(CD_OBJETO ' || chr(10);
         vSQL_INS_VAL := RPAD(' ',33,' ') || 'VALUES (pCD_OBJETO '  || chr(10); 
         
         
         -- CREATE PROCEDURE SEL -- INICIO
         vSQL_SEL_CAB := 'create or replace procedure ' || 'APPP_SEL' || SUBSTR(vNOME_TABELA,8,18) || '(  pCD_OBJETO IN NUMBER ' || chr(10);
         vSQL_SEL_ATR :=                  '    open p_cursor FOR' || chr(10);
         vSQL_SEL_ATR :=  vSQL_SEL_ATR || '    SELECT CD_OBJETO ' || chr(10);
         vSQL_SEL_WHE :=                  '    WHERE (CD_OBJETO = pCD_OBJETO OR pCD_OBJETO IS NULL)';
         
         -- CREATE PROCEDURE DEL -- INICIO
         vSQL_DEL_CAB := 'create or replace procedure ' || 'APPP_DEL' || SUBSTR(vNOME_TABELA,8,18) || '(  pCD_OBJETO IN NUMBER ' || chr(10);
         vSQL_DEL_ATR := '        DELETE FROM ' || vNOME_TABELA || chr(10);
         vSQL_DEL_WHE := '        WHERE CD_OBJETO = pCD_OBJETO ;'|| chr(10);
         
         -- CREATE PROCEDURE UPD -- INICIO
         vSQL_UPD_CAB := 'create or replace procedure ' || 'APPP_UPD' || SUBSTR(vNOME_TABELA,8,18) || '(  pCD_OBJETO IN NUMBER ' || chr(10);
         vSQL_UPD_WHE := '    WHERE CD_OBJETO = pCD_OBJETO ';

       end if;
       
      -- DEFINE O TAMANHO MAXIMO DO CAMPO DE ACORDO COM SEU TIPO
      if    vCURSOR.T_TYPE = 'NUMBER' THEN 
            vMAXTAM := '(15)';
      ELSIF vCURSOR.T_TYPE = 'VARCHAR2' THEN 
            vMAXTAM := '(3000)';
      ELSE       
            vMAXTAM := '';
      END IF;
      
     -- INSERE O ATRIBUTO NO COMANDO DINAMICO.
      vSQL := vSQL || ', ' ||vCURSOR.NM_COLUNA|| ' '||vCURSOR.T_TYPE||vMAXTAM || ' NOT NULL ';   

      -- CRIA LINHAS DA PROCEDURE DE INSERCAO
      vSQL_INS_CAB := vSQL_INS_CAB || RPAD(' ',56,' ') || ',p' || vCURSOR.NM_COLUNA || ' IN '|| vCURSOR.T_TYPE || chr(10);
      vSQL_INS_ATR := vSQL_INS_ATR || RPAD(' ',40,' ') ||', '  || vCURSOR.NM_COLUNA  || chr(10);    
      vSQL_INS_VAL := vSQL_INS_VAL || RPAD(' ',40,' ') ||', p' || vCURSOR.NM_COLUNA  || chr(10); 
      
      -- CRIA LINHAS DA PROCEDURE DE SELECAO
      vSQL_SEL_CAB := vSQL_SEL_CAB || RPAD(' ',56,' ') || ',p' || vCURSOR.NM_COLUNA || ' IN '|| vCURSOR.T_TYPE || chr(10);
      vSQL_SEL_ATR := vSQL_SEL_ATR || RPAD(' ',11,' ') ||', '  || vCURSOR.NM_COLUNA  || chr(10);
      vSQL_SEL_WHE := vSQL_SEL_WHE || chr(10) || '      AND (' || vCURSOR.NM_COLUNA || ' = ' || 'p' || vCURSOR.NM_COLUNA ||' OR '|| 'p' || vCURSOR.NM_COLUNA ||' IS NULL )';
                                     
      -- CRIA LINHAS DA PROCEDURE DE UPDATE
      vSQL_UPD_CAB := vSQL_UPD_CAB || RPAD(' ',56,' ') || ',p' || vCURSOR.NM_COLUNA || ' IN '|| vCURSOR.T_TYPE || chr(10);
      vSQL_UPD_ATR := vSQL_UPD_ATR || ' IF p' || vCURSOR.NM_COLUNA ||' IS NOT NULL THEN '           || chr(10);
      vSQL_UPD_ATR := vSQL_UPD_ATR || '    UPDATE ' || vNOME_TABELA                                 || chr(10);    
      vSQL_UPD_ATR := vSQL_UPD_ATR || '    SET ' || vCURSOR.NM_COLUNA || ' = p' ||vCURSOR.NM_COLUNA || chr(10);
      vSQL_UPD_ATR := vSQL_UPD_ATR || '' ||  vSQL_UPD_WHE      || ';'                        || chr(10);
      vSQL_UPD_ATR := vSQL_UPD_ATR || ' END IF; '|| chr(10)|| chr(10);
      
  END LOOP;
  
  -- CONTINUA, COM A CRIACAO DAS CONSTRAINTS
  IF (vSQL is not null) THEN
     vSQL := vSQL || ')' ;
     
   /********************************************************************************************************************************
                       C O N C L U I   P R O C E D U R E   D E   I N S E R C A O
   ********************************************************************************************************************************/   
     vSQL_INS_CAB := vSQL_INS_CAB || RPAD(' ',56,' ') || ', vResult OUT NUMBER ) is' || chr(10) || ' BEGIN '|| chr(10) || chr(10);
     vSQL_INS_ATR := vSQL_INS_ATR || RPAD(' ',40,' ') || ')'  || chr(10) ;
     vSQL_INS_VAL := vSQL_INS_VAL || RPAD(' ',40,' ') || ');' || chr(10) ; 
     
     --JUNTA CABECALHO, ATRIBUTOS E VALORES DA PROCEDURE DE INSERCAO
     vSQL_INS := vSQL_INS_CAB || vSQL_INS_ATR || vSQL_INS_VAL || chr(10) ;
     
     -- FECHA A PROCEDURE DE INSERCAO COM EXCEPTION
     vSQL_INS := vSQL_INS || 'vResult := 1; COMMIT;'                          || chr(10) ;
     vSQL_INS := vSQL_INS || '  EXCEPTION '                                   || chr(10) ;
     vSQL_INS := vSQL_INS || '  WHEN OTHERS THEN '                            || chr(10) ;
     vSQL_INS := vSQL_INS || '     rollback;     '                            || chr(10) ;  
     vSQL_INS := vSQL_INS || '     vResult := -99; -- Erro generico.'         || chr(10) ;  
     vSQL_INS := vSQL_INS || 'END '|| 'APPP_INS' || SUBSTR(vNOME_TABELA,8,18) ||';'      ;  
     
     
  /********************************************************************************************************************************
                        C O N C L U I   P R O C E D U R E    D E   S E L E C A O
   ********************************************************************************************************************************/   
 
     vSQL_SEL_CAB := vSQL_SEL_CAB || RPAD(' ',56,' ') || ',p_cursor    OUT SYS_REFCURSOR   ) is' || chr(10) || ' BEGIN '|| chr(10) || chr(10);
     vSQL_SEL_ATR := vSQL_SEL_ATR || '    FROM ' || vNOME_TABELA  || chr(10) ;
     vSQL_SEL_WHE := vSQL_SEL_WHE || ';'  || chr(10) ; 
     
      --JUNTA CABECALHO, ATRIBUTOS E CONDICOES DA PROCEDURE DE SELECAO
     vSQL_SEL := vSQL_SEL_CAB || vSQL_SEL_ATR || vSQL_SEL_WHE || chr(10) ;
     
     -- FECHA A PROCEDURE DE SELECAO
     vSQL_SEL := vSQL_SEL || 'END '|| 'APPP_SEL' || SUBSTR(vNOME_TABELA,8,18) ||';'; 
     
  /********************************************************************************************************************************
                        C O N C L U I   P R O C E D U R E    D E   D E L E T E
   ********************************************************************************************************************************/   
 
     vSQL_DEL_CAB := vSQL_DEL_CAB || RPAD(' ',56,' ') || ', vResult OUT NUMBER ) is' || chr(10) || ' BEGIN '|| chr(10) || chr(10);
     vSQL_DEL_CAB := vSQL_DEL_CAB || '  vResult := 0;                    '  || chr(10);
     vSQL_DEL_CAB := vSQL_DEL_CAB || '  if pCD_OBJETO is not null then   '  || chr(10)|| chr(10);
     
     vSQL_DEL_CAB := vSQL_DEL_CAB || '     SELECT COUNT(*) INTO vResult  '  || chr(10);
     vSQL_DEL_CAB := vSQL_DEL_CAB || '     FROM ' || vNOME_TABELA           || chr(10); 
     vSQL_DEL_CAB := vSQL_DEL_CAB || '     WHERE CD_OBJETO  = pCD_OBJETO;'  || chr(10)|| chr(10);
     
     vSQL_DEL_CAB := vSQL_DEL_CAB || '     if vResult > 0 then           '  || chr(10);

     --JUNTA CABECALHO, ATRIBUTOS E CONDICOES DA PROCEDURE DE DELETE
     vSQL_DEL := vSQL_DEL_CAB     || vSQL_DEL_ATR || vSQL_DEL_WHE           || chr(10) ;
     
     vSQL_DEL := vSQL_DEL         || '        commit;'                      || chr(10);
         
     vSQL_DEL := vSQL_DEL         || '     end if; '                        || chr(10);  
      
     vSQL_DEL := vSQL_DEL         || '  END IF;'                            || chr(10);
    
    -- FECHA A PROCEDURE DE DELETE
     vSQL_DEL := vSQL_DEL || 'END '|| 'APPP_DEL' || SUBSTR(vNOME_TABELA,8,18) ||';';    
     
  /********************************************************************************************************************************
                       C O N C L U I   P R O C E D U R E   D E   U P D A T E
   ********************************************************************************************************************************/   
     vSQL_UPD_CAB := vSQL_UPD_CAB || RPAD(' ',56,' ') || ', vResult OUT NUMBER ) is' || chr(10) || ' BEGIN '|| chr(10) || chr(10);
          
     --JUNTA CABECALHO, ATRIBUTOS E VALORES DA PROCEDURE DE UPDATE
     vSQL_UPD := vSQL_UPD_CAB || vSQL_UPD_ATR || chr(10) ;
     
     -- FECHA A PROCEDURE DE UPDATE COM EXCEPTION
     vSQL_UPD := vSQL_UPD || '  vResult := 1;'                                || chr(10) ;
     vSQL_UPD := vSQL_UPD || '  COMMIT;  '                                    || chr(10) ;  
     vSQL_UPD := vSQL_UPD || '  EXCEPTION '                                   || chr(10) ;
     vSQL_UPD := vSQL_UPD || '  WHEN OTHERS THEN '                            || chr(10) ;
     vSQL_UPD := vSQL_UPD || '     rollback;     '                            || chr(10) ;  
     vSQL_UPD := vSQL_UPD || '     vResult := -99; -- Erro generico.'         || chr(10) ;  
     vSQL_UPD := vSQL_UPD || 'END '|| 'APPP_UPD' || SUBSTR(vNOME_TABELA,8,18) ||';'      ; 
  
  
  /********************************************************************************************************************************
        C O M E C A   A   E X E C U T A R   O S  C O M A N D O S   D I N A M I C O S
   ********************************************************************************************************************************/   
  
    
     EXECUTE IMMEDIATE vSQL;
     vResult := 1; -- Tabela Criada
     
     vSQL := 'ALTER TABLE ' || vNOME_TABELA || ' ADD CONSTRAINT PK_'|| vNOME_TABELA || ' primary key (CD_OBJETO)';
     EXECUTE IMMEDIATE vSQL;
     vResult := 2; -- PK Criada
     
     vSQL := 'ALTER TABLE ' || vNOME_TABELA || ' ADD CONSTRAINT FK_'|| vNOME_TABELA || ' foreign key (CD_OBJETO) references APPP_TB_OBJETO (CD_OBJETO)';
     EXECUTE IMMEDIATE vSQL;  
     vResult := 3; -- FK Criada
     
     EXECUTE IMMEDIATE vSQL_INS; 
     vResult := 4; -- PROCEDURE INS Criada
     
     EXECUTE IMMEDIATE vSQL_SEL; 
     vResult := 5; -- PROCEDURE SEL Criada
     
     EXECUTE IMMEDIATE vSQL_DEL; 
     vResult := 6; -- PROCEDURE DEL Criada
     
     EXECUTE IMMEDIATE vSQL_UPD;
     vResult := 7; -- PROCEDURE UPD Criada
  END IF; 

EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
  
end APPP_CRIA_TABELA_ESTRUT;
