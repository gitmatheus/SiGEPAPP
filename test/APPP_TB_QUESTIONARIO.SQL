/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_QUESTIONARIO.SQL : Script para criação da tabela APPP_TB_QUESTIONARIO
* Author                   : WeeDo 
* History                  : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_QUESTIONARIO' FROM DUAL;

create table APPP_TB_QUESTIONARIO
(
  CD_QUEST        number(10)           NOT NULL,
  DT_APLICACAO    DATE DEFAULT SYSDATE NOT NULL ,
  VL_AVALIACAO    NUMBER(5,2)                   ,
  DS_PROJ_APLIC   VARCHAR2(60)                  ,
  CD_USER         NUMBER(15)           NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_QUESTIONARIO 
alter table APPP_TB_QUESTIONARIO
  add constraint PK_APPP_TB_QUESTIONARIO primary key (CD_QUEST);

-- Create/Recreate FK_APPP_TB_QUESTIONARIO01 
alter table APPP_TB_QUESTIONARIO
 add constraint FK_APPP_TB_QUESTIONARIO01 foreign key (CD_USER)
  references APPP_TB_USER (CD_USER);

  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_QUESTIONARIO to admin;
grant select, insert, update, delete, references on APPP_TB_QUESTIONARIO to usuario;

 
   -- Sequences
  create sequence APPP_SEQ_QUESTIONARIO
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_QUESTIONARIO
  before insert on APPP_TB_QUESTIONARIO  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_QUESTIONARIO.NEXTVAL into :NEW.CD_QUEST from dual;

end APPP_TG_BEFINS_TB_QUESTIONARIO;


/
