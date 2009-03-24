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

-- RECRIA DADOS DE ATRIBUTOS
Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Nome do documento','N','Nome',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Onde o problema é encontrado','N','Contexto',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição do problema','N','Problema',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição da solução','S','Solução',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição de Barreiras','S','Barreiras',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Sintomas para o problema','N','Sintomas',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Consequencias do problema','S','Consequencias',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Recomendações para o problema','S','Recomendações',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição da Persona','S','Descrição',null);

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Nome Usuário' ,'Nome completo do usuário do Pattern',1      ,'S'); 
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Endereço' ,'Nome da Rua do usuário do Pattern'      ,1      ,'S'); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Data de Nascimento' ,'Data de Nascimento do usuário do Pattern' ,4      ,'S'); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('CPF' ,'CPF do Usuário'         ,6      ,'S');  

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ        ,DS_ATRIBUTO_OBJ                  ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Número da Residência' ,'Número da Residência do Usuário',2      ,'S');                           
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('E-mail' ,'E-mail do Usuário'         ,5      ,'S'); 
                           
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('RG' ,'RG do Usuário'           ,9      ,'S');                           

commit;


-- APAGA DADOS DAS ESTRUTURAS
DELETE FROM APPP_TB_ESTRUT_OBJ;

DROP SEQUENCE APPP_SEQ_ESTRUT_OBJ;

   -- Sequences
  create sequence APPP_SEQ_ESTRUT_OBJ
  minvalue 1
  maxvalue 999999999999999
  start with 1
  increment by 1;

-- RECRIA DADOS DAS ESTRUTURAS

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (35140189879,'Pattern Default',SYSDATE,'Pattern','APPP_TB_PATTERN','PA');

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (35140189879,'Anti-Pattern Default',SYSDATE,'Anti-Pattern','APPP_TB_ANTI_PATTERN','AP');

Insert into APPP_TB_ESTRUT_OBJ (CD_USER,DS_ESTRUTURA,DT_CRIACAO,NM_ESTRUTURA,NM_TB_ESTRUT,TP_ESTRUTURA) values (35140189879,'Persona Default',SYSDATE,'Persona','APPP_TB_PERSONA','PE');

COMMIT;

-- RECRIA RELACIONAMENTOS

INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,1); -- PATTERN X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,2); -- PATTERN X CONTEXTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,3); -- PATTERN X PROBLEMA
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,4); -- PATTERN X SOLUCAO

INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,1); -- ANTI-PATTERN X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,2); -- ANTI-PATTERN X CONTEXTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,3); -- ANTI-PATTERN X PROBLEMA
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,4); -- ANTI-PATTERN X SOLUCAO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,5); -- ANTI-PATTERN X BARREIRAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,6); -- ANTI-PATTERN X SINTOMAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,7); -- ANTI-PATTERN X CONSEQUENCIAS

INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,1); -- PERSONA X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,2); -- PERSONA X DESCRICAO
