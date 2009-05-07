/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_ATRIBUTO_OBJ.SQL : Script para criacao da tabela APPP_TB_ATRIBUTO_OBJ
* Author                   : WeeDo 
* History                  : 16/02/2009 - Matheus Goncalves - Versão Inicial
*                          : 26/02/2009 - Matheus Goncalves - Drop column DS_TAM_ATRIB 
*                          : 06/03/2009 - Matheus Goncalves - Drop column DS_TAM_ATRIB NOVAMENTE 
*                          : 09/03/2009 - Matheus Goncalves - Create Column NM_COLUNA
*                          : 06/05/2009 - Matheus Goncalves - UK NM_ATRIBUTO_OBJ
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_ATRIBUTO_OBJ' FROM DUAL;
create table APPP_TB_ATRIBUTO_OBJ
(
  CD_ATRIBUTO_OBJ number(10)    NOT NULL,
  NM_ATRIBUTO_OBJ VARCHAR2(40)  NOT NULL ,
  DS_ATRIBUTO_OBJ VARCHAR2(2000)          , 
  CD_TIPO         NUMBER(10)    NOT NULL ,
  FL_ATRIB_RELAC  VARCHAR2(1)   DEFAULT 'S' NOT NULL,
  NM_COLUNA       VARCHAR2(15)
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Add comments to the columns 
comment on column APPP_TB_ATRIBUTO_OBJ.FL_ATRIB_RELAC
  is '"S" - Relacionável ; "N" - Não relacionável';
  
-- Create/Recreate PK_APPP_TB_ATRIBUTO_OBJ 
alter table APPP_TB_ATRIBUTO_OBJ
  add constraint PK_APPP_TB_ATRIBUTO_OBJ primary key (CD_ATRIBUTO_OBJ);

-- Create/Recreate FK_APPP_TB_ATRIBUTO_OBJ01 
alter table APPP_TB_ATRIBUTO_OBJ
 add constraint FK_APPP_TB_ATRIBUTO_OBJ01 foreign key (CD_TIPO)
  references APPP_TB_TIPO (CD_TIPO);

-- Create/Recreate check constraints
alter table APPP_TB_ATRIBUTO_OBJ
 add constraint CK_APPP_TB_ATRIBUTO_OBJ check (FL_ATRIB_RELAC in ('S','N'));

alter table APPP_TB_ATRIBUTO_OBJ
  add constraint UK_APPP_TB_ATRIBUTO_OBJ01 unique (NM_COLUNA); 

alter table APPP_TB_ATRIBUTO_OBJ
  add constraint UK_APPP_TB_ATRIBUTO_OBJ02 unique (NM_ATRIBUTO_OBJ); 
		
-- Drop columns 
alter table APPP_TB_ATRIBUTO_OBJ drop column DS_TAM_ATRIB;
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ATRIBUTO_OBJ to admin;
grant select, insert, update, delete, references on APPP_TB_ATRIBUTO_OBJ to usuario;

   -- Sequences
  create sequence APPP_SEQ_ATRIBUTO_OBJ
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_ATRIBUTO_OBJ
  before insert on APPP_TB_ATRIBUTO_OBJ  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_ATRIBUTO_OBJ.NEXTVAL INTO :NEW.CD_ATRIBUTO_OBJ FROM DUAL;
end APPP_TG_BEFINS_TB_ATRIBUTO_OBJ;

 
/

