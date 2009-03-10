/*****************************************************************************************
* Project Name            : SiGEPAPP
* APPP_CRIA_TABELA_ESTRUT : Procedure para criação dinâmica de tabelas de estrutura.
*                           vResult( 0=Estrutura + Atributos não encontrados; 
*                                    1=Tabela Criada; 
*                                    2=PK CRIADA;
*                                    3=FK CRIADA;
*                                    -50= TABELA JÁ EXISTE;
*                                    -99=ErroGeral)
* Author                  : WeeDo 
* History                 : 09/03/2009 - Matheus Gonçalves
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
  vNOME_TABELA VARCHAR2(60);
  vMAXTAM      VARCHAR2(15);
  vTEMP        VARCHAR2(2);
  
begin
  vResult := 0; -- Inicia zerado.   

  /***************************************************************** 
    ESSE CURSOR É RESPONSÁVEL PELA CRIAÇÃO DINÂMICA DA TABELA,
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
            vResult := -50;
            EXIT;
         END IF;
         
         
         vSQL := vSQL || 'CREATE TABLE '|| vNOME_TABELA || '(';
         vSQL := vSQL || 'CD_ESTRUTURA NUMBER(10) NOT NULL';  
       end if;
      -- DEFINE O TAMANHO MÁXIMO DO CAMPO DE ACORDO COM SEU TIPO
      if    vCURSOR.T_TYPE = 'NUMBER' THEN 
            vMAXTAM := '(15)';
      ELSIF vCURSOR.T_TYPE = 'VARCHAR2' THEN 
            vMAXTAM := '(3000)';
      ELSE       
            vMAXTAM := '';
      END IF;
     -- INSERE O ATRIBUTO NO COMANDO DINÂMICO.
      vSQL := vSQL || ', ' ||vCURSOR.NM_COLUNA|| ' '||vCURSOR.T_TYPE||vMAXTAM || ' NOT NULL ';   
  END LOOP;
  
  -- CONTINUA, COM A CRIAÇÃO DAS CONSTRAINTS
  IF (vSQL is not null) THEN
     vSQL := vSQL || ')' ;
     EXECUTE IMMEDIATE vSQL;
     
     vResult := 1; -- Tabela Criada

     vSQL := 'ALTER TABLE ' || vNOME_TABELA || ' ADD CONSTRAINT PK_'|| vNOME_TABELA || ' primary key (CD_ESTRUTURA)';
     EXECUTE IMMEDIATE vSQL;
     
     vResult := 2; -- PK Criada
     
     vSQL := 'ALTER TABLE ' || vNOME_TABELA || ' ADD CONSTRAINT FK_'|| vNOME_TABELA || ' foreign key (CD_ESTRUTURA) references APPP_TB_ESTRUT_OBJ (CD_ESTRUTURA)';
     EXECUTE IMMEDIATE vSQL;
     
     vResult := 3; -- PK Criada
  END IF; 

  EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
       
  
end APPP_CRIA_TABELA_ESTRUT;
