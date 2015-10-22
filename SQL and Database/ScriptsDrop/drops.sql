-- Selecao para o drop
-- select 'drop',object_type, object_name,';' from all_objects where object_name like 'APPP%' order by created desc;

set termout on
set head off
set linesize 132

Spool /SiGEPAPP/Arquivos/run_DROP.sql

select 'drop',object_type, object_name,';' from all_objects where object_name like 'APPP%' order by created desc;

spool off;

set heading on;
set feedback on;
set echo off;
@ /SiGEPAPP/Arquivos/run_DROP.sql
@ /SiGEPAPP/Arquivos/run_DROP.sql
@ /SiGEPAPP/Arquivos/run_DROP.sql
@ /SiGEPAPP/Arquivos/run_DROP.sql
@ /SiGEPAPP/Arquivos/run_DROP.sql

/