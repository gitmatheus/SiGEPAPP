/**********************************************************************************************************************
* Project Name           : SiGEPAPP
* APPP_SEL_USER_ENDERECO : Procedure para SELECIONAR dados de USER_ENDERECOS
* Author                 : WeeDo 
* History                : 04/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_USER_ENDERECO(pCD_USER        IN NUMBER  ,
                                                   pNR_CEP         IN NUMBER  ,
                                                   pNR_NUMERO      IN NUMBER  ,
                                                   pDS_COMPLEMENTO IN VARCHAR2,
                                                   pTP_ENDERECO    IN VARCHAR2,
                                                   p_cursor OUT SYS_REFCURSOR   ) is
begin
    
       open p_cursor FOR
       SELECT CD_USER        ,
              NR_CEP         ,
              NR_NUMERO      ,
              DS_COMPLEMENTO ,
              TP_ENDERECO        
       FROM APPP_TB_USER_ENDERECO
       WHERE (CD_USER     = pCD_USER     OR pCD_USER     IS NULL)
       AND   (NR_CEP      = pNR_CEP      OR pNR_CEP      IS NULL)
       AND   (NR_NUMERO   = pNR_NUMERO   OR pNR_NUMERO   IS NULL)
       AND   (DS_COMPLEMENTO like ('%'|| pDS_COMPLEMENTO || '%') OR pDS_COMPLEMENTO IS NULL)
       AND   (TP_ENDERECO = pTP_ENDERECO OR pTP_ENDERECO IS NULL);     
            
end APPP_SEL_USER_ENDERECO;
