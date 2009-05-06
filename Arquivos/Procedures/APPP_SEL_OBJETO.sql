/***********************************************************************************
* Project Name    : SiGEPAPP
* APPP_SEL_OBJETO : Procedure para SELECIONAR dados de OBJETOS
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Goncalves
*                 : 06/05/2009 - Matheus Goncalves - Adicao de Flag de Ativo
************************************************************************************/
create or replace procedure APPP_SEL_OBJETO(pCD_OBJETO       IN NUMBER  ,
                                            pNM_OBJETO       IN VARCHAR2,
                                            pCD_ESTRUTURA    IN NUMBER  ,
                                            pDS_OBJETO       IN VARCHAR2,
                                            pDT_CRIACAOINI   IN DATE    , 
                                            pDT_CRIACAOFIM   IN DATE    , 
                                            pCD_USER_CRIADOR IN NUMBER  ,
																						pFL_ATIVO        IN NUMBER  ,
                                            p_cursor         OUT SYS_REFCURSOR   ) is
begin
    
    IF pCD_ESTRUTURA IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_OBJETO       ,
              NM_OBJETO       ,
              CD_ESTRUTURA    ,
              DS_OBJETO       ,
              DT_CRIACAO      , 
              CD_USER_CRIADOR ,
							FL_ATIVO        
       FROM APPP_TB_OBJETO
       WHERE CD_OBJETO = pCD_OBJETO;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_OBJETO       ,
              NM_OBJETO       ,
              CD_ESTRUTURA    ,
              DS_OBJETO       ,
              DT_CRIACAO      , 
              CD_USER_CRIADOR ,
							FL_ATIVO   
       FROM APPP_TB_OBJETO
       WHERE (NM_OBJETO like ('%'|| pNM_OBJETO ||'%') OR pNM_OBJETO       IS NULL)
       AND   (CD_ESTRUTURA    = pCD_ESTRUTURA         OR pCD_ESTRUTURA    IS NULL)
			 AND   (FL_ATIVO        = pFL_ATIVO             OR pFL_ATIVO        IS NULL)
       AND   (DS_OBJETO LIKE ('%'|| pDS_OBJETO ||'%') OR pDS_OBJETO       IS NULL)
       AND   (DT_CRIACAO     >= pDT_CRIACAOINI        OR pDT_CRIACAOINI   IS NULL)
       AND   (DT_CRIACAO     <= pDT_CRIACAOFIM        OR pDT_CRIACAOFIM   IS NULL)
       AND   (CD_USER_CRIADOR = pCD_USER_CRIADOR      OR pCD_USER_CRIADOR IS NULL);
       
   END IF;                
end APPP_SEL_OBJETO;
/
