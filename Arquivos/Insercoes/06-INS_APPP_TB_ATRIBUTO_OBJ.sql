/**********************************************************************************************************************
* Project Name               : SiGEPAPP
* 06-INS_TB_ATRIBUTO_OBJ.SQL : Script para cria��o da tabela APPP_TB_ATRIB_ESTRUTURA
* Author                     : WeeDo 
* History                    : 12/03/2009 - Guilherme Wachs - Vers�o Inicial
***********************************************************************************************************************/

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Nome do documento','N','Nome',APPP_FN_NM_COL_ATRIB('Nome'), 'NM_NOME');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Onde o problema � encontrado','N','Contexto',APPP_FN_NM_COL_ATRIB('Contexto'),'DS_CONTEXTO' );

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descri��o do problema','N','Problema',APPP_FN_NM_COL_ATRIB( 'Problema')',DS_PROBLEMA');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descri��o da solu��o','S','Solu��o',APPP_FN_NM_COL_ATRIB('Solu��o'),'DS_SOLUCAO');


Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descri��o de Barreiras','S','Barreiras',APPP_FN_NM_COL_ATRIB('Barreiras'),'DS_BARREIRAS');

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Sintomas para o problema','N','Sintomas',APPP_FN_NM_COL_ATRIB('Sintomas'),'DS_SINTOMAS' );

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Consequencias do problema','S','Consequencias',APPP_FN_NM_COL_ATRIB('Consequencias'),'DS_CONSEQUEN' );

Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Recomenda��es para o problema','S','Recomenda��es',APPP_FN_NM_COL_ATRIB( 'Recomenda��es'),'DS_RECOMENDA');


Insert into APPP_TB_ATRIBUTO_OBJ (CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (1,'Descri��o da Persona','S','Descri��o',APPP_FN_NM_COL_ATRIB('Descri��o'),'DS_DESCRICAO');


insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Nome Usu�rio' ,'Nome completo do usu�rio do Pattern',1      ,'S',APPP_FN_NM_COL_ATRIB('Nome Usu�rio') ); 
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Endere�o' ,'Nome da Rua do usu�rio do Pattern'      ,1      ,'S',APPP_FN_NM_COL_ATRIB( 'Endere�o')); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('Data de Nascimento' ,'Data de Nascimento do usu�rio do Pattern' ,4      ,'S',APPP_FN_NM_COL_ATRIB('Data de Nascimento')); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('CPF' ,'CPF do Usu�rio'         ,6      ,'S',APPP_FN_NM_COL_ATRIB('CPF'));  

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ        ,DS_ATRIBUTO_OBJ                  ,CD_TIPO,FL_ATRIB_RELAC,NM_COLUNA) 
                          VALUES('N�mero da Resid�ncia' ,'N�mero da Resid�ncia do Usu�rio',2      ,'S',APPP_FN_NM_COL_ATRIB( 'N�mero da Resid�ncia'));                           
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC,Nm_Coluna) 
                          VALUES('E-mail' ,'E-mail do Usu�rio'         ,5      ,'S',APPP_FN_NM_COL_ATRIB( 'E-mail')); 

                           
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC,Nm_Coluna) 
                          VALUES('RG' ,'RG do Usu�rio'           ,9      ,'S',APPP_FN_NM_COL_ATRIB('RG'));                           

commit;


