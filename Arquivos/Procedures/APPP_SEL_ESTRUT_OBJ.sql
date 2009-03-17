/*******************************************************************************************
* Project Name        : SiGEPAPP
* APPP_SEL_ESTRUT_OBJ : Procedure para SELECIONAR dados de ESTRUT_OBJS
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gonçalves
*                     : 09/03/2009 - Matheus Gonçalves - Criação do atributo NM_TB_ESTRUT
********************************************************************************************/
create or replace procedure APPP_SEL_ESTRUT_OBJ(pCD_ESTRUTURA  IN NUMBER,
                                                pDS_ESTRUTURA  IN VARCHAR2,
                                                pDT_CRIACAOINI IN DATE    ,
                                                pDT_CRIACAOFIM IN DATE    ,
                                                pCD_USER       IN NUMBER  ,
                                                pTP_ESTRUTURA  IN VARCHAR2,
                                                p_cursor       OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_ESTRUTURA IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_ESTRUTURA ,
              NM_ESTRUTURA , 
              DS_ESTRUTURA ,
              DT_CRIACAO   ,
              CD_USER      ,
              TP_ESTRUTURA ,
              NM_TB_ESTRUT
       FROM APPP_TB_ESTRUT_OBJ
       WHERE CD_ESTRUTURA = pCD_ESTRUTURA;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_ESTRUTURA ,
              NM_ESTRUTURA , 
              DS_ESTRUTURA ,
              DT_CRIACAO   ,
              CD_USER      ,
              TP_ESTRUTURA ,
              NM_TB_ESTRUT
       FROM APPP_TB_ESTRUT_OBJ
       WHERE (DS_ESTRUTURA like ('%'|| pDS_ESTRUTURA || '%') OR pDS_ESTRUTURA  IS NULL)
       AND   (DT_CRIACAO  >= pDT_CRIACAOINI                  OR pDT_CRIACAOINI IS NULL)
       AND   (DT_CRIACAO  <= pDT_CRIACAOFIM                  OR pDT_CRIACAOFIM IS NULL)
       AND   (CD_USER      = pCD_USER                        OR pCD_USER       IS NULL)
       AND   (TP_ESTRUTURA = pTP_ESTRUTURA                   OR pTP_ESTRUTURA  IS NULL);
       
   END IF;                
end APPP_SEL_ESTRUT_OBJ;
/
