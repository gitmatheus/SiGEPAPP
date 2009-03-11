/*******************************************************************************
* Project Name    : SiGEPAPP
* APPP_INS_OBJETO : Procedure para criação de dados de OBJETOS
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
********************************************************************************/
create or replace procedure APPP_INS_OBJETO(pCD_OBJETO       OUT NUMBER ,
                                            pNM_OBJETO       IN VARCHAR2,
                                            pCD_ESTRUTURA    IN NUMBER  ,
                                            pDS_OBJETO       IN VARCHAR2,
                                            --pDT_CRIACAO      IN DATE    ,
                                            pCD_USER_CRIADOR IN NUMBER,
                                            vResult         out number) is
begin
   
   insert into APPP_TB_OBJETO(CD_OBJETO      ,
                              NM_OBJETO      ,
                              CD_ESTRUTURA   ,
                              DS_OBJETO      ,
                              DT_CRIACAO     ,
                              CD_USER_CRIADOR
                             )
                      values( pCD_OBJETO      ,
                              pNM_OBJETO      ,
                              pCD_ESTRUTURA   ,
                              pDS_OBJETO      ,
                              SYSDATE         , -- DATA DE CRIAÇÃO É AGORA
                              pCD_USER_CRIADOR 
                             );
                             
   select APPP_SEQ_OBJETO.CURRVAL
   into pCD_OBJETO
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_OBJETO;
/