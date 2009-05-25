set termout on
set head off
set linesize 132  

--Spool /SiGEPAPP/Arquivos/run_DROP.sql

--select 'DROP ' || OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME ||';' 
--from sys.all_objects
--WHERE OBJECT_NAME LIKE '%APPP_%'
--and   object_type in ('PACKAGE','FUNCTION','PROCEDURE','SEQUENCE','TABLE')
--ORDER BY CREATED DESC;

--spool off;

@ /sigepapp/arquivos/scriptsdrop/drops.sql
@ /sigepapp/arquivos/scriptsdrop/drops.sql

set heading on;
set feedback on;
set echo on;
--@ /SiGEPAPP/Arquivos/run_DROP.sql


/
