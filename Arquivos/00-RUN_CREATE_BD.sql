set termout on
set head off
set pause off
set linesize 132  

spool /SiGEPAPP/Arquivos/LogCREATEBD.log

@ /SiGEPAPP/Arquivos/ScriptsDrop/00-DROP_SCRIPT.SQL

@ /SiGEPAPP/Arquivos/ScriptsDrop/01-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/02-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/02a-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/03-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/04-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/05-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/06-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/07-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/08-DROP_SCRIPT.SQL
@ /SiGEPAPP/Arquivos/ScriptsDrop/09-DROP_SCRIPT.SQL

@ /SiGEPAPP/Arquivos/ScriptsBanco/00-RUN_SCRIPTS.sql

@ /SiGEPAPP/Arquivos/Functions/00-RUN_FUNCTIONS.sql

@ /SiGEPAPP/Arquivos/Procedures/00-RUN_PROCEDURES.sql

@ /SiGEPAPP/Arquivos/Insercoes/00-RUN_INSERTS.sql

@ /SiGEPAPP/Arquivos/01-RUN_Recompile.sql


SPOOL OFF


/
