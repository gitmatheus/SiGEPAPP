-- estado (cod_est, nome, sigla)

/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_TB_ESTADO.SQL : Script para criação da tabela APPP_TB_ESTADO
* Author             : WeeDo 
* History            : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_ESTADO' FROM DUAL;
create table APPP_TB_ESTADO
(
  CD_ESTADO        NUMBER(5)    NOT NULL,
  NM_ESTADO        VARCHAR2(30) NOT NULL,
  SG_SIGLA         VARCHAR2(3)  NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_ESTADO
  add constraint PK_APPP_TB_ESTADO primary key (CD_ESTADO);
  

  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ESTADO to admin;
grant select, insert, update, delete, references on APPP_TB_ESTADO to usuario;

/
  
