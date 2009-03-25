/**********************************************************************************************************************
* Project Name                : SiGEPAPP
* APPP_TB_RELAC_QUEST_OBJ.SQL : Script para criação da tabela APPP_TB_RELAC_QUEST_OBJ
* Author                      : WeeDo 
* History                     : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_RELAC_QUEST_OBJ' FROM DUAL;

create table APPP_TB_RELAC_QUEST_OBJ
(
  CD_QUEST_PREENCH  number(10)  NOT NULL,
  CD_QUEST          number(10)  NOT NULL,
  CD_OBJETO         number(10)  NOT NULL,         
  CD_USER           NUMBER(15)  NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_RELAC_QUEST_OBJ 
alter table APPP_TB_RELAC_QUEST_OBJ
  add constraint PK_APPP_TB_RELAC_QUEST_OBJ primary key (CD_QUEST_PREENCH);
  
ALTER TABLE APPP_TB_RELAC_QUEST_OBJ
  ADD CONSTRAINT UK_APPP_TB_RELAC_QUEST_OBJ01 UNIQUE (CD_QUEST,CD_OBJETO,CD_USER);

-- Create/Recreate FK_APPP_TB_RELAC_QUEST_OBJ01 
alter table APPP_TB_RELAC_QUEST_OBJ
 add constraint FK_APPP_TB_RELAC_QUEST_OBJ01 foreign key (CD_USER)
  references APPP_TB_USER (CD_USER);
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_RELAC_QUEST_OBJ to admin;
grant select, insert, update, delete, references on APPP_TB_RELAC_QUEST_OBJ to usuario;

 
   -- Sequences
  create sequence APPP_SEQ_RELAC_QUEST_OBJ
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_BEFINS_TB_RELAC_QUESTOBJ
  before insert on APPP_TB_RELAC_QUEST_OBJ  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_RELAC_QUEST_OBJ.NEXTVAL into :NEW.CD_QUEST_PREENCH from dual;

end APPP_BEFINS_TB_RELAC_QUESTOBJ;


/
