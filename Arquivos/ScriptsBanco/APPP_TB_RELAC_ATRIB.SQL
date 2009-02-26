/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_RELAC_ATRIB.SQL : Script para criação da tabela APPP_TB_RELAC_ATRIB
* Author                   : WeeDo 
* History                  : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_RELAC_ATRIB' FROM DUAL;
create table APPP_TB_RELAC_ATRIB
(
   CD_RELAC      number(10) NOT NULL ,
   CD_ATRIBUTO   number(10) NOT NULL ,
   VL_RELAC      VARCHAR2(100) NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_RELAC_ATRIB 
alter table APPP_TB_RELAC_ATRIB
  add constraint PK_APPP_TB_RELAC_ATRIB primary key (CD_RELAC);

-- Create/Recreate FK_APPP_TB_RELAC_ATRIB01 
alter table APPP_TB_RELAC_ATRIB
 add constraint FK_APPP_TB_RELAC_ATRIB01 foreign key (CD_ATRIBUTO)
  references APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ);

   
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_RELAC_ATRIB to admin;
grant select, insert, update, delete, references on APPP_TB_RELAC_ATRIB to usuario;

   -- Sequences
  create sequence APPP_SEQ_RELAC_ATRIB
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_RELAC_ATRIB
  before insert on APPP_TB_RELAC_ATRIB  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_RELAC_ATRIB.NEXTVAL INTO :NEW.CD_RELAC FROM DUAL;
end APPP_TG_BEFINS_TB_RELAC_ATRIB;


/

