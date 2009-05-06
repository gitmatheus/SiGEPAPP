
/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_TB_ESTRUT_OBJ.SQL : Script para criação da tabela APPP_TB_ESTRUT_OBJ
* Author                 : WeeDo 
* History                : 16/02/2009 - Matheus Gonçalves - Versão inicial
*                        : 09/03/2009 - Matheus Gonçalves - Criação do atributo NM_TB_ESTRUT
*                        : 12/03/2009 - Matheus Gonçalves - Alteração de tamanho de campo de DS_ESTRUTURA VARCHAR2(1000)
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_ESTRUT_OBJ' FROM DUAL;
create table APPP_TB_ESTRUT_OBJ
(
  CD_ESTRUTURA      number(10)    NOT NULL,
  NM_ESTRUTURA      VARCHAR2(40)  NOT NULL ,
  DS_ESTRUTURA      VARCHAR2(1000) NOT NULL, 
  DT_CRIACAO        DATE DEFAULT SYSDATE NOT NULL,
  CD_USER           NUMBER(15) not null,
  TP_ESTRUTURA      varchar2(3) NOT NULL,
  NM_TB_ESTRUT      varchar2(30) not null
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Add comments to the columns 
comment on column APPP_TB_ESTRUT_OBJ.TP_ESTRUTURA
  is '"PE" - Persona ; "PA" - Patter; "AP" - Anti-Pattern';
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table APPP_TB_ESTRUT_OBJ
  add constraint PK_APPP_TB_ESTRUT_OBJ primary key (CD_ESTRUTURA);

alter table APPP_TB_ESTRUT_OBJ
 add constraint FK_APPP_TB_ESTRUT_OBJ_USER foreign key (CD_USER)
  references appp_tb_user (CD_USER);
  
 
-- Create/Recreate check constraints
alter table APPP_TB_ESTRUT_OBJ
 add constraint CK_APPP_TB_ESTRUT_OBJ check (TP_ESTRUTURA in ('PE','PA','AP')); 

alter table APPP_TB_ESTRUT_OBJ
 add constraint UK_APPP_TB_ESTRUT_OBJ01 UNIQUE (NM_ESTRUTURA);  

 
   -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ESTRUT_OBJ to admin;
grant select, insert, update, delete, references on APPP_TB_ESTRUT_OBJ to usuario;

   -- Sequences
  create sequence APPP_SEQ_ESTRUT_OBJ
  minvalue 1
  maxvalue 999999999999999
  start with 1
  increment by 1;
 
  -- Triggers
 create or replace trigger APPP_TG_BEFINS_TB_ESTRUT_OBJ
  before insert on APPP_TB_ESTRUT_OBJ  
  FOR EACH ROW
begin
  SELECT APPP_SEQ_ESTRUT_OBJ.NEXTVAL INTO :NEW.CD_ESTRUTURA FROM DUAL ;
end APPP_TG_BEFINS_TB_ESTRUT_OBJ;

 

/
