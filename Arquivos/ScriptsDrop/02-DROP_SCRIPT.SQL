set termout on
set head off
set linesize 132   

Spool /SiGEPAPP/Arquivos/run_DROP02.sql

SELECT 'DROP TABLE NTCUSER.APPP_TB_RESPOSTA;' x FROM DUAL;

spool off;

set heading on;
set feedback on;
set echo on;
@ /SiGEPAPP/Arquivos/run_DROP02.sql


/

