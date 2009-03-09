/**********************************************************************************************************************
* Project Name                   : SiGEPAPP
* APPP_TB_RESPOSTA_PERGUNTA.SQL  : Script para criação da tabela APPP_TB_RESPOSTA_PERGUNTA
* Author                         : WeeDo 
* History                        : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_RESPOSTA_PERGUNTA' FROM DUAL;
create table APPP_TB_RESPOSTA_PERGUNTA
(
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
  
-- Create/Recreate PK_APPP_TB_RESPOSTA_PERGUNTA
alter table APPP_TB_RESPOSTA_PERGUNTA
  add constraint PK_APPP_TB_RESPOSTA_PERGUNTA primary key (CD_PERGUNTA,CD_RESPOSTA);

-- Create/Recreate FK_APPP_TB_RESPOSTA_PERGUNTA01
alter table APPP_TB_RESPOSTA_PERGUNTA
 add constraint FK_APPP_TB_RESPOSTA_PERGUNTA01 foreign key (CD_PERGUNTA)
  references APPP_TB_PERGUNTA (CD_PERGUNTA); 

-- Create/Recreate FK_APPP_TB_RESPOSTA_PERGUNTA02
alter table APPP_TB_RESPOSTA_PERGUNTA
 add constraint FK_APPP_TB_RESPOSTA_PERGUNTA02 foreign key (CD_RESPOSTA)
  references APPP_TB_RESPOSTA (CD_RESPOSTA);   
    
-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_RESPOSTA_PERGUNTA to admin;
grant select, insert, update, delete, references on APPP_TB_RESPOSTA_PERGUNTA to usuario;

/
