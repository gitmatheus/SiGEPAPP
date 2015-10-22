/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_SEL_USER_TELEFONE : Procedure para SELECIONAR dados de USER_TELEFONES
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_USER_TELEFONE(pCD_USER     IN NUMBER  ,
                                                   pNR_DDI      IN NUMBER  ,
                                                   pNR_DDD      IN NUMBER  ,
                                                   pNR_TELEFONE IN NUMBER  ,
                                                   pTP_TELEFONE IN VARCHAR2,
                                                   p_cursor OUT SYS_REFCURSOR   ) is
begin
    
       open p_cursor FOR
       SELECT CD_USER     ,
              NR_DDI      ,
              NR_DDD      ,
              NR_TELEFONE ,
              TP_TELEFONE        
       FROM APPP_TB_USER_TELEFONE
       WHERE (CD_USER     = pCD_USER     OR pCD_USER     IS NULL)
       AND   (NR_DDI      = pNR_DDI      OR pNR_DDI      IS NULL)
       AND   (NR_DDD      = pNR_DDD      OR pNR_DDD      IS NULL)
       AND   (NR_TELEFONE = pNR_TELEFONE OR pNR_TELEFONE IS NULL)
       AND   (TP_TELEFONE = pTP_TELEFONE OR pTP_TELEFONE IS NULL);     
            
end APPP_SEL_USER_TELEFONE;
/