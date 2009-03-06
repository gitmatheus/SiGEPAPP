/**********************************************************************************************************************
* Project Name        : SiGEPAPP
* APPP_TB_PATTERN.SQL : Script para criação da tabela APPP_TB_PATTERN
* Author              : WeeDo 
* History             : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table 
SELECT 'Criando a tabela APPP_TB_PATTERN' FROM DUAL;
create table APPP_TB_PATTERN
(
  CD_PATTERN        number(10)     NOT NULL,
  DS_PAT_PROBLEMA   VARCHAR2(300)  NOT NULL ,
  DS_PAT_SOLUCAO    VARCHAR2(300)   
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_PATTERN 
alter table APPP_TB_PATTERN
  add constraint PK_APPP_TB_PATTERN primary key (CD_PATTERN);

-- Create/Recreate FK_APPP_TB_PATTERN 
alter table APPP_TB_PATTERN
 add constraint FK_APPP_TB_PATTERN foreign key (CD_PATTERN)
  references APPP_TB_OBJETO (CD_OBJETO);
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_PATTERN to admin;
grant select, insert, update, delete, references on APPP_TB_PATTERN to usuario;


/
