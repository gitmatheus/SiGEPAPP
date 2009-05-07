/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_TB_TIPO.SQL : Script para criacao da tabela APPP_TB_TIPO
* Author           : WeeDo 
* History          : 16/02/2009 - Matheus Goncalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_TIPO' FROM DUAL;
create table APPP_TB_TIPO
(
  CD_TIPO           number(10) NOT NULL,
  NM_TIPO           VARCHAR2(30)  NOT NULL ,
  DS_EXP_REGULAR    VARCHAR2(160)  NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_TIPO 
alter table APPP_TB_TIPO
  add constraint PK_APPP_TB_TIPO primary key (CD_TIPO);


-- Add/modify columns 
alter table APPP_TB_TIPO rename column DS_EXP_REGULAR to DS_TIPO;
alter table APPP_TB_TIPO modify DS_TIPO varchar2(160);
alter table APPP_TB_TIPO add FL_EXP_REG varchar2(1) default 'N';
-- Add comments to the columns 
comment on column APPP_TB_TIPO.FL_EXP_REG
  is 'É expressão regular? "S" - Sim; "N" - Não';
-- Create/Recreate check constraints 
alter table APPP_TB_TIPO
  add constraint CK_APPP_TB_TIPO01
  check (FL_EXP_REG IN ('S','N'));

alter table APPP_TB_TIPO
  add constraint UK_APPP_TB_TIPO01 UNIQUE (NM_TIPO);

  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_TIPO to admin;
grant select, insert, update, delete, references on APPP_TB_TIPO to usuario;

   -- Sequences
  create sequence APPP_SEQ_TIPO
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_TIPO
  before insert on APPP_TB_TIPO  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_TIPO.NEXTVAL INTO :NEW.CD_TIPO FROM DUAL;
end APPP_TG_BEFINS_TB_TIPO;

  
/
