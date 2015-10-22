/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_USER_TELEFONE.SQL : Script para criação da tabela APPP_TB_USER_TELEFONE
* Author                    : WeeDo 
* History                   : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_USER_TELEFONE' FROM DUAL;
create table APPP_TB_USER_TELEFONE
(
  CD_USER           number(15) NOT NULL,
  NR_DDI            NUMBER(3)  DEFAULT 55 NOT NULL ,
  NR_DDD            NUMBER(3)  NOT NULL, 
  NR_TELEFONE       NUMBER(15) NOT NULL,
  TP_TELEFONE       varchar2(2) NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Add comments to the columns 
comment on column APPP_TB_USER_TELEFONE.TP_TELEFONE
  is '"R" é telefone residencial; "C" é o telefone comercial; "O" usado para outro telefone';

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_USER_TELEFONE
  add constraint PK_APPP_TB_USER_TELEFONE primary key (CD_USER,NR_DDI,NR_DDD,NR_TELEFONE);

alter table APPP_TB_USER_TELEFONE
 add constraint FK_APPP_TB_USER_TELEFONE foreign key (CD_USER)
  references appp_tb_user (CD_USER);
  
-- Create/Recreate check constraints
alter table APPP_TB_USER_TELEFONE
 add constraint CK_APPP_TB_USER_TELEFONE check (TP_TELEFONE in ('R','C','O'));
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_USER_TELEFONE to admin;
grant select, insert, update, delete, references on APPP_TB_USER_TELEFONE to usuario;

/
