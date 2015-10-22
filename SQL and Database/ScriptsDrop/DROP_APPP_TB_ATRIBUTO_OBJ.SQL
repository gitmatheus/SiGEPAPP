/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_TB_ATRIBUTO_OBJ.SQL : Script para drop da tabela APPP_TB_ATRIBUTO_OBJ
* Author                   : WeeDo 
* History                  : 16/02/2009 - Matheus Gonçalves - Versão Inicial
*                          : 26/02/2009 - Matheus Gonçalves - Drop column DS_TAM_ATRIB 
***********************************************************************************************************************/

SELECT 'Dropando a sequence APPP_SEQ_ATRIBUTO_OBJ' FROM DUAL;
drop sequence APPP_SEQ_ATRIBUTO_OBJ;

SELECT 'Dropando a tabela APPP_TB_ATRIBUTO_OBJ' FROM DUAL;
Drop table APPP_TB_ATRIBUTO_OBJ;
 
/

