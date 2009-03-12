/******************************************************************************************
* Project Name             : SiGEPAPP
* APPP_UPD_ATRIB_ESTRUTURA : Procedure para ATUALIZAÇÃO de dados de ATRIBUTOS X ESTRUTURAS
*                            vResult( 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Gonçalves
******************************************************************************************/
create or replace procedure APPP_UPD_ATRIB_ESTRUTURA(pCD_ESTRUTURA       IN NUMBER, 
                                                     pCD_ATRIBUTO_OBJOLD IN NUMBER,
                                                     pCD_ATRIBUTO_OBJNEW IN NUMBER,
                                                     vResult           out number) is
vERRO        VARCHAR2(600);
begin
    
   IF pCD_ATRIBUTO_OBJOLD IS NOT NULL AND pCD_ATRIBUTO_OBJNEW IS NOT NULL THEN
      UPDATE APPP_TB_ATRIB_ESTRUTURA 
      SET CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJNEW
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA
      AND   CD_ATRIBUTO_OBJ = pCD_ATRIBUTO_OBJOLD;
   END IF;   
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_UPD_ATRIB_ESTRUTURA;
/