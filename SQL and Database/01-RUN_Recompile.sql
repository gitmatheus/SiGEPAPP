set termout on
set head off
set linesize 132  

Spool /SiGEPAPP/Arquivos/run_invalid.sql

select 'ALTER ' || OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME || ' COMPILE;'
from sys.all_objects
where status = 'INVALID' 
and   object_type in ('PACKAGE','FUNCTION','PROCEDURE')
and   OBJECT_NAME LIKE '%APPP_%';

spool off;

set heading on;
set feedback on;
set echo on;
@ /SiGEPAPP/Arquivos/run_invalid.sql


/
