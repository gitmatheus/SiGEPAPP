/***********************************************************************************
* Project Name    : SiGEPAPP
* APPP_SEL_ESTADO : Procedure para SELECIONAR dados de ESTADOS
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
************************************************************************************/
create or replace procedure APPP_SEL_ESTADO(pCD_ESTADO IN NUMBER  ,
                                            pNM_ESTADO IN VARCHAR2,
                                            pSG_SIGLA  VARCHAR2   ,
                                            p_cursor    OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_ESTADO IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_ESTADO    ,
              NM_ESTADO    , 
              SG_SIGLA     
       FROM APPP_TB_ESTADO
       WHERE CD_ESTADO = pCD_ESTADO;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_ESTADO    ,
              NM_ESTADO    , 
              SG_SIGLA    
       FROM APPP_TB_ESTADO
       WHERE (NM_ESTADO LIKE ('%'|| pNM_ESTADO || '%') OR pNM_ESTADO IS NULL)
       AND   (SG_SIGLA = pSG_SIGLA OR pSG_SIGLA IS NULL);
       
   END IF;                
end APPP_SEL_ESTADO;
/