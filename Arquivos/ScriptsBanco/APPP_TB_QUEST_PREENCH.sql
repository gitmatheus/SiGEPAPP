/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_QUEST_PREENCH.SQL : Script para criacao da tabela APPP_TB_QUEST_PREENCH
* Author                    : WeeDo 
* History                   : 24/03/2009 - Matheus Goncalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_QUEST_PREENCH' FROM DUAL;

create table APPP_TB_QUEST_PREENCH
(
  CD_QUEST_PREENCH        number(10)           NOT NULL,
  DT_APLICACAO    DATE DEFAULT SYSDATE NOT NULL ,
  VL_AVALIACAO    NUMBER(5,2)                   ,
  DS_PROJ_APLIC   VARCHAR2(60)                  
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_QUEST_PREENCH 
alter table APPP_TB_QUEST_PREENCH
  add constraint PK_APPP_TB_QUEST_PREENCH primary key (CD_QUEST_PREENCH);

-- Create/Recreate FK_APPP_TB_QUEST_PREENCH01 
alter table APPP_TB_QUEST_PREENCH
  add constraint FK_APPP_TB_QUEST_PREENCH01 foreign key (CD_QUEST_PREENCH)
  references APPP_TB_RELAC_QUEST_OBJ (CD_QUEST_PREENCH);
   
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_QUEST_PREENCH to admin;
grant select, insert, update, delete, references on APPP_TB_QUEST_PREENCH to usuario;

 

/
