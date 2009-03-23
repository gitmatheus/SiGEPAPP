set termout on
set head off
set linesize 132  

Spool /SiGEPAPP/Arquivos/02-DROP_CREATED.sql

select 'DROP ' || OBJECT_TYPE || ' ' || OWNER || '.' || OBJECT_NAME || ';' 
from sys.all_objects
WHERE OBJECT_NAME LIKE '%APPP_%';

spool off;

set heading on;
set feedback on;
set echo on;
@ /SiGEPAPP/Arquivos/02-DROP_CREATED.sql


/
