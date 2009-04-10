/**********************************************************************************************************************
* Project Name                  : SiGEPAPP
* 08-INS_TB_ATRIB_ESTRUTURA.SQL : Script para criação da tabela APPP_TB_ATRIB_ESTRUTURA
* Author                        : WeeDo 
* Dependencias                  : Depende que os inserts de Estrutura e Atributo tenha sido executados
* History                       : 24/03/2009 - Matheus Gonçalves - Versão Inicial
***********************************************************************************************************************/

INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,1); -- PATTERN X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,2); -- PATTERN X CONTEXTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,3); -- PATTERN X PROBLEMA
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (1,4); -- PATTERN X SOLUCAO

INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,1); -- ANTI-PATTERN X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,2); -- ANTI-PATTERN X CONTEXTO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,3); -- ANTI-PATTERN X PROBLEMA
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,4); -- ANTI-PATTERN X SOLUCAO
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,5); -- ANTI-PATTERN X BARREIRAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,6); -- ANTI-PATTERN X SINTOMAS
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (2,7); -- ANTI-PATTERN X CONSEQUENCIAS

INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,1); -- PERSONA X NOME
INSERT INTO APPP_TB_ATRIB_ESTRUTURA VALUES (3,5); -- PERSONA X DESCRICAO

commit;
