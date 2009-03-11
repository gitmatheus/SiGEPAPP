/**********************************************************************************************************************
 Project Name              : SiGEPAPP
 APPP_CREATE_USERS.SQL     : Script para criação dos usuários
 Author                    : WeeDo 
 History                   : 16/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/

SELECT 'Criando o user USUARIO' FROM DUAL;
-- Create the user 
create user USUARIO
  identified by "USUARIO"
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT;

-- Grant/Revoke role privileges 
grant authenticateduser to USUARIO;

SELECT 'Criando o user ADMIN' FROM DUAL;
-- Create the user 
create user ADMIN
  identified by "ADMIN"
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT;

-- Grant/Revoke role privileges 
grant administer any sql tuning set to SYSTEM;
grant alter any procedure to SYSTEM;
grant alter any sql profile to SYSTEM;
grant alter any table to SYSTEM;
grant alter database to SYSTEM;
grant create any procedure to SYSTEM;
grant create any sequence to SYSTEM;
grant create any view to SYSTEM;
grant create materialized view to SYSTEM;
grant create table to SYSTEM;
grant execute any class to SYSTEM;
grant execute any procedure to SYSTEM;
grant execute any program to SYSTEM;
grant execute any type to SYSTEM;
grant global query rewrite to SYSTEM;
grant grant any privilege to SYSTEM;
grant select any table to SYSTEM;
grant unlimited tablespace to SYSTEM with admin option;

/
