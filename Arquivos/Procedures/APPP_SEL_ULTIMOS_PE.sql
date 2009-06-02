/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_APPP_GEN  : Procedure para SELECIONAR Última Personas Cadastradas
* Author             : WeeDo 
* History            : 24/05/2009 - Guilherme Wachs Lopes - Versão Inicial
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ULTIMOS_PE(p_cursor OUT SYS_REFCURSOR,
                                               vResult OUT NUMBER) is


  vCD_ESTRUTURA  APPP_TB_OBJETO.CD_ESTRUTURA%TYPE;
	vTP_ESTRUTURA  APPP_TB_ESTRUT_OBJ.TP_ESTRUTURA%TYPE;
	vCD_OBJETO     APPP_TB_OBJETO.CD_OBJETO%TYPE;

  vNM_COLUNA  APPP_TB_ATRIBUTO_OBJ.NM_COLUNA%TYPE;
  vNM_TABELA  APPP_TB_ESTRUT_OBJ.NM_TB_ESTRUT%TYPE;

  vSQL VARCHAR2(15000) := '';

  vERRO        VARCHAR2(600);

	CURSOR E IS
	 SELECT CD_ESTRUTURA,
	        TP_ESTRUTURA
	 FROM APPP_TB_ESTRUT_OBJ
	 WHERE TP_ESTRUTURA='PE';

	 CURSOR O IS
	   SELECT OB.CD_OBJETO
		 FROM APPP_TB_OBJETO OB
		 WHERE OB.CD_ESTRUTURA = vCD_ESTRUTURA;

	CURSOR TAB IS
	 SELECT EO.NM_TB_ESTRUT
	 FROM APPP_TB_ESTRUT_OBJ EO
	 WHERE EO.CD_ESTRUTURA = vCD_ESTRUTURA;


BEGIN

     

     OPEN p_cursor FOR 
          Select * from
                  appp_tb_objeto obj
                  where
                  obj.cd_estrutura in
                      (select cd_estrutura from appp_tb_estrut_obj est where est.tp_estrutura='PE') and fl_ativo=1;
     
     vResult := 1;

     EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,300) || 'Tabela: ' || vNM_TABELA || '; Coluna: ' || vNM_COLUNA ;

END APPP_SEL_ULTIMOS_PE;
/