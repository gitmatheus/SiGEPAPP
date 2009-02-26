/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_TB_LOGIN.SQL : Script para criação da tabela APPP_TB_LOGIN
* Author            : WeeDo 
* History           : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_LOGIN' FROM DUAL;
create table APPP_TB_LOGIN
(
  CD_USER           number(15) NOT NULL,
  NM_LOGIN          varchar2(30) NOT NULL,
  PW_SENHA          varchar2(30) NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_LOGIN
  add constraint PK_APPP_TB_LOGIN primary key (CD_USER);

alter table APPP_TB_LOGIN
 add constraint FK_APPP_TB_LOGIN foreign key (CD_USER)
  references appp_tb_user (CD_USER);
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_LOGIN to admin;
grant select, insert, update, delete, references on APPP_TB_LOGIN to usuario;

/
