/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* INS_APPP_TB_ESTADO.SQL : Script para inserir dados na tabela APPP_TB_ESTADO
* Author                 : WeeDo 
* History                : 25/02/2009 - Matheus Gonçalves - Versão Inicial  
***********************************************************************************************************************/
 
 SELECT '(re)Criando sequence APPP_SEQ_ESTADO...' from dual; 
 
 -- Sequences
  drop sequence APPP_SEQ_ESTADO;
 
  create sequence APPP_SEQ_ESTADO
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
 SELECT '(re)Criando trigger APPP_TG_BEFINS_TB_ESTADO...' from dual;  
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_ESTADO
        before insert on APPP_TB_ESTADO  
        FOR EACH ROW
    begin
        SELECT APPP_SEQ_ESTADO.NEXTVAL INTO :NEW.CD_ESTADO FROM DUAL;
    end APPP_TG_BEFINS_TB_ESTADO; 


SELECT '***********************************' from dual;
SELECT '  Inserindo registros dos estados  ' from dual;
SELECT '***********************************' from dual;

insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (1, 'Acre','AC');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (2, 'Alagoas','AL');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (3, 'Amazonas','AM');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (4, 'Amapá','AP');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (5, 'Bahia','BA');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (6, 'Ceará','CE');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (7, 'Distrito Federal','DF');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (8, 'Espírito Santo','ES');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (9, 'Goiás','GO');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (10, 'Maranhão','MA');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (11, 'Minas Gerais','MG');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (12, 'Mato Grosso do Sul','MS');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (13, 'Mato Grosso','MT');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (14, 'Pará','PA');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (15, 'Paraíba','PB');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (16, 'Pernambuco','PE');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (17, 'Piauí','PI');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (18, 'Paraná','PR');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (19, 'Rio de Janeiro','RJ');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (20, 'Rio Grande do Norte','RN');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (21, 'Rondônia','RO');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (22, 'Roraima','RR');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (23, 'Rio Grande do Sul','RS');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (24, 'Santa Catarina','SC');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (25, 'Sergipe','SE');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (26, 'São Paulo','SP');
insert into APPP_TB_ESTADO(CD_ESTADO, NM_ESTADO, SG_SIGLA) VALUES (27, 'Tocantins','TO');

COMMIT;
/
