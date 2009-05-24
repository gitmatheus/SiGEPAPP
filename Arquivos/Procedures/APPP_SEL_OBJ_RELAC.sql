/***********************************************************************************
* Project Name       : SiGEPAPP
* APPP_SEL_OBJ_RELAC : Procedure para SELECIONAR dados de OBJ_RELACS
* Author             : WeeDo 
* History            : 04/03/2009 - Matheus Goncalves
*					 : 23/05/2009 - Guilherme Wachs Lopes - Inner Joins
************************************************************************************/
create or replace procedure APPP_SEL_OBJ_RELAC(pCD_RELAC            IN NUMBER   ,
                                               pCD_OBJ_RELACIONADO  IN NUMBER   ,
                                               pCD_OBJ_RELACIONANDO IN NUMBER   , 
                                               pCD_ATRIBUTO_OBJ     IN NUMBER   ,
                                               p_cursor         OUT SYS_REFCURSOR) is
begin
       open p_cursor FOR
       SELECT RELAC.CD_RELAC            ,
              RELAC.CD_OBJ_RELACIONADO  ,
              RELAC.CD_OBJ_RELACIONANDO ,
              RELAC.CD_ATRIBUTO_OBJ     ,
              RELAC.VL_RELAC            ,
              OBJ.NM_OBJETO       ,
              OBJ.DS_OBJETO       ,
              EST.NM_ESTRUTURA    ,
              EST.TP_ESTRUTURA    ,
              ATR.NM_ATRIBUTO_OBJ 
       FROM APPP_TB_OBJ_RELAC RELAC, APPP_TB_OBJETO OBJ, APPP_TB_ESTRUT_OBJ EST, Appp_Tb_Atributo_Obj ATR
       WHERE (RELAC.CD_OBJ_RELACIONADO  = pCD_OBJ_RELACIONADO  OR pCD_OBJ_RELACIONADO  IS NULL)
       AND   (RELAC.CD_OBJ_RELACIONANDO = pCD_OBJ_RELACIONANDO OR pCD_OBJ_RELACIONANDO IS NULL)
       AND   (RELAC.CD_RELAC            = pCD_RELAC            OR pCD_RELAC            IS NULL)
       AND   (RELAC.CD_ATRIBUTO_OBJ     = pCD_ATRIBUTO_OBJ     OR pCD_ATRIBUTO_OBJ     IS NULL)
       AND   (OBJ.CD_OBJETO       = RELAC.CD_OBJ_RELACIONANDO)
       AND   (EST.CD_ESTRUTURA=OBJ.Cd_Estrutura)
       AND   (ATR.CD_ATRIBUTO_OBJ=RELAC.CD_ATRIBUTO_OBJ);
                    
end APPP_SEL_OBJ_RELAC;
/
