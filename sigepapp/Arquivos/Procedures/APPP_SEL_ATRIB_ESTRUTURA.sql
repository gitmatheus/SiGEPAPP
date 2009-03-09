/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_SEL_ATRIB_ESTRUTURA : Procedure para SELECIONAR dados de ATRIB_ESTRUTURAS
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_ATRIB_ESTRUTURA(pCD_ESTRUTURA    IN NUMBER, 
                                                     pCD_ATRIBUTO_OBJ IN NUMBER,
                                                  p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
       open p_cursor FOR
       SELECT CD_ESTRUTURA    ,
              CD_ATRIBUTO_OBJ                  
       FROM APPP_TB_ATRIB_ESTRUTURA
       WHERE (CD_ESTRUTURA    = pCD_ESTRUTURA    OR pCD_ESTRUTURA    IS NULL)
       AND   (CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ OR pCD_ATRIBUTO_OBJ IS NULL);
       
end APPP_SEL_ATRIB_ESTRUTURA;
