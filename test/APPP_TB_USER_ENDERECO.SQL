/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_USER_ENDERECO.SQL : Script para criação da tabela APPP_TB_USER_ENDERECO
* Author                    : WeeDo 
* History                   : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_USER_ENDERECO' FROM DUAL;
create table APPP_TB_USER_ENDERECO
(
  CD_USER           number(15) NOT NULL,
  NR_CEP            NUMBER(6)  NOT NULL ,
  NR_NUMERO         NUMBER(8)  NOT NULL, 
  DS_COMPLEMENTO    VARCHAR2(20),
  TP_ENDERECO       varchar2(2) NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Add comments to the columns 
comment on column APPP_TB_USER_ENDERECO.TP_ENDERECO
  is '"R" é endereço residencial; "C" é o comercial; "O" usado para outro endereço';
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_USER_ENDERECO
  add constraint PK_APPP_TB_USER_ENDERECO primary key (CD_USER,NR_CEP,NR_NUMERO,DS_COMPLEMENTO);

alter table APPP_TB_USER_ENDERECO
 add constraint FK_APPP_TB_USER_ENDERECO_USER foreign key (CD_USER)
  references appp_tb_user (CD_USER);
  
alter table APPP_TB_USER_ENDERECO
 add constraint FK_APPP_TB_USER_ENDERECO_CEP foreign key (NR_CEP)
  references APPP_TB_CODIGO_POSTAL(CD_CEP);
  
-- Create/Recreate check constraints
alter table APPP_TB_USER_ENDERECO
 add constraint CK_APPP_TB_USER_ENDERECO check (TP_ENDERECO in ('R','C','O'));
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_USER_ENDERECO to admin;
grant select, insert, update, delete, references on APPP_TB_USER_ENDERECO to usuario;

/
