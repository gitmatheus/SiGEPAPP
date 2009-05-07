set termout on
set head off
set pause off
set linesize 132  

spool /SiGEPAPP/Arquivos/LogCREATEBD.log

@ /SiGEPAPP/Arquivos/ScriptsDrop/00-DROP_SCRIPT.SQL

@ /SiGEPAPP/Arquivos/ScriptsBanco/00-RUN_SCRIPTS.sql

@ /SiGEPAPP/Arquivos/Functions/00-RUN_FUNCTIONS.sql

@ /SiGEPAPP/Arquivos/Procedures/00-RUN_PROCEDURES.sql

@ /SiGEPAPP/Arquivos/Insercoes/00-RUN_INSERTS.sql

@ /SiGEPAPP/Arquivos/01-RUN_Recompile.sql


SPOOL OFF


/
