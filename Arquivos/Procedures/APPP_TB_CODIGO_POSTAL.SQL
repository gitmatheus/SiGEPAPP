/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_CODIGO_POSTAL.SQL : Script para criação da tabela APPP_TB_CODIGO_POSTAL
* Author                    : WeeDo 
* History                   : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_CODIGO_POSTAL' FROM DUAL;
create table APPP_TB_CODIGO_POSTAL
(
  CD_CEP            number(6)    NOT NULL,
  NM_RUA            VARCHAR2(30) NOT NULL, 
  CD_CIDADE         NUMBER(5)    NOT NULL,
  CD_ESTADO         NUMBER(5)    NOT NULL
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_CODIGO_POSTAL
  add constraint PK_APPP_TB_CODIGO_POSTAL primary key (CD_CEP);

alter table APPP_TB_CODIGO_POSTAL
 add constraint FK_APPP_TB_CODIGO_POSTAL01 foreign key (CD_CIDADE)
  references APPP_TB_CIDADE(CD_CIDADE);
  
alter table APPP_TB_CODIGO_POSTAL
 add constraint FK_APPP_TB_CODIGO_POSTAL02 foreign key (CD_ESTADO)
  references APPP_TB_ESTADO(CD_ESTADO);  

  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_CODIGO_POSTAL to admin;
grant select, insert, update, delete, references on APPP_TB_CODIGO_POSTAL to usuario;

/
