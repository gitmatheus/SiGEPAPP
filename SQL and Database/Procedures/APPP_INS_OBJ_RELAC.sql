/*******************************************************************************
* Project Name       : SiGEPAPP
* APPP_INS_OBJ_RELAC : Procedure para criação de dados de OBJ_RELAC
*                      vResult( 1=OK; -99=ErroGeral)
* Author             : WeeDo 
* History            : 04/03/2009 - Matheus Gonçalves
********************************************************************************/
create or replace procedure APPP_INS_OBJ_RELAC(pCD_RELAC            IN OUT NUMBER   ,
                                               pCD_OBJ_RELACIONADO  IN number   ,
                                               pCD_OBJ_RELACIONANDO IN number   , 
                                               pCD_ATRIBUTO_OBJ     IN NUMBER   ,
                                               pVL_RELAC            IN VARCHAR2 ,
                                               vResult          out number) is
vERRO        VARCHAR2(600);
begin
   
   insert into APPP_TB_OBJ_RELAC(CD_OBJ_RELACIONADO  ,
                                 CD_OBJ_RELACIONANDO ,
                                 CD_ATRIBUTO_OBJ     ,
                                 VL_RELAC
                                )
                          values(pCD_OBJ_RELACIONADO  ,
                                 pCD_OBJ_RELACIONANDO ,
                                 pCD_ATRIBUTO_OBJ     ,
                                 pVL_RELAC
                                );          
                                                   
   SELECT APPP_SEQ_OBJ_RELAC.CURRVAL INTO pCD_RELAC FROM DUAL ; 
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_OBJ_RELAC;
/
