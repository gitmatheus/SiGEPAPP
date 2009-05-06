/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_TB_AVAL_OBJ_USER.SQL : Script para criacao da tabela APPP_TB_AVAL_OBJ_USER
* Author                    : WeeDo 
* History                   : 06/05/2009 - Matheus Goncalves
***********************************************************************************************************************/

-- Create table
SELECT 'Criando a tabela APPP_TB_AVAL_OBJ_USER' FROM DUAL;

create table APPP_TB_AVAL_OBJ_USER
(
  CD_USER           number(15)  NOT NULL,
  CD_OBJETO         number(10)  NOT NULL                      
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_AVAL_OBJ_USER 
alter table APPP_TB_AVAL_OBJ_USER
  add constraint PK_APPP_TB_AVAL_OBJ_USER primary key (CD_USER,CD_OBJETO);

-- Create/Recreate FK_APPP_TB_AVAL_OBJ_USER01 
alter table APPP_TB_AVAL_OBJ_USER
  add constraint FK_APPP_TB_AVAL_OBJ_USER01 foreign key (CD_USER)
  references APPP_TB_USER(CD_USER);
	
	alter table APPP_TB_AVAL_OBJ_USER
  add constraint FK_APPP_TB_AVAL_OBJ_USER02 foreign key (CD_OBJETO)
  references APPP_TB_OBJETO(CD_OBJETO);
   
  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_AVAL_OBJ_USER to admin;
grant select, insert, update, delete, references on APPP_TB_AVAL_OBJ_USER to usuario;

 

/
