/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_SEL_AVAL_OBJ_USER : Procedure para SELECIONAR dados de AVALIACOES
* Author                 : WeeDo 
* History                : 06/05/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_AVAL_OBJ_USER(pCD_USER   IN number,
                                                   pCD_OBJETO IN number,
                                                   p_cursor OUT SYS_REFCURSOR) is
begin
    
    
       open p_cursor FOR       
       SELECT CD_USER,
              CD_OBJETO               
       FROM APPP_TB_AVAL_OBJ_USER
       WHERE (CD_USER    = pCD_USER    OR pCD_USER    IS NULL)
       AND   (CD_OBJETO  = pCD_OBJETO  OR pCD_OBJETO  IS NULL);
           
   
end APPP_SEL_AVAL_OBJ_USER;
/
