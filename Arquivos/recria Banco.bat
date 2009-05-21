@echo off

if exist c:\sigepapp\Arquivos (
@echo Apagando os arquivos existentes
rd /s /y "c:\sigepapp\Arquivos\*.* " 
del /s "c:\sigepapp\Arquivos\*.* "
)

if not exist c:\sigepapp\Arquivos md "c:\sigepapp\Arquivos"

@echo Efetuando copia dos arquivos
cd ..
xcopy "Arquivos" "c:\sigepapp\Arquivos\" /s /v

@echo Executando SQL
sqlplus.exe System/System@xe @c:/sigepapp/arquivos/00-run_create_bd.sql
exit
