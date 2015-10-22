/*******************************************************************************
* Project Name    : SiGEPAPP
* APPP_INS_OBJETO : Procedure para criacao de dados de OBJETOS
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Goncalves
*                 : 06/05/2009 - Matheus Goncalves - Flag de Ativo
********************************************************************************/
create or replace procedure APPP_INS_OBJETO(pCD_OBJETO       OUT NUMBER ,
                                            pNM_OBJETO       IN VARCHAR2,
                                            pCD_ESTRUTURA    IN NUMBER  ,
                                            pDS_OBJETO       IN VARCHAR2,
                                            --pDT_CRIACAO      IN DATE    ,
                                            pCD_USER_CRIADOR IN NUMBER,
																						pFL_ATIVO        IN NUMBER, 
                                            vResult         out number) is
vERRO        VARCHAR2(600);
begin
   
   insert into APPP_TB_OBJETO(CD_OBJETO      ,
                              NM_OBJETO      ,
                              CD_ESTRUTURA   ,
                              DS_OBJETO      ,
                              DT_CRIACAO     ,
                              CD_USER_CRIADOR,
															FL_ATIVO
                             )
                      values( pCD_OBJETO      ,
                              pNM_OBJETO      ,
                              pCD_ESTRUTURA   ,
                              pDS_OBJETO      ,
                              SYSDATE         , -- DATA DE CRIAÇÃO É AGORA
                              pCD_USER_CRIADOR,
															pFL_ATIVO 
                             );
                             
   select APPP_SEQ_OBJETO.CURRVAL
   into pCD_OBJETO
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_OBJETO;
/
