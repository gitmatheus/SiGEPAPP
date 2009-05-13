/**************************************************************************************
* Project Name             : SiGEPAPP
* APPP_INS_RELAC_PERG_RESP : Procedure para criacao de dados de RESPOSTA x PERGUNTAS
*                            vResult( 1=OK; -99=ErroGeral)                     
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Goncalves - Versao Inicial
*                          : 13/05/2009 - Matheus Goncalves - Opcao de atualizacao
***************************************************************************************/
create or replace procedure APPP_INS_RELAC_PERG_RESP(pCD_PERGUNTA   IN NUMBER,
                                                     pCD_RESPOSTA   IN NUMBER,
                                                     pNR_VALOR_RESP IN NUMBER,
																										 OP_UPDATE      IN VARCHAR2 DEFAULT 'N',
                                                     vResult     out number) is
vERRO        VARCHAR2(600);
begin
    
   insert into APPP_TB_RELAC_PERG_RESP(CD_PERGUNTA ,
                                       CD_RESPOSTA,
                                       NR_VALOR_RESP   
                                        )
                                 values( pCD_PERGUNTA ,
                                         pCD_RESPOSTA ,
                                         pNR_VALOR_RESP 
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION 
	   WHEN OTHERS THEN
        rollback;
				IF OP_UPDATE = 'S' AND SQLCODE = -1 THEN
				   APPP_UPD_RELAC_PERG_RESP(pCD_PERGUNTA,pCD_RESPOSTA, pNR_VALOR_RESP,vResult);
				ELSE   
           vResult := SQLCODE; -- Erro generico.
           vERRO   := SUBSTR(SQLERRM,600);
        END IF;       
end APPP_INS_RELAC_PERG_RESP;
/
