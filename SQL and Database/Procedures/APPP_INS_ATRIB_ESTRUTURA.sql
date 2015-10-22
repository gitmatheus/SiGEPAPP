/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_INS_ATRIB_ESTRUTURA : Procedure para criação de dados de ATRIBUTOS x ESTRUTURAS
*                             vResult( 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 06/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_ATRIB_ESTRUTURA(pCD_ESTRUTURA    IN NUMBER, 
                                                     pCD_ATRIBUTO_OBJ IN NUMBER ,
                                                     vResult           out number) is
vERRO        VARCHAR2(600);
begin
   
   insert into APPP_TB_ATRIB_ESTRUTURA( CD_ESTRUTURA    , 
                                        CD_ATRIBUTO_OBJ
                                       )
                                values( pCD_ESTRUTURA    , 
                                        pCD_ATRIBUTO_OBJ  
                                       );
                                       
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_ATRIB_ESTRUTURA;
/