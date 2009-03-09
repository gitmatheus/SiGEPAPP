/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_SEL_QUESTIONARIO : Procedure para SELECIONAR dados de QUESTIONARIOS
* Author                : WeeDo 
* History               : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_QUESTIONARIO(pCD_QUEST         IN NUMBER   ,
                                                  pDT_APLICACAOINI  IN DATE     ,
                                                  pDT_APLICACAOFIM  IN DATE     ,
                                                  pVL_AVALIACAOINI  IN NUMBER   ,
                                                  pVL_AVALIACAOFIM  IN NUMBER   ,
                                                  pDS_PROJ_APLIC    IN VARCHAR2 ,
                                                  pCD_USER          IN NUMBER   ,
                                                  p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_QUEST IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_QUEST     ,
              DT_APLICACAO ,
              VL_AVALIACAO ,
              DS_PROJ_APLIC,
              CD_USER
       FROM APPP_TB_QUESTIONARIO
       WHERE CD_QUEST = pCD_QUEST;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_QUEST     ,
              DT_APLICACAO ,
              VL_AVALIACAO ,
              DS_PROJ_APLIC,
              CD_USER    
       FROM APPP_TB_QUESTIONARIO
       WHERE (CD_USER = pCD_USER OR pCD_USER IS NULL)
       AND   (DT_APLICACAO >= pDT_APLICACAOINI or pDT_APLICACAOINI IS NULL)
       AND   (DT_APLICACAO <= pDT_APLICACAOFIM or pDT_APLICACAOFIM IS NULL)
       AND   (VL_AVALIACAO >= pVL_AVALIACAOINI OR pVL_AVALIACAOINI IS NULL)
       AND   (VL_AVALIACAO <= pVL_AVALIACAOFIM OR pVL_AVALIACAOFIM IS NULL)
       AND   (DS_PROJ_APLIC like ('%'|| pDS_PROJ_APLIC || '%') OR pDS_PROJ_APLIC  IS NULL);
       
   END IF;                
end APPP_SEL_QUESTIONARIO;
