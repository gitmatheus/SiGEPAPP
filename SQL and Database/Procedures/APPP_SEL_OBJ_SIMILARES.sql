/***************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_SEL_OBJ_SIMILARES : Procedure para SELECIONAR OBJETOS SIMILARES
* Author                 : WeeDo 
* History                : 30/03/2009 - Matheus Goncalves - Versao Inicial
*                        : 30/03/2009 - Matheus Goncalves - Remocao do uso de APPP_FN_SIMILAR_PALAV
*                        : 31/03/2009 - Matheus Goncalves - Adicao de parametro pTP_ESTRUTURA
*                                       TIPO DAS ESTRUTURAS RELACIONADAS A TRAZER NA CONSULTA
*                          vResult( 1  = Retorno OK; 
*                                   -7 = Erro no tipo de estrutura passado por parametro)
****************************************************************************************************/
create or replace procedure APPP_SEL_OBJ_SIMILARES(pCD_OBJETO    IN NUMBER,
                                                   pTP_ESTRUTURA IN VARCHAR2, 
                                                   pFATOR_CORTE  IN NUMBER DEFAULT 0.30,
                                                   vRESULT       OUT NUMBER,
                                                   p_cursor      OUT SYS_REFCURSOR) is

  vNM_OBJETO APPP_TB_OBJETO.NM_OBJETO%TYPE;
  vDS_OBJETO APPP_TB_OBJETO.DS_OBJETO%TYPE;
  
begin
       
    IF (UPPER(pTP_ESTRUTURA) NOT IN ('PA','AP','PE')) AND (pTP_ESTRUTURA IS NOT NULL) THEN
           vRESULT := -7;
    ELSE   
           vRESULT := 1;
           SELECT NM_OBJETO,
                  DS_OBJETO
           INTO   vNM_OBJETO,
                  vDS_OBJETO        
           FROM APPP_TB_OBJETO
           WHERE CD_OBJETO = pCD_OBJETO;
            
           open p_cursor FOR
           SELECT O.CD_OBJETO,
                  O.NM_OBJETO,
                  O.CD_ESTRUTURA,
                  O.DS_OBJETO,          
                  APPP_FN_SIMILARIDADE (O.DS_OBJETO,vDS_OBJETO) FATOR_SIMIL,
                  0 CD_OBJ_RELACIONADO, -- Pai do relacionamento
                  EO.TP_ESTRUTURA              
            FROM APPP_TB_OBJETO O, 
                 APPP_TB_ESTRUT_OBJ EO
            WHERE CD_OBJETO <>  1
            AND EO.CD_ESTRUTURA   = O.CD_ESTRUTURA
            AND (    APPP_FN_SIMILARIDADE (O.DS_OBJETO,vDS_OBJETO) >= pFATOR_CORTE             
                )
            AND (UPPER(EO.TP_ESTRUTURA) = UPPER(pTP_ESTRUTURA) OR pTP_ESTRUTURA IS NULL)
                   
         UNION
           
           SELECT   O.CD_OBJETO,
                    O.NM_OBJETO,
                    O.CD_ESTRUTURA,
                    O.DS_OBJETO,
                    F.FATOR_SIMIL,
                    OBR.CD_OBJ_RELACIONADO, -- Mostra o pai do relacionamento
                    EO.TP_ESTRUTURA             
           FROM (  SELECT CD_OBJETO,
                          APPP_FN_SIMILARIDADE (DS_OBJETO,vDS_OBJETO) FATOR_SIMIL              
                   FROM APPP_TB_OBJETO
                   WHERE CD_OBJETO <>  1
                   AND   APPP_FN_SIMILARIDADE (DS_OBJETO,vDS_OBJETO) >= pFATOR_CORTE             
                       
                 ) F,
                 APPP_TB_OBJ_RELAC ObR,
                 APPP_TB_OBJETO O     ,
                 APPP_TB_ESTRUT_OBJ EO         
            WHERE ObR.Cd_Obj_Relacionado  =   F.CD_OBJETO
              AND O.CD_OBJETO             = OBR.CD_OBJ_RELACIONANDO
              AND EO.CD_ESTRUTURA         = O.CD_ESTRUTURA
              AND (UPPER(EO.TP_ESTRUTURA) = UPPER(pTP_ESTRUTURA) OR pTP_ESTRUTURA IS NULL) 
            ORDER BY FATOR_SIMIL DESC,TP_ESTRUTURA ;
              
              
       END IF;
         
    EXCEPTION
      WHEN NO_DATA_FOUND THEN 
         vRESULT := SQLCODE;
                   
end APPP_SEL_OBJ_SIMILARES;
/
