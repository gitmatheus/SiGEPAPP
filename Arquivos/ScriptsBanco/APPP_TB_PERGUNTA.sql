/**********************************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_TB_PERGUNTA.SQL : Script para criação da tabela APPP_TB_PERGUNTA
* Author               : WeeDo 
* History              : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_PERGUNTA' FROM DUAL;
create table APPP_TB_PERGUNTA
(
  CD_PERGUNTA number(10)    NOT NULL,
  DS_PERGUNTA VARCHAR2(50)  NOT NULL)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_PERGUNTA 
alter table APPP_TB_PERGUNTA
  add constraint PK_APPP_TB_PERGUNTA primary key (CD_PERGUNTA);

 -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_PERGUNTA to admin;
grant select, insert, update, delete, references on APPP_TB_PERGUNTA to usuario;

   -- Sequences
  create sequence APPP_SEQ_PERGUNTA
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_PERGUNTA
  before insert on APPP_TB_PERGUNTA  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_PERGUNTA.NEXTVAL INTO :NEW.CD_PERGUNTA FROM DUAL;

end APPP_TG_BEFINS_TB_PERGUNTA;
  
 

/
