/***********************************************************************************
* Project Name        : SiGEPAPP
* APPP_CREATE_PATTERN : Procedure para criacao de PATTERNS COMPLETO
*                       vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 16/03/2009 - Matheus Goncalves
***********************************************************************************/
create or replace procedure APPP_CREATE_PATTERN(pCD_OBJETO       OUT NUMBER ,
                                                pNM_OBJETO       IN VARCHAR2,
                                                pCD_ESTRUTURA    IN NUMBER  ,
                                                pDS_OBJETO       IN VARCHAR2,
                                                pCD_USER_CRIADOR IN NUMBER  ,
                                                pDS_PAT_PROBLEMA IN VARCHAR2,
                                                pDS_PAT_SOLUCAO  in VARCHAR2,
                                                vResult           out number) is
vERRO        VARCHAR2(600);
vCD_OBJETO   APPP_TB_OBJETO.CD_OBJETO%TYPE;

begin
  
   -- INSERE DADOS DO OBJETO E OBT�M O C�DIGO DO NOVO OBJETO
   insert into APPP_TB_OBJETO(NM_OBJETO      ,
                              CD_ESTRUTURA   ,
                              DS_OBJETO      ,
                              DT_CRIACAO     ,
                              CD_USER_CRIADOR
                             )
                      values( pNM_OBJETO      ,
                              pCD_ESTRUTURA   ,
                              pDS_OBJETO      ,
                              SYSDATE         , -- DATA DE CRIA��O � AGORA
                              pCD_USER_CRIADOR 
                             );
                             
   select APPP_SEQ_OBJETO.CURRVAL
   into vCD_OBJETO
   from dual;  
   
   -- INSERE O PATTERN
   insert into APPP_TB_PATTERN(CD_PATTERN      ,
                               DS_PAT_PROBLEMA ,
                               DS_PAT_SOLUCAO
                              )
                        values(vCD_OBJETO     ,
                               pDS_PAT_PROBLEMA,
                               pDS_PAT_SOLUCAO
                              );

   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_CREATE_PATTERN;
/
