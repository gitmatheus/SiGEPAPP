REM INSERTING into APPP_TB_ATRIBUTO_OBJ

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

