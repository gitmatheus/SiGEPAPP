/**********************************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_APPP_GEN  : Procedure para SELECIONAR �ltimos Patterns Cadastrados
* Author             : WeeDo 
* History            : 24/05/2009 - Guilherme Wachs Lopes - Vers�o Inicial
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ULTIMOS_PA(p_cursor OUT SYS_REFCURSOR,
                                               vResult OUT NUMBER) is

begin
open p_cursor for
Select cd_objeto,nm_objeto, ds_objeto from appp_tb_objeto where CD_ESTRUTURA in(select cd_estrutura from APPP_TB_ESTRUT_OBJ where TP_ESTRUTURA='PA') order by cd_objeto desc;



END APPP_SEL_ULTIMOS_PA;
/