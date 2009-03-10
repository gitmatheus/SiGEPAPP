/*****************************************************************************************
* Project Name            : SiGEPAPP
* APPP_CRIA_TABELA_ESTRUT : Procedure para cria��o din�mica de tabelas de estrutura.
*                           vResult( 0=Estrutura + Atributos n�o encontrados; 
*                                    1=Tabela Criada; 
*                                    2=PK CRIADA;
*                                    3=FK CRIADA;
*                                    4=PROCEDURE DE INS CRIADA;
*                                    5=PROCEDURE DE SEL CRIADA;  
*                                    -50= TABELA J� EXISTE;
*                                    -99=ErroGeral)
* Author                  : WeeDo 
* History                 : 09/03/2009 - Matheus Gon�alves
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
  
  --VARI�VEIS DE INSER��O
  vSQL_INS     VARCHAR2(2000); -- TODO O SQL
  vSQL_INS_CAB VARCHAR2(2000); -- SQL DO CABE�ALHO
  vSQL_INS_ATR VARCHAR2(2000); -- SQL DOS ATRIBUTOS
  vSQL_INS_VAL VARCHAR2(2000); -- SQL DOS VALORES
  
  
  --VARI�VEIS DE SELE��O
  vSQL_SEL     VARCHAR2(2000);
  vSQL_SEL_CAB VARCHAR2(2000);
  vSQL_SEL_ATR VARCHAR2(2000);
  vSQL_SEL_WHE VARCHAR2(2000);  
  
  --VARI�VEIS DE DELETE
  vSQL_DEL     VARCHAR2(2000);
  vSQL_DEL_CAB VARCHAR2(2000);
  vSQL_DEL_ATR VARCHAR2(2000);
  vSQL_DEL_WHE VARCHAR2(2000); 
  
  --VARI�VEIS DE UPDATE
  vSQL_UPD     VARCHAR2(2000);
  vSQL_UPD_CAB VARCHAR2(2000);
  vSQL_UPD_ATR VARCHAR2(2000);
  vSQL_UPD_WHE VARCHAR2(2000); 
  
  vNOME_TABELA VARCHAR2(60);
  vMAXTAM      VARCHAR2(15);
  vTEMP        VARCHAR2(2);
  
begin
  vResult := 0; -- Inicia zerado.   

  /***************************************************************** 
    ESSE CURSOR � RESPONS�VEL PELA CRIA��O DIN�MICA DA TABELA,
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
            vResult := -50; -- Tabela j� existe
            EXIT;
         END IF;
         
         -- CREATE TABLE - IN�CIO
         vSQL := vSQL || 'CREATE TABLE '|| vNOME_TABELA || '(';
         vSQL := vSQL || 'CD_OBJETO NUMBER(10) NOT NULL';  
         
         -- CREATE PROCEDURE INS -- IN�CIO
         vSQL_INS_CAB := 'create or replace procedure ' || 'APPP_INS' || SUBSTR(vNOME_TABELA,8,18) || '( pCD_OBJETO IN NUMBER ' || chr(10);
         vSQL_INS_ATR := '   INSERT INTO '|| vNOME_TABELA || '(CD_OBJETO ' || chr(10);
         vSQL_INS_VAL := RPAD(' ',33,' ') || 'VALUES (pCD_OBJETO '  || chr(10); 
         
         
         -- CREATE PROCEDURE SEL -- IN�CIO
         vSQL_SEL_CAB := 'create or replace procedure ' || 'APPP_SEL' || SUBSTR(vNOME_TABELA,8,18) || '( pCD_OBJETO IN NUMBER ' || chr(10);
         vSQL_SEL_ATR :=                  '    open p_cursor FOR' || chr(10);
         vSQL_SEL_ATR :=  vSQL_SEL_ATR || '    SELECT CD_OBJETO ' || chr(10);
         vSQL_SEL_WHE :=                  '    WHERE (CD_OBJETO = pCD_OBJETO OR pCD_OBJETO IS NULL)';
         
         -- CREATE PROCEDURE DEL -- IN�CIO
         vSQL_DEL_CAB := 'create or replace procedure ' || 'APPP_DEL' || SUBSTR(vNOME_TABELA,8,18) || '( pCD_OBJETO IN NUMBER ' || chr(10);
         
       end if;
       
      -- DEFINE O TAMANHO M�XIMO DO CAMPO DE ACORDO COM SEU TIPO
      if    vCURSOR.T_TYPE = 'NUMBER' THEN 
            vMAXTAM := '(15)';
      ELSIF vCURSOR.T_TYPE = 'VARCHAR2' THEN 
            vMAXTAM := '(3000)';
      ELSE       
            vMAXTAM := '';
      END IF;
      
     -- INSERE O ATRIBUTO NO COMANDO DIN�MICO.
      vSQL := vSQL || ', ' ||vCURSOR.NM_COLUNA|| ' '||vCURSOR.T_TYPE||vMAXTAM || ' NOT NULL ';   

      -- CRIA LINHAS DA PROCEDURE DE INSER��O
      vSQL_INS_CAB := vSQL_INS_CAB || RPAD(' ',50,' ') || ',p' || vCURSOR.NM_COLUNA || ' IN '|| vCURSOR.T_TYPE || chr(10);
      vSQL_INS_ATR := vSQL_INS_ATR || RPAD(' ',40,' ') ||', '  || vCURSOR.NM_COLUNA  || chr(10);    
      vSQL_INS_VAL := vSQL_INS_VAL || RPAD(' ',40,' ') ||', p' || vCURSOR.NM_COLUNA  || chr(10); 
      
      -- CRIA LINHAS DA PROCEDURE DE SELE��O
      vSQL_SEL_CAB := vSQL_SEL_CAB || RPAD(' ',50,' ') || ',p' || vCURSOR.NM_COLUNA || ' IN '|| vCURSOR.T_TYPE || chr(10);
      vSQL_SEL_ATR := vSQL_SEL_ATR || RPAD(' ',11,' ') ||', '  || vCURSOR.NM_COLUNA  || chr(10);
      vSQL_SEL_WHE := vSQL_SEL_WHE || chr(10) || '      AND (' || vCURSOR.NM_COLUNA || ' = ' || 'p' || vCURSOR.NM_COLUNA ||' OR '|| 'p' || vCURSOR.NM_COLUNA ||' IS NULL )';
                                     
      
  END LOOP;
  
  -- CONTINUA, COM A CRIA��O DAS CONSTRAINTS
  IF (vSQL is not null) THEN
     vSQL := vSQL || ')' ;
     
   /********************************************************************************************************************************
                       C O N C L U I   P R O C E D U R E   D E   I N S E R � � O
   ********************************************************************************************************************************/   
     vSQL_INS_CAB := vSQL_INS_CAB || RPAD(' ',53,' ') || ', vResult OUT NUMBER ) is' || chr(10) || ' BEGIN '|| chr(10) || chr(10);
     vSQL_INS_ATR := vSQL_INS_ATR || RPAD(' ',40,' ') || ')'  || chr(10) ;
     vSQL_INS_VAL := vSQL_INS_VAL || RPAD(' ',40,' ') || ');' || chr(10) ; 
     
     --JUNTA CABE�ALHO, ATRIBUTOS E VALORES DA PROCEDURE DE INSER��O
     vSQL_INS := vSQL_INS_CAB || vSQL_INS_ATR || vSQL_INS_VAL || chr(10) ;
     
     -- FECHA A PROCEDURE DE INSER��O COM EXCEPTION
     vSQL_INS := vSQL_INS || 'vResult := 1; COMMIT;'                          || chr(10) ;
     vSQL_INS := vSQL_INS || '  EXCEPTION '                                   || chr(10) ;
     vSQL_INS := vSQL_INS || '  WHEN OTHERS THEN '                            || chr(10) ;
     vSQL_INS := vSQL_INS || '     rollback;     '                            || chr(10) ;  
     vSQL_INS := vSQL_INS || '     vResult := -99; -- Erro gen�rico.'         || chr(10) ;  
     vSQL_INS := vSQL_INS || 'END '|| 'APPP_INS' || SUBSTR(vNOME_TABELA,8,18) ||';'      ;  
     
     
  /********************************************************************************************************************************
                        C O N C L U I   P R O C E D U R E    D E   S E L E � � O
   ********************************************************************************************************************************/   
 
     vSQL_SEL_CAB := vSQL_SEL_CAB || RPAD(' ',50,' ') || 'p_cursor    OUT SYS_REFCURSOR   ) is' || chr(10) || ' BEGIN '|| chr(10) || chr(10);
     vSQL_SEL_ATR := vSQL_SEL_ATR || RPAD(' ',11,' ') || ')'  || chr(10) ;
     vSQL_SEL_WHE := vSQL_SEL_WHE || ';'  || chr(10) ; 
     
      --JUNTA CABE�ALHO, ATRIBUTOS E CONDI��ES DA PROCEDURE DE SELE��O
     vSQL_SEL := vSQL_SEL_CAB || vSQL_SEL_ATR || vSQL_SEL_WHE || chr(10) ;
     
     -- FECHA A PROCEDURE DE SELE��O
     vSQL_SEL := vSQL_SEL || 'END '|| 'APPP_SEL' || SUBSTR(vNOME_TABELA,8,18) ||';'; 
     
 /********************************************************************************************************************************
        C O M E � A   A   E X E C U T A R   O S  C O M A N D O S   D I N � M I C O S
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
     
  END IF; 

  EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
       
  
end APPP_CRIA_TABELA_ESTRUT;
