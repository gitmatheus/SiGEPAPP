
/**********************************************************************************************************************
* Project Name     : SiGEPAPP
* APPP_TB_USER.SQL : Script para criação da tabela APPP_TB_USER
* Author           : WeeDo 
* History          : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_USER' FROM DUAL;
create table APPP_TB_USER
(
  CD_USER           number(15),
  NM_PRIM_NOME      varchar2(30),
  NM_ULT_NOME       varchar2(30),
  DT_NASC           date,
  NR_NOTA           number(10,2),
  DT_CADASTRO       date default SYSDATE,
  DS_AREA_INTERESSE varchar2(100),
  NM_MSN            varchar2(60),
  NM_SKYPE          varchar2(30)
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column APPP_TB_USER.NM_PRIM_NOME
  is 'Cadastrar apenas o(s) Nome(s)';
comment on column APPP_TB_USER.NM_ULT_NOME
  is 'Cadastrar o(s) sobrenome(s)';
comment on column APPP_TB_USER.CD_USER
  is 'Cadastrar CPF do usuário.';

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_USER
  add constraint PK_APPP_TB_USER primary key (CD_USER);

-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_USER to admin;
grant select, insert, update, delete, references on APPP_TB_USER to usuario;

/
