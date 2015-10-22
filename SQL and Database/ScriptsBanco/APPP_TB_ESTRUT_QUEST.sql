/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_ESTRUT_QUEST.SQL  : Script para criação da tabela APPP_TB_ESTRUT_QUEST
* Author                    : WeeDo 
* History                   : 25/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_ESTRUT_QUEST' FROM DUAL;
create table APPP_TB_ESTRUT_QUEST
(
  CD_QUEST          number(10) NOT NULL,
  CD_PERGUNTA       number(10) NOT NULL,
  NR_ORDEM          number(10) NOT NULL 
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_ESTRUT_QUEST
alter table APPP_TB_ESTRUT_QUEST
  add constraint PK_APPP_TB_ESTRUT_QUEST primary key (CD_QUEST,CD_PERGUNTA);

 
-- Create/Recreate FK_APPP_TB_ESTRUT_QUEST02
alter table APPP_TB_ESTRUT_QUEST
 add constraint FK_APPP_TB_ESTRUT_QUEST02 foreign key (CD_PERGUNTA)
  references APPP_TB_PERGUNTA (CD_PERGUNTA); 
    
-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ESTRUT_QUEST to admin;
grant select, insert, update, delete, references on APPP_TB_ESTRUT_QUEST to usuario;

/
