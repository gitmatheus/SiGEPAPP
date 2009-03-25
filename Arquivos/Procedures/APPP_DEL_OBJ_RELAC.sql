/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_OBJ_RELAC : Procedure para DELETAR dados de OBJ_RELACS
*                   vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -2292=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_OBJ_RELAC(pCD_RELAC            IN OUT NUMBER   ,
                                               pCD_OBJ_RELACIONADO  IN number   ,
                                               pCD_OBJ_RELACIONANDO IN number   , 
                                               pCD_ATRIBUTO_OBJ     IN NUMBER   ,                                               
                                               vResult    out number) is
                                                  
vERRO        VARCHAR2(600);  
begin
    
      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_OBJ_RELAC
      WHERE (CD_OBJ_RELACIONADO  = pCD_OBJ_RELACIONADO  OR pCD_OBJ_RELACIONADO  IS NULL)
      AND   (CD_OBJ_RELACIONANDO = pCD_OBJ_RELACIONANDO OR pCD_OBJ_RELACIONANDO IS NULL)
      AND   (CD_RELAC            = pCD_RELAC            OR pCD_RELAC            IS NULL)
      AND   (CD_ATRIBUTO_OBJ     = pCD_ATRIBUTO_OBJ     OR pCD_ATRIBUTO_OBJ     IS NULL);

      if vResult > 0 then

         DELETE FROM APPP_TB_OBJ_RELAC
         WHERE (CD_OBJ_RELACIONADO  = pCD_OBJ_RELACIONADO  OR pCD_OBJ_RELACIONADO  IS NULL)
         AND   (CD_OBJ_RELACIONANDO = pCD_OBJ_RELACIONANDO OR pCD_OBJ_RELACIONANDO IS NULL)
         AND   (CD_RELAC            = pCD_RELAC            OR pCD_RELAC            IS NULL)
         AND   (CD_ATRIBUTO_OBJ     = pCD_ATRIBUTO_OBJ     OR pCD_ATRIBUTO_OBJ     IS NULL);

         commit;
         
      end if;   
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- Não existe dado a ser deletado. 
        
     WHEN OTHERS THEN
         DECLARE
             error_code NUMBER := SQLCODE;
         BEGIN
             IF error_code = -2292 THEN
                ROLLBACK;
                vResult := -2292; -- Registros Filhos encontrados.
             ELSE
                rollback;
                 vResult := SQLCODE; -- Erro generico.
                 vERRO   := SUBSTR(SQLERRM,600);             
             END IF;
         END;      
               
end APPP_DEL_OBJ_RELAC;
/
