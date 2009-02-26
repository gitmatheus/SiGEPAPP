/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_TB_OBJ_RELAC.SQL  : Script para criação da tabela APPP_TB_OBJ_RELAC
* Author                 : WeeDo 
* History                : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_OBJ_RELAC' FROM DUAL;
create table APPP_TB_OBJ_RELAC
(
  CD_OBJETO         number(10) NOT NULL,
  CD_OBJETO_RELAC   number(10) NOT NULL 
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate PK_APPP_TB_OBJ_RELAC
alter table APPP_TB_OBJ_RELAC
  add constraint PK_APPP_TB_OBJ_RELAC primary key (CD_OBJETO,CD_OBJETO_RELAC);

-- Create/Recreate FK_APPP_TB_OBJ_RELAC01
alter table APPP_TB_OBJ_RELAC
 add constraint FK_APPP_TB_OBJ_RELAC01 foreign key (CD_OBJETO)
  references APPP_TB_OBJETO (CD_OBJETO);
  
-- Create/Recreate FK_APPP_TB_OBJ_RELAC02
alter table APPP_TB_OBJ_RELAC
 add constraint FK_APPP_TB_OBJ_RELAC02 foreign key (CD_OBJETO_RELAC)
  references APPP_TB_OBJETO (CD_OBJETO); 
  
-- Create/Recreate CK_APPP_TB_OBJ_RELAC01
alter table APPP_TB_OBJ_RELAC
 add constraint CK_APPP_TB_OBJ_RELAC01 CHECK (CD_OBJETO_RELAC <> CD_OBJETO); 
    
-- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_OBJ_RELAC to admin;
grant select, insert, update, delete, references on APPP_TB_OBJ_RELAC to usuario;

/
