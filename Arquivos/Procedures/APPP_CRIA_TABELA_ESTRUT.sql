/*****************************************************************************************
* Project Name            : SiGEPAPP
* APPP_CRIA_TABELA_ESTRUT : Procedure para criação dinâmica de tabelas de estrutura.
*                           vResult( 1=OK; -99=ErroGeral)
* Author                  : WeeDo 
* History                 : 09/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_CRIA_TABELA_ESTRUT(pCD_ESTRUTURA IN NUMBER) is

  cursor c is 
  select EO.CD_ESTRUTURA,
         EO.NM_ESTRUTURA,
         EO.NM_TB_ESTRUT,
         AE.CD_ATRIBUTO_OBJ,
         AO.NM_ATRIBUTO_OBJ,
         AO.DS_ATRIBUTO_OBJ,
         AO.CD_TIPO,      
         T.NM_TIPO,
         DECODE(T.FL_EXP_REG,'S','VARCHAR2',
                              'N',upper(T.DS_TIPO)) T_TYPE,
        DECODE(T.FL_EXP_REG,'S',T.DS_TIPO,
                              'N',null) EXP_REG                       
  from appp_tb_estrut_obj EO,
       appp_tb_atrib_estrutura AE,
       appp_tb_atributo_obj AO,
       APPP_TB_TIPO T
  where AE.CD_ESTRUTURA    = EO.CD_ESTRUTURA
  AND   AO.CD_ATRIBUTO_OBJ = AE.CD_ATRIBUTO_OBJ
  AND   T.CD_TIPO          = AO.CD_TIPO
  and   EO.cd_estrutura    = pCD_ESTRUTURA;

begin
  
  

end APPP_CRIA_TABELA_ESTRUT;
