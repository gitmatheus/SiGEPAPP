/**********************************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_TB_RESPOSTA.SQL : Script para criação da tabela APPP_TB_RESPOSTA
* Author               : WeeDo 
* History              : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_RESPOSTA' FROM DUAL;
create table APPP_TB_RESPOSTA
(
  CD_RESPOSTA      number(10)    NOT NULL,
  DS_RESPOSTA      VARCHAR2(150)  NOT NULL 
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_RESPOSTA 
alter table APPP_TB_RESPOSTA
  add constraint PK_APPP_TB_RESPOSTA primary key (CD_RESPOSTA);

 -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_RESPOSTA to admin;
grant select, insert, update, delete, references on APPP_TB_RESPOSTA to usuario;

   -- Sequences
  create sequence APPP_SEQ_RESPOSTA
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_RESPOSTA
  before insert on APPP_TB_RESPOSTA  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_RESPOSTA.NEXTVAL INTO :NEW.CD_RESPOSTA FROM DUAL;
end APPP_TG_BEFINS_TB_RESPOSTA;
  
 
/
