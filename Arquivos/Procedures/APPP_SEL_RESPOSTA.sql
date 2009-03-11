/**********************************************************************************************************************
* Project Name      : SiGEPAPP
* APPP_SEL_RESPOSTA : Procedure para SELECIONAR dados de RESPOSTAS
* Author            : WeeDo 
* History           : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_RESPOSTA(pCD_RESPOSTA IN NUMBER  ,
                                              pDS_RESPOSTA IN VARCHAR2 ,
                                              pNR_PESO_RESPOSTAINI NUMBER ,
                                              pNR_PESO_RESPOSTAFIM NUMBER ,
                                              p_cursor OUT SYS_REFCURSOR) is
begin
    
    IF pCD_RESPOSTA IS NOT NULL THEN
       
       open p_cursor FOR
       SELECT CD_RESPOSTA , 
              DS_RESPOSTA ,
              NR_PESO_RESPOSTA
       FROM APPP_TB_RESPOSTA
       WHERE CD_RESPOSTA = pCD_RESPOSTA;    
    
    ELSE      
    
       open p_cursor FOR
       SELECT CD_RESPOSTA , 
              DS_RESPOSTA ,
              NR_PESO_RESPOSTA 
       FROM APPP_TB_RESPOSTA AP
       WHERE (NR_PESO_RESPOSTA >= pNR_PESO_RESPOSTAINI AND pNR_PESO_RESPOSTAINI IS NOT NULL)
       AND   (NR_PESO_RESPOSTA <= pNR_PESO_RESPOSTAFIM AND pNR_PESO_RESPOSTAFIM IS NOT NULL)
       AND   (DS_RESPOSTA  like ('%'|| pDS_RESPOSTA || '%') OR pDS_RESPOSTA IS NULL);     
        
   END IF;                
end APPP_SEL_RESPOSTA;
/