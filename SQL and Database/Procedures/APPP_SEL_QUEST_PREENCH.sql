/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_SEL_QUEST_PREENCH : Procedure para SELECIONAR dados de QUEST_PREENCH
* Author                 : WeeDo 
* History                : 24/03/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_QUEST_PREENCH(pCD_QUEST_PREENCH in number  ,
                                                   pDT_APLICACAOINI in DATE    ,
                                                   pDT_APLICACAOFIM in DATE    ,
                                                   pVL_AVALIACAOINI in NUMBER  ,
                                                   pVL_AVALIACAOFIM in NUMBER  ,
                                                   pDS_PROJ_APLIC   in VARCHAR2,
																									 pCD_USER         IN NUMBER  ,
																									 pCD_OBJETO       IN NUMBER  ,
                                                   p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_QUEST_PREENCH IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_QUEST_PREENCH ,
              DT_APLICACAO     ,
              VL_AVALIACAO     ,
              DS_PROJ_APLIC    ,
							CD_USER          ,
							CD_OBJETO
       FROM APPP_TB_QUEST_PREENCH
       WHERE CD_QUEST_PREENCH = pCD_QUEST_PREENCH;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT  CD_QUEST_PREENCH ,
               DT_APLICACAO     ,
               VL_AVALIACAO     ,
               DS_PROJ_APLIC    ,
							 CD_USER          ,
							 CD_OBJETO
       FROM APPP_TB_QUEST_PREENCH
       WHERE (DT_APLICACAO >= pDT_APLICACAOINI or pDT_APLICACAOINI IS NULL)
       AND   (DT_APLICACAO <= pDT_APLICACAOFIM or pDT_APLICACAOFIM IS NULL)
       AND   (VL_AVALIACAO >= pVL_AVALIACAOINI OR pVL_AVALIACAOINI IS NULL)
       AND   (VL_AVALIACAO <= pVL_AVALIACAOFIM OR pVL_AVALIACAOFIM IS NULL)   
			 AND   (CD_USER       = pCD_USER         OR pCD_USER         IS NULL)
			 AND   (CD_OBJETO     = pCD_OBJETO       OR pCD_OBJETO       IS NULL)
       AND   (DS_PROJ_APLIC like ('%'|| pDS_PROJ_APLIC || '%') OR pDS_PROJ_APLIC  IS NULL);
       
   END IF;                
end APPP_SEL_QUEST_PREENCH;
/
