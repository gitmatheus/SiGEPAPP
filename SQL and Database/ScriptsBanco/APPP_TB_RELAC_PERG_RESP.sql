/**********************************************************************************************************************
* Project Name                 : SiGEPAPP
* APPP_TB_RELAC_PERG_RESP.SQL  : Script para criação da tabela APPP_TB_RELAC_PERG_RESP
* Author                       : WeeDo 
* History                      : 16/02/2009 - Matheus Gonçalves
*                              : 25/03/2009 - Alteração de nome de procedure
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_RELAC_PERG_RESP' FROM DUAL;
create table APPP_TB_RELAC_PERG_RESP
(
  CD_PERGUNTA       number(10)   NOT NULL,
  CD_RESPOSTA       number(10)   NOT NULL,
  NR_VALOR_RESP     NUMBER(8,2) NOT NULL 
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_RELAC_PERG_RESP
alter table APPP_TB_RELAC_PERG_RESP
  add constraint PK_APPP_TB_RELAC_PERG_RESP primary key (CD_PERGUNTA,CD_RESPOSTA);

-- Create/Recreate FK_APPP_TB_RELAC_PERG_RESP01
alter table APPP_TB_RELAC_PERG_RESP
 add constraint FK_APPP_TB_RELAC_PERG_RESP01 foreign key (CD_PERGUNTA)
  references APPP_TB_PERGUNTA (CD_PERGUNTA); 

-- Create/Recreate FK_APPP_TB_RELAC_PERG_RESP02
alter table APPP_TB_RELAC_PERG_RESP
 add constraint FK_APPP_TB_RELAC_PERG_RESP02 foreign key (CD_RESPOSTA)
  references APPP_TB_RESPOSTA (CD_RESPOSTA);   
    
-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_RELAC_PERG_RESP to admin;
grant select, insert, update, delete, references on APPP_TB_RELAC_PERG_RESP to usuario;

/
