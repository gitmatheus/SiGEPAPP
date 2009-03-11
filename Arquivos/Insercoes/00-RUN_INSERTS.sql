set termout on
set head off
set linesize 132  

spool /SiGEPAPP/Arquivos/Insercoes/LogInsertInicial.log

@ /SiGEPAPP/Arquivos/Insercoes/01-INS_APPP_TB_ESTADO.sql

@ /SiGEPAPP/Arquivos/Insercoes/02-INS_APPP_TB_CIDADE.sql

@ /SiGEPAPP/Arquivos/Insercoes/03-INS_APPP_TB_USER.sql

@ /SiGEPAPP/Arquivos/Insercoes/04-INS_APPP_TB_LOGIN.sql

@ /SiGEPAPP/Arquivos/Insercoes/05-INS_APPP_TB_TIPO.sql

SPOOL OFF

/
