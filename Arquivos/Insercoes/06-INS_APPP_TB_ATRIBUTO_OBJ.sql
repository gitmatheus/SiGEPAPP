REM INSERTING into APPP_TB_ATRIBUTO_OBJ


Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (8,1,'Nome do documento','N','Nome',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (9,1,'Onde o problema é encontrado','N','Contexto',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (10,1,'Descrição do problema','N','Problema',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (11,1,'Descrição da solução','S','Solução',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (12,1,'Sintomas para o problema','N','Sintomas',null);

Insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ,CD_TIPO,DS_ATRIBUTO_OBJ,FL_ATRIB_RELAC,NM_ATRIBUTO_OBJ,NM_COLUNA) 
      values (13,1,'Consequencias do problema','S','Consequencias',null);
      

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Nome Usuário' ,'Nome completo do usuário do Pattern',1      ,'S'); 
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                      ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Endereço' ,'Nome da Rua do usuário do Pattern'      ,1      ,'S'); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ                                  ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Data de Nascimento' ,'Data de Nascimento do usuário do Pattern' ,4      ,'S'); 
                          

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('CPF' ,'CPF do Usuário'         ,6      ,'S');  

insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ        ,DS_ATRIBUTO_OBJ                  ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('Número da Residência' ,'Número da Residência do Usuário',2      ,'S');                           
                          
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('E-mail' ,'E-mail do Usuário'         ,5      ,'S'); 
                           
insert into APPP_TB_ATRIBUTO_OBJ(NM_ATRIBUTO_OBJ,DS_ATRIBUTO_OBJ ,CD_TIPO,FL_ATRIB_RELAC) 
                          VALUES('RG' ,'RG do Usuário'           ,9      ,'S');                           





commit;

select * from APPP_TB_TIPO

