/****************************************************************************************
* Project Name        : SiGEPAPP
* APPP_UPD_OBJ_RELAC : Procedure para ATUALIZAÇÃO de dados de OBJ_RELACS
*                      vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gonçalves
******************************************************************************************/

create or replace procedure APPP_UPD_OBJ_RELAC(pCD_RELAC            IN NUMBER   ,
                                               pCD_OBJ_RELACIONADO  IN number   ,
                                               pCD_OBJ_RELACIONANDO IN number   , 
                                               pCD_ATRIBUTO_OBJ     IN NUMBER   ,
                                               pVL_RELAC            IN VARCHAR2 ,
                                               vResult     out number) is
vERRO        VARCHAR2(600);
begin
   
     UPDATE APPP_TB_OBJ_RELAC 
           SET VL_RELAC        = pVL_RELAC       ,
               CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJ
     WHERE (  (CD_RELAC  = pCD_RELAC AND pCD_RELAC IS NOT NULL)
            OR(      CD_OBJ_RELACIONADO = pCD_OBJ_RELACIONADO   AND pCD_OBJ_RELACIONADO IS NOT NULL 
                 AND CD_OBJ_RELACIONANDO = pCD_OBJ_RELACIONANDO AND pCD_OBJ_RELACIONANDO IS NOT NULL 
               )
           )  ;
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
        
  
     null;
               
end APPP_UPD_OBJ_RELAC;
/
