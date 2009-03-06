/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_TB_USER_EMAIL.SQL : Script para criação da tabela APPP_TB_USER_EMAIL
* Author                 : WeeDo 
* History                : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_USER_EMAIL' FROM DUAL;
create table APPP_TB_USER_EMAIL
(
  CD_USER           number(15) NOT NULL,
  NM_EMAIL          varchar2(30) NOT NULL,
  TP_EMAIL          varchar2(2) NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Add comments to the columns 
comment on column APPP_TB_USER_EMAIL.TP_EMAIL
  is '"P" é e-mail primário; "S" é o e-mail secundário; "O" usado para outro e-mail';

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_USER_EMAIL
  add constraint PK_APPP_TB_USER_EMAIL primary key (CD_USER,NM_EMAIL);

alter table APPP_TB_USER_EMAIL
 add constraint FK_APPP_TB_USER_EMAIL foreign key (CD_USER)
  references appp_tb_user (CD_USER);
  
-- Create/Recreate check constraints
alter table APPP_TB_USER_EMAIL
 add constraint CK_APPP_TB_USER_EMAIL check (TP_EMAIL in ('P','S','O'));
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_USER_EMAIL to admin;
grant select, insert, update, delete, references on APPP_TB_USER_EMAIL to usuario;

/
