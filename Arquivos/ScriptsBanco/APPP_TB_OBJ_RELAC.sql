/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_TB_OBJ_RELAC.SQL  : Script para criação da tabela APPP_TB_OBJ_RELAC
* Author                 : WeeDo 
* History                : 16/02/2009 - Matheus Goncalves
*                        : 24/03/2009 - Matheus Goncalves - Criacao de Atributos
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_OBJ_RELAC' FROM DUAL;
create table APPP_TB_OBJ_RELAC
(
  CD_RELAC            NUMBER(10)    NOT NULL,
  CD_OBJ_RELACIONADO  number(10)    NOT NULL,
  CD_OBJ_RELACIONANDO number(10)    NOT NULL, 
  CD_ATRIBUTO_OBJ     NUMBER(10)    NOT NULL,
  VL_RELAC            VARCHAR2(800)
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_OBJ_RELAC
alter table APPP_TB_OBJ_RELAC
  add constraint PK_APPP_TB_OBJ_RELAC primary key (CD_RELAC);

ALTER TABLE APPP_TB_OBJ_RELAC
  ADD CONSTRAINT UK_APPP_TB_OBJ_RELAC01 UNIQUE (CD_OBJ_RELACIONADO,CD_OBJ_RELACIONANDO,CD_ATRIBUTO_OBJ);  

-- Create/Recreate FK_APPP_TB_OBJ_RELAC01
alter table APPP_TB_OBJ_RELAC
 add constraint FK_APPP_TB_OBJ_RELAC01 foreign key (CD_OBJ_RELACIONADO)
  references APPP_TB_OBJETO (CD_OBJETO);
  
-- Create/Recreate FK_APPP_TB_OBJ_RELAC02
alter table APPP_TB_OBJ_RELAC
 add constraint FK_APPP_TB_OBJ_RELAC02 foreign key (CD_OBJ_RELACIONANDO)
  references APPP_TB_OBJETO (CD_OBJETO); 
  
-- Create/Recreate CK_APPP_TB_OBJ_RELAC01
alter table APPP_TB_OBJ_RELAC
 add constraint CK_APPP_TB_OBJ_RELAC01 CHECK (CD_OBJ_RELACIONADO <> CD_OBJ_RELACIONANDO); 
    
-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_OBJ_RELAC to admin;
grant select, insert, update, delete, references on APPP_TB_OBJ_RELAC to usuario;

 -- Sequences
  create sequence APPP_SEQ_OBJ_RELAC
  minvalue 1
  maxvalue 999999999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_OBJ_RELAC
  before insert on APPP_TB_OBJ_RELAC  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_OBJ_RELAC.NEXTVAL INTO :NEW.CD_RELAC FROM DUAL ;
end APPP_TG_BEFINS_TB_OBJ_RELAC;

/
