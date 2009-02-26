/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_TB_CIDADE.SQL : Script para criação da tabela APPP_TB_CIDADE
* Author             : WeeDo 
* History            : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_CIDADE' FROM DUAL;
create table APPP_TB_CIDADE
(
  CD_CIDADE         NUMBER(5)    NOT NULL,
  NM_CIDADE         VARCHAR2(30) NOT NULL,
  NM_ABREV          VARCHAR2(10) 
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );


-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_CIDADE
  add constraint PK_APPP_TB_CIDADE primary key (CD_CIDADE);


  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_CIDADE to admin;
grant select, insert, update, delete, references on APPP_TB_CIDADE to usuario;

 
 -- Sequences
  create sequence APPP_SEQ_CIDADE
  minvalue 1
  maxvalue 9999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_CIDADE
  before insert on appp_tb_cidade  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_CIDADE.NEXTVAL INTO :NEW.CD_CIDADE FROM DUAL;
end APPP_TG_BEFINS_TB_CIDADE;  


/
