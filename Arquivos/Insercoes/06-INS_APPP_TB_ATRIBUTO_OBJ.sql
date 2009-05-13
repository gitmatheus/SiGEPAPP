/**********************************************************************************************************************
* Project Name               : SiGEPAPP
* 06-INS_TB_ATRIBUTO_OBJ.SQL : Script para criação da tabela APPP_TB_ATRIB_ESTRUTURA
* Author                     : WeeDo 
* History                    : 12/03/2009 - Guilherme Wachs - Versão Inicial
***********************************************************************************************************************/

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Nome do documento','N','Nome',APPP_FN_NM_COL_ATRIB('Nome'), 'NM_NOME');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Onde o problema é encontrado','N','Contexto',APPP_FN_NM_COL_ATRIB('Contexto'),'DS_CONTEXTO' );

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição do problema','N','Problema',APPP_FN_NM_COL_ATRIB( 'Problema')',DS_PROBLEMA');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição da solução','S','Solução',APPP_FN_NM_COL_ATRIB('Solução'),'DS_SOLUCAO');


Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição de Barreiras','S','Barreiras',APPP_FN_NM_COL_ATRIB('Barreiras'),'DS_BARREIRAS');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Sintomas para o problema','N','Sintomas',APPP_FN_NM_COL_ATRIB('Sintomas'),'DS_SINTOMAS' );

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Consequencias do problema','S','Consequencias',APPP_FN_NM_COL_ATRIB('Consequencias'),'DS_CONSEQUEN' );

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Recomendações para o problema','S','Recomendações',APPP_FN_NM_COL_ATRIB( 'Recomendações'),'DS_RECOMENDA');


Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descrição da Persona','S','Descrição',APPP_FN_NM_COL_ATRIB('Descrição'),'DS_DESCRICAO');


insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Nome Usuário' ,'Nome completo do usuário do Pattern',1      ,'S',APPP_FN_NM_COL_ATRIB('Nome Usuário') ); 
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Endereço' ,'Nome da Rua do usuário do Pattern'      ,1      ,'S',APPP_FN_NM_COL_ATRIB( 'Endereço')); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Data de Nascimento' ,'Data de Nascimento do usuário do Pattern' ,4      ,'S',APPP_FN_NM_COL_ATRIB('Data de Nascimento')); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('CPF' ,'CPF do Usuário'         ,6      ,'S',APPP_FN_NM_COL_ATRIB('CPF'));  

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ        ,DS_ATRIBUTO_OBJ                  ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Número da Residência' ,'Número da Residência do Usuário',2      ,'S',APPP_FN_NM_COL_ATRIB( 'Número da Residência'));                           
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC,Nm_Coluna) 
                          VALUES('E-mail' ,'E-mail do Usuário'         ,5      ,'S',APPP_FN_NM_COL_ATRIB( 'E-mail')); 

                           
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC,Nm_Coluna) 
                          VALUES('RG' ,'RG do Usuário'           ,9      ,'S',APPP_FN_NM_COL_ATRIB('RG'));                           

commit;


