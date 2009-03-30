/***************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_SEL_OBJ_SIMILARES : Procedure para SELECIONAR OBJETOS SIMILARES
* Author                 : WeeDo 
* History                : 30/03/2009 - Matheus Goncalves - Versao Inicial
*                        : 30/03/2009 - Matheus Goncalves - Remocao do uso de APPP_FN_SIMILAR_PALAV
****************************************************************************************************/
create or replace procedure APPP_SEL_OBJ_SIMILARES(pCD_OBJETO  IN NUMBER,
                                                   vRESULT     OUT NUMBER,
                                                   p_cursor    OUT SYS_REFCURSOR) is

  vNM_OBJETO APPP_TB_OBJETO.NM_OBJETO%TYPE;
  vDS_OBJETO APPP_TB_OBJETO.DS_OBJETO%TYPE;
  
begin
       vRESULT := 1;
       SELECT NM_OBJETO,
              DS_OBJETO
       INTO   vNM_OBJETO,
              vDS_OBJETO        
       FROM APPP_TB_OBJETO
       WHERE CD_OBJETO = pCD_OBJETO;
        
       open p_cursor FOR
       SELECT CD_OBJETO,
              NM_OBJETO,
              CD_ESTRUTURA,
              DS_OBJETO              
       FROM APPP_TB_OBJETO
       WHERE CD_OBJETO <>  pCD_OBJETO
       AND (    APPP_FN_SIMILARIDADE (NM_OBJETO,vNM_OBJETO) > 0.5
             or APPP_FN_SIMILARIDADE (DS_OBJETO,vDS_OBJETO) > 0.5             
           );  
         
    EXCEPTION
      WHEN NO_DATA_FOUND THEN 
         vRESULT := SQLCODE;
                   
end APPP_SEL_OBJ_SIMILARES;
/
