/**********************************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_SEL_RELAC_ATRIB : Procedure para SELECIONAR dados de Relação de Atributos
* 
* Author               : WeeDo 
* History              : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RELAC_ATRIB(pCD_RELAC    in NUMBER,
                                                 pCD_ATRIBUTO in NUMBER,
                                                 pVL_RELAC    in VARCHAR2,
                                                 p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_RELAC IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_RELAC       ,
              CD_ATRIBUTO    , 
              VL_RELAC     
       FROM APPP_TB_RELAC_ATRIB
       WHERE CD_RELAC = pCD_RELAC;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_RELAC       ,
              CD_ATRIBUTO    , 
              VL_RELAC     
       FROM APPP_TB_RELAC_ATRIB T
       WHERE (T.CD_ATRIBUTO = pCD_ATRIBUTO OR pCD_ATRIBUTO    IS NULL)
       AND   (T.VL_RELAC = pVL_RELAC             OR pVL_RELAC IS NULL);
       
   END IF;                
end APPP_SEL_RELAC_ATRIB;
