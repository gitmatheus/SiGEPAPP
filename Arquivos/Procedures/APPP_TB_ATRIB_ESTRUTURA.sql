/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_ATRIBUTO_OBJ.SQL : Script para criação da tabela APPP_TB_ATRIB_ESTRUTURA
* Author                   : WeeDo
* History                  : 16/02/2009 - Guilherme Wachs   - Versão Inicial
*                          : 06/03/2009 - Matheus Gonçalves - Adição de Table Space
*                                                           - Adição de Primary Key            
***********************************************************************************************************************/
-- Create table 
SELECT 'Criando a tabela APPP_TB_ATRIB_ESTRUTURA' FROM DUAL;

create table APPP_TB_ATRIB_ESTRUTURA(CD_ESTRUTURA    NUMBER(10,0) NOT NULL, 
                                     CD_ATRIBUTO_OBJ NUMBER(10,0) NOT NULL
                                     )
  tablespace SYSTEM
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate PK_APPP_TB_ANTI_PATTERN
alter table APPP_TB_ATRIB_ESTRUTURA
  add CONSTRAINT PK_APPP_TB_ATRIB_ESTRUTURA PRIMARY KEY (CD_ESTRUTURA); 

-- Create/Recreate FK_APPP_TB_ANTI_PATTERN

alter table APPP_TB_ATRIB_ESTRUTURA
  add CONSTRAINT FK_APPP_TB_ATRIB_ESTRUTURA_01 FOREIGN KEY (CD_ESTRUTURA) REFERENCES APPP_TB_ESTRUT_OBJ(CD_ESTRUTURA);
  
alter table APPP_TB_ATRIB_ESTRUTURA
  add CONSTRAINT FK_APPP_TB_ATRIB_ESTRUTURA_02 FOREIGN KEY (CD_ATRIBUTO_OBJ) REFERENCES APPP_TB_ATRIBUTO_OBJ(CD_ATRIBUTO_OBJ);

  -- Grant/Revoke object privileges 
grant select, insert, UPDATE, delete, references, alter, index on APPP_TB_ATRIB_ESTRUTURA to admin;
grant select, insert, update, delete, references on APPP_TB_ATRIB_ESTRUTURA to usuario;

/
