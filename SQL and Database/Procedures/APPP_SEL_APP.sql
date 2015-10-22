/**********************************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_SEL_APP  : Procedure para SELECIONAR dados de PATTERNS OU ANTI-PATTERNS
* Author        : WeeDo 
* History       : 11/05/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_APP(pCD_OBJETO   IN NUMBER  , 
                                         pNM_OBJETO   IN VARCHAR2  ,
                                         pTP_ESTRUT   IN VARCHAR2,
                                         pDS_OBJETO   IN VARCHAR2,    
                                         pDS_PROBLEMA IN VARCHAR2,
                                         pDS_SOLUCAO  in VARCHAR2,
                                         p_cursor OUT SYS_REFCURSOR   ) is
BEGIN
  /* SE FOI INFORMADO O CD_OBJETO, É SÓ FAZER A CONSULTA POR ELE */
  IF pCD_OBJETO IS NOT NULL THEN
     
     IF UPPER(TRIM(pTP_ESTRUT)) = 'PA' THEN
       
          open p_cursor FOR
          SELECT O.CD_OBJETO               ,
                 O.NM_OBJETO               ,
                 O.DS_OBJETO               ,
                 P.DS_PROBLEMA PROBLEMA,
                 P.DS_SOLUCAO  SOLUCAO        
          FROM   APPP_TB_OBJETO  O,
                 APPP_TB_PATTERN P
          WHERE  P.CD_PATTERN = pCD_OBJETO
          AND    P.CD_PATTERN = O.CD_OBJETO;

      ELSIF UPPER(TRIM(pTP_ESTRUT)) = 'AP' THEN     
          
          open p_cursor FOR
          SELECT O.CD_OBJETO                 ,
                 O.NM_OBJETO                 ,
                 O.DS_OBJETO                 ,
                 AP.DS_PROBLEMA      PROBLEMA,
                 AP.DS_RECOMENDACOES SOLUCAO          
          FROM   APPP_TB_OBJETO  O,
                 APPP_TB_ANTI_PATTERN AP
          WHERE  AP.CD_ANTI_PATTERN  = pCD_OBJETO
          AND    AP.CD_ANTI_PATTERN  = O.CD_OBJETO;
        
     END IF;
     
  ELSE  
  /*SE NÃO FOI INFORMADO O CÓDIGO, PODE SER PROCURAR PELOS CAMPOS SECUNDÁRIOS */
     
     IF UPPER(TRIM(pTP_ESTRUT)) = 'PA' THEN
       
          open p_cursor FOR
          SELECT O.CD_OBJETO               ,
                 O.NM_OBJETO               ,
                 O.DS_OBJETO               ,
                 P.DS_PROBLEMA PROBLEMA,
                 P.DS_SOLUCAO  SOLUCAO        
          FROM   APPP_TB_OBJETO  O,
                 APPP_TB_PATTERN P
          WHERE  P.CD_PATTERN = O.CD_OBJETO
          AND   (O.NM_OBJETO       LIKE '%'||pNM_OBJETO  ||'%' OR pNM_OBJETO   IS NULL)
          AND   (O.DS_OBJETO       LIKE '%'||pDS_OBJETO  ||'%' OR pDS_OBJETO   IS NULL)
          AND   (P.DS_PROBLEMA LIKE '%'||pDS_PROBLEMA||'%' OR pDS_PROBLEMA IS NULL)
          AND   (P.DS_SOLUCAO  LIKE '%'||pDS_SOLUCAO ||'%' OR pDS_SOLUCAO  IS NULL);

      ELSIF UPPER(TRIM(pTP_ESTRUT)) = 'AP' THEN     
          
          open p_cursor FOR
          SELECT O.CD_OBJETO                 ,
                 O.NM_OBJETO                 ,
                 O.DS_OBJETO                 ,
                 AP.DS_PROBLEMA      PROBLEMA,
                 AP.DS_RECOMENDACOES SOLUCAO          
          FROM   APPP_TB_OBJETO  O,
                 APPP_TB_ANTI_PATTERN AP
          WHERE  AP.CD_ANTI_PATTERN = O.CD_OBJETO
          AND   (O.NM_OBJETO         LIKE '%'||pNM_OBJETO  ||'%' OR pNM_OBJETO   IS NULL)
          AND   (O.DS_OBJETO         LIKE '%'||pDS_OBJETO  ||'%' OR pDS_OBJETO   IS NULL)
          AND   (AP.DS_PROBLEMA      LIKE '%'||pDS_PROBLEMA||'%' OR pDS_PROBLEMA IS NULL)
          AND   (AP.DS_RECOMENDACOES LIKE '%'||pDS_SOLUCAO ||'%' OR pDS_SOLUCAO  IS NULL);
        
     END IF;
  
  END IF;   
    
end APPP_SEL_APP;
/     
