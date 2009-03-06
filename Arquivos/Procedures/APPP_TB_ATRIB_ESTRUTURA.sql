/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_ATRIBUTO_OBJ.SQL : Script para criação da tabela APPP_TB_ATRB_ESTRUTURA_OBJ
* Author                   : WeeDo
* History                  : 16/02/2009 - Guilherme Wachs   - Versão Inicial
***********************************************************************************************************************/
create table APPP_TB_ATRIB_ESTRUTURA(CD_ESTRUTURA NUMBER(10,0) NOT NULL, CD_ATRIBUTO_OBJ NUMBER(10,0) NOT NULL,
CONSTRAINT FK_APPP_TB_ATRIB_ESTRUTURA_01 FOREIGN KEY (CD_ESTRUTURA) REFERENCES APPP_TB_ESTRUT_OBJ(CD_ESTRUTURA),
CONSTRAINT FK_APPP_TB_ATRIB_ESTRUTURA_02 FOREIGN KEY (CD_ATRIBUTO_OBJ) REFERENCES APPP_TB_ATRIBUTO_OBJ(CD_ATRIBUTO_OBJ)
);