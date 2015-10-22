/**********************************************************************************************************************
* Project Name                    : SiGEPAPP
* APPP_TB_RESP_QUEST_PREENCH.SQL  : Script para criação da tabela APPP_TB_RESP_QUEST_PREENCH
* Author                          : WeeDo 
* History                         : 16/02/2009 - Matheus Goncalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_RESP_QUEST_PREENCH' FROM DUAL;
create table APPP_TB_RESP_QUEST_PREENCH
(
  CD_QUEST_PREENCH  number(10) NOT NULL,
  CD_PERGUNTA       number(10) NOT NULL,
  CD_RESPOSTA       number(10) NOT NULL 
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_RESP_QUEST_PREENCH
alter table APPP_TB_RESP_QUEST_PREENCH
  add constraint PK_APPP_TB_RESP_QUEST_PREENCH primary key (CD_QUEST_PREENCH,CD_PERGUNTA);

-- Create/Recreate FK_APPP_TB_RESP_QUEST_PREENCH01
alter table APPP_TB_RESP_QUEST_PREENCH
 add constraint FK_APPP_RESP_QUEST_PREENCH01 foreign key (CD_QUEST_PREENCH)
  references APPP_TB_QUEST_PREENCH(CD_QUEST_PREENCH);
  
-- Create/Recreate FK_APPP_TB_RESP_QUEST_PREENCH02
alter table APPP_TB_RESP_QUEST_PREENCH
 add constraint FK_APPP_RESP_QUEST_PREENCH02 foreign key (CD_PERGUNTA)
  references APPP_TB_PERGUNTA(CD_PERGUNTA); 

-- Create/Recreate FK_APPP_TB_RESP_QUEST_PREENCH03
alter table APPP_TB_RESP_QUEST_PREENCH
 add constraint FK_APPP_RESP_QUEST_PREENCH03 foreign key (CD_RESPOSTA)
  references APPP_TB_RESPOSTA(CD_RESPOSTA);   
    
-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_RESP_QUEST_PREENCH to admin;
grant select, insert, update, delete, references on APPP_TB_RESP_QUEST_PREENCH to usuario;

/
