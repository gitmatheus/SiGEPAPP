/**********************************************************************************************************************
* Project Name        : SiGEPAPP
* APPP_TB_PERSONA.SQL : Script para cria��o da tabela APPP_TB_PERSONA
* Author              : WeeDo 
* History             : 16/02/2009 - Matheus Gon�alves - VERS�O INICIAL
*                     : 25/02/2009 - Matheus Gon�alves - ALTERA��O CAMPO URL  
***********************************************************************************************************************/

-- Create table 
SELECT 'Criando a tabela APPP_TB_PERSONA' FROM DUAL;
create table APPP_TB_PERSONA
(
  CD_PERSONA        number(10)    NOT NULL,
  NM_PERSONA        VARCHAR2(60)  NOT NULL ,
  URL_FOTO          VARCHAR2(14)                   
)
tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

-- Create/Recreate PK_APPP_TB_PERSONA 
alter table APPP_TB_PERSONA
  add constraint PK_APPP_TB_PERSONA primary key (CD_PERSONA);

-- Create/Recreate FK_APPP_TB_PERSONA 
alter table APPP_TB_PERSONA
 add constraint FK_APPP_TB_PERSONA foreign key (CD_PERSONA)
  references APPP_TB_OBJETO (CD_OBJETO);

-- Add comments to the columns 
comment on column APPP_TB_PERSONA.URL_FOTO
  is 'Padr�o "IMG_9999999999"';
  
 -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_PERSONA to admin;
grant select, insert, update, delete, references on APPP_TB_PERSONA to usuario;

/
