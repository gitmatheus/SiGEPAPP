/**********************************************************************************************************************
* Project Name                  : SiGEPAPP
* 99-INS_RELAC_ATRIB_ESTRUT.SQL : Script EMERGENCIAL para insert de dados de estrutura x atributos
* Author                        : WeeDo
* History                       : 24/03/2009 - Matheus Gonçalves - Versão Inicial
***********************************************************************************************************************
*
*  A T E N Ç Ã O - ESSE SCRIPT APAGA TODOS OS RELACIONAMENTOS EXISTENTES. CUIDADO!
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
      values (1,'Onde o problema é encontrado','N','Contexto','DS_DESCRICAO');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descrição do problema','N','Problema','DS_PROBLEMA');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descrição da solução','N','Solução','DS_SOLUCAO');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Descrição de Barreiras','N','Barreiras','DS_BARREIRAS');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Sintomas para o problema','N','Sintomas','DS_SINTOMAS');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Consequencias do problema','N','Consequencias','DS_CONSEQUEN');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Recomendações para o problema','N','Recomendações','DS_RECOMEN');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA)
      values (1,'Url para utilização de imagens','N','Foto','URL_FOTO');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('Data' ,'Data' ,4      ,'N');


insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('CPF' ,'CPF'         ,8      ,'N');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('E-mail' ,'E-mail'         ,7      ,'N');

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC)
                          VALUES('RG' ,'RG'           ,11      ,'N');

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

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (11111111111,'Estrutura Minima Pattern',SYSDATE,'Pattern','APPP_TB_PATTERN','PA');

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (11111111111,'Estrutura Minima Anti-Pattern',SYSDATE,'Anti-Pattern','APPP_TB_ANTI_PATTERN','AP');

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (11111111111,'Estrutura Minima Persona',SYSDATE,'Persona','APPP_TB_PERSONA','PE');

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
