PL/SQL Developer Test script 3.0
31
declare
  -- Non-scalar parameters require additional processing 
  pvt_valores appp_pkg_vetores.char_vector;
  pvt_oratype appp_pkg_vetores.char_vector;
  
  /* pCD_OBJETO IN NUMBER
  ,pNM_NOME IN VARCHAR2
  ,pDS_CONTEXTO IN VARCHAR2
  ,pDS_PROBLEMA IN VARCHAR2
  ,pDS_SOLUCAO IN VARCHAR2
  ,pDS_SINTOMAS IN VARCHAR2
  ,pDT_DENASCIME IN DATE*/
  
begin
  
  pvt_valores(1) := 1; pvt_oratype(1) := 'NUMBER';
  pvt_valores(2) := 'TESTE'; pvt_oratype(2) := 'VARCHAR2';
  pvt_valores(3) := 'TESTE PATTERN'; pvt_oratype(3) := 'VARCHAR2';
  pvt_valores(4) := 'TESTE PROBLEMA'; pvt_oratype(4) := 'VARCHAR2';
  pvt_valores(5) := 'TESTE SOLUCAO'; pvt_oratype(5) := 'VARCHAR2';
  pvt_valores(6) := 'TESTE SINTOMAS'; pvt_oratype(6) := 'VARCHAR2';
  pvt_valores(7) := SYSDATE; pvt_oratype(7) := 'DATE';
  
  -- Call the procedure
  appp_exec_manip_generica(pnm_tabela => :pnm_tabela,
                           ptp_acesso => :ptp_acesso,
                           pvt_valores => pvt_valores,
                           pvt_oratype => pvt_oratype,
                           vresult => :vresult,
                           p_cursor => :p_cursor);
end;
4
pnm_tabela
1
APPP_TB_CONEXAO_BASE_SYBAS
5
ptp_acesso
1
SEL
5
vresult
1
-6
4
p_cursor
1
<Cursor>
116
5
vNM_PROCEDURE
vNM_PARAMETRO
vSQL
vCONTA_PARAM
pVT_VALORES.LAST
