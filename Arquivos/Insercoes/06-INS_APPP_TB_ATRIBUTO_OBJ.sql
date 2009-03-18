REM INSERTING into APPP_TB_ATRIBUTO_OBJ

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Nome Usu�rio' ,'Nome completo do usu�rio do Pattern',1      ,'S'); 
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Endere�o' ,'Nome da Rua do usu�rio do Pattern'      ,1      ,'S'); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Data de Nascimento' ,'Data de Nascimento do usu�rio do Pattern' ,4      ,'S'); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('CPF' ,'CPF do Usu�rio'         ,6      ,'S');  

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ        ,DS_ATRIBUTO_OBJ                  ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('N�mero da Resid�ncia' ,'N�mero da Resid�ncia do Usu�rio',2      ,'S');                           
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('E-mail' ,'E-mail do Usu�rio'         ,5      ,'S'); 
                           
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('RG' ,'RG do Usu�rio'           ,9      ,'S');                           


Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
			values (8,1,'Nome do documento','N','Nome',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
			values (9,1,'Onde o problema � encontrado','N','Contexto',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
			values (10,1,'Descri��o do problema','N','Problema',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
			values (11,1,'Descri��o da solu��o','S','Solu��o',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
			values (12,1,'Sintomas para o problema','N','Sintomas',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
			values (13,1,'Consequencias do problema','S','Consequencias',null);


commit;

select * from APPP_TB_TIPO

