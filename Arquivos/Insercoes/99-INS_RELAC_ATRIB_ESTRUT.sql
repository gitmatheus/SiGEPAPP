/**********************************************************************************************************************
* Project Name                  : SiGEPAPP
* 99-INS_RELAC_ATRIB_ESTRUT.SQL : Script EMERGENCIAL para insert de dados de estrutura x atributos
* Author                        : WeeDo
* History                       : 24/03/2009 - Matheus Gon�alves - Vers�o Inicial
***********************************************************************************************************************
*
*  A T E N � � O - ESSE SCRIPT APAGA TODOS OS RELACIONAMENTOS EXISTENTES. CUIDADO!
*
***********************************************************************************************************************/

-- APAGA DADOS DE RELACIONAMENTOS EXISTENTES.
delete from appp_tb_atrib_estrutura;

COMMIT;

-- APAGA DADOS DE ATRIBUTOS
delete from appp_tb_atributo_obj;

drop sequence APPP_SEQ_ATRIBUTO_OBJ;

  create sequence APPP_SEQ_ATRIBUTO_OBJ
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;

COMMIT;

-- RECRIA DADOS DE ATRIBUTOS
Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Nome do documento','N','Nome','NM_NOME');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Onde o problema � encontrado','N','Contexto','DS_DESCRICAO');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descri��o do problema','N','Problema','DS_PROBLEMA');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descri��o da solu��o','S','Solu��o','DS_SOLUCAO');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descri��o de Barreiras','S','Barreiras','DS_BARREIRAS');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Sintomas para o problema','N','Sintomas','DS_SINTOMAS');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Consequencias do problema','S','Consequencias','DS_CONSEQUEN');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Recomenda��es para o problema','S','Recomenda��es','DS_RECOMEN');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Url para a foto utilizada na Persona','N','Foto','URL_FOTO');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descri��o da Persona','S','Descri��o','DS_DESCRICAO_P');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('Nome Usu�rio' ,'Nome completo do usu�rio do Pattern',1      ,'S');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('Endere�o' ,'Nome da Rua do usu�rio do Pattern'      ,1      ,'S');


insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('Data de Nascimento' ,'Data de Nascimento do usu�rio do Pattern' ,4      ,'S');


insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('CPF' ,'CPF do Usu�rio'         ,6      ,'S');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ        ,DS_ATRIBUTO_OBJ                  ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('N�mero da Resid�ncia' ,'N�mero da Resid�ncia do Usu�rio',2      ,'S');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('E-mail' ,'E-mail do Usu�rio'         ,5      ,'S');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('RG' ,'RG do Usu�rio'           ,9      ,'S');

COMMIT;


-- APAGA DADOS DAS ESTRUTURAS
DELETE FROM APPP_TB_ESTRUT_OBJ;

DROP SEQUENCE APPP_SEQ_ESTRUT_OBJ;

   -- Sequences
  create sequence APPP_SEQ_ESTRUT_OBJ
  minvalue 1
  maxvalue 999999999999999
  start with 1
  increment by 1;

commit;

-- RECRIA DADOS DAS ESTRUTURAS

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (35140189879,'Pattern Default',SYSDATE,'Pattern','APPP_TB_PATTERN','PA');

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (35140189879,'Anti-Pattern Default',SYSDATE,'Anti-Pattern','APPP_TB_ANTI_PATTERN','AP');

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (35140189879,'Persona Default',SYSDATE,'Persona','APPP_TB_PERSONA','PE');

COMMIT;

-- RECRIA RELACIONAMENTOS

-- PATTERN X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,1);
-- PATTERN X CONTEXTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,2);
-- PATTERN X PROBLEMA
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,3);
-- PATTERN X SOLUCAO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,4);

-- ANTI-PATTERN X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,1);
-- ANTI-PATTERN X CONTEXTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,2);
-- ANTI-PATTERN X PROBLEMA
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,3);
-- ANTI-PATTERN X BARREIRAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,5);
-- ANTI-PATTERN X SINTOMAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,6);
-- ANTI-PATTERN X CONSEQUENCIAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,7);
-- ANTI-PATTERN X RECOMENDACOES
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,8);

-- PERSONA X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,1);
-- PERSONA X DESCRICAO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,2);
-- PERSONA X FOTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,9);

COMMIT;

/
