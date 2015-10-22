/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_SEL_RELAC_PERG_RESP : Procedure para SELECIONAR dados de RELAC_PERG_RESPS
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Goncalves
*                          : 24/03/2009 - Matheus Goncalves - Criacao do atributo NR_VALOR_RESP
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RELAC_PERG_RESP(pCD_PERGUNTA   IN NUMBER,
                                                     pCD_RESPOSTA   IN NUMBER,
                                                     pNR_VALOR_RESP IN NUMBER,
                                                     p_cursor OUT SYS_REFCURSOR) is
begin
    
       open p_cursor FOR
       SELECT CD_PERGUNTA , 
              CD_RESPOSTA ,
              NR_VALOR_RESP 
       FROM APPP_TB_RELAC_PERG_RESP
       WHERE (CD_PERGUNTA   = pCD_PERGUNTA   OR pCD_PERGUNTA   IS NULL)
       AND   (CD_RESPOSTA   = pCD_RESPOSTA   OR pCD_RESPOSTA   IS NULL)
       and   (NR_VALOR_RESP = pNR_VALOR_RESP OR pNR_VALOR_RESP IS NULL);
        
                
end APPP_SEL_RELAC_PERG_RESP;
/
