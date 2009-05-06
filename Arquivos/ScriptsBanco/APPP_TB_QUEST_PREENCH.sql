/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_QUEST_PREENCH.SQL : Script para criacao da tabela APPP_TB_QUEST_PREENCH
* Author                    : WeeDo 
* History                   : 24/03/2009 - Matheus Goncalves
*                           : 06/05/2009 - Matheus Goncalves - Adicao de campos CD_USER e CD_OBJETO
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_QUEST_PREENCH' FROM DUAL;

create table APPP_TB_QUEST_PREENCH
(
  CD_QUEST_PREENCH        number(10)           NOT NULL,
  DT_APLICACAO    DATE DEFAULT SYSDATE NOT NULL ,
  VL_AVALIACAO    NUMBER(5,2)                   ,
  DS_PROJ_APLIC   VARCHAR2(60)                  ,
	CD_USER         NUMBER(15)                    ,
	CD_OBJETO       NUMBER(10)      
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
	
alter table APPP_TB_QUEST_PREENCH
  add constraint FK_APPP_TB_QUEST_PREENCH02 foreign key (CD_USER)
  references APPP_TB_USER (CD_USER);
	
alter table APPP_TB_QUEST_PREENCH
  add constraint FK_APPP_TB_QUEST_PREENCH03 foreign key (CD_OBJETO)
  references APPP_TB_OBJETO (CD_OBJETO);	
	
   
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_QUEST_PREENCH to admin;
grant select, insert, update, delete, references on APPP_TB_QUEST_PREENCH to usuario;

 

/
