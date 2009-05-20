if exist c:\sigepapp\Arquivos del c:\sigepapp\Arquivos\*.* /s

if not exist c:\sigepapp\Arquivos md c:\sigepapp\Arquivos

cd ..
xcopy "Arquivos" "c:\sigepapp\Arquivos\" /s /v

sqlplus.exe System/System@xe @c:/sigepapp/arquivos/00-run_create_bd.sql
