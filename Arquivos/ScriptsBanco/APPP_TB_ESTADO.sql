-- estado (cod_est, nome, sigla)

/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_TB_ESTADO.SQL : Script para criação da tabela APPP_TB_ESTADO
* Author             : WeeDo 
* History            : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_ESTADO' FROM DUAL;
create table APPP_TB_ESTADO
(
  CD_ESTADO        NUMBER(5)    NOT NULL,
  NM_ESTADO        VARCHAR2(30) NOT NULL,
  SG_SIGLA         VARCHAR2(3)  NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_ESTADO
  add constraint PK_APPP_TB_ESTADO primary key (CD_ESTADO);
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ESTADO to admin;
grant select, insert, update, delete, references on APPP_TB_ESTADO to usuario;

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


/
  
