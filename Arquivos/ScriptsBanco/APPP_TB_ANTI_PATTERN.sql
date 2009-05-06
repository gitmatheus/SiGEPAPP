/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_ANTI_PATTERN.SQL : Script para criacao da tabela APPP_TB_ANTI_PATTERN
* Author                   : WeeDo 
* History                  : 16/02/2009 - Matheus Goncalves
*                          : 06/05/2009 - Matheus Goncalves - Adicao do campo DS_PROBLEMA
***********************************************************************************************************************/

-- Create table 
SELECT 'Criando a tabela APPP_TB_ANTI_PATTERN' FROM DUAL;
create table APPP_TB_ANTI_PATTERN
(
  CD_ANTI_PATTERN   number(10)     NOT NULL,
  DS_SINTOMAS       VARCHAR2(2000)  NOT NULL ,
  DS_RECOMENDACOES  VARCHAR2(2000)           ,
  DS_CONSEQUENCIAS  VARCHAR2(2000)           ,
  DS_BARREIRAS      VARCHAR2(2000)           ,
	DS_PROBLEMA       VARCHAR2(2000)   
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_ANTI_PATTERN 
alter table APPP_TB_ANTI_PATTERN
  add constraint PK_APPP_TB_ANTI_PATTERN primary key (CD_ANTI_PATTERN);

-- Create/Recreate FK_APPP_TB_ANTI_PATTERN 
alter table APPP_TB_ANTI_PATTERN
 add constraint FK_APPP_TB_ANTI_PATTERN foreign key (CD_ANTI_PATTERN)
  references APPP_TB_OBJETO (CD_OBJETO);
  
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ANTI_PATTERN to admin;
grant select, insert, update, delete, references on APPP_TB_ANTI_PATTERN to usuario;

/
