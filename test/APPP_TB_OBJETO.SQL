/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_TB_OBJETO.SQL : Script para criação da tabela APPP_TB_OBJETO
* Author             : WeeDo 
* History            : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_OBJETO' FROM DUAL;
create table APPP_TB_OBJETO
(
  CD_OBJETO         number(10)    NOT NULL,
  NM_OBJETO         VARCHAR2(40)  NOT NULL ,
  CD_ESTRUTURA      number(10)    NOT NULL,
  DS_OBJETO         VARCHAR2(300) NOT NULL, 
  DT_CRIACAO        DATE DEFAULT  SYSDATE NOT NULL,
  CD_USER_CRIADOR   NUMBER(10)    not null
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_OBJETO 
alter table APPP_TB_OBJETO
  add constraint PK_APPP_TB_OBJETO primary key (CD_OBJETO);

-- Create/Recreate FK_APPP_TB_OBJETO01
alter table APPP_TB_OBJETO
 add constraint FK_APPP_TB_OBJETO01 foreign key (CD_USER_CRIADOR)
  references appp_tb_user (CD_USER);

-- Create/Recreate FK_APPP_TB_OBJETO02
alter table APPP_TB_OBJETO
 add constraint FK_APPP_TB_OBJETO02 foreign key (CD_ESTRUTURA)
  references APPP_TB_ESTRUT_OBJ (CD_ESTRUTURA);  
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_OBJETO to admin;
grant select, insert, update, delete, references on APPP_TB_OBJETO to usuario;  
    -- Sequences
  create sequence APPP_SEQ_OBJETO
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_OBJETO
  before insert on APPP_TB_OBJETO
  FOR EACH ROW
 begin
  SELECT APPP_SEQ_OBJETO.NEXTVAL INTO :NEW.CD_OBJETO FROM DUAL;
 end APPP_TG_BEFINS_TB_OBJETO;
  


/
