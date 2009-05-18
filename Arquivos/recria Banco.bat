xcopy "../Arquivos" "c:/Sigepapp/" /i

sqlplus.exe System/System@xe @c:/sigepapp/arquivos/00-run_create_bd.sql
