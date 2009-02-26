/**********************************************************************************************************************
 Project Name              : SiGEPAPP
 APPP_CREATE_USERS.SQL     : Script para cria��o dos usu�rios
 Author                    : WeeDo 
 History                   : 16/02/2009 - Matheus Gon�alves
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
grant xdbadmin to ADMIN with admin option;

/
