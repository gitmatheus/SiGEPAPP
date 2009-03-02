/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_INS_ATRIBUTO_OBJ : Procedure para criação de dados de ATRIBUTOS
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_ATRIBUTO_OBJ(pCD_ATRIBUTO_OBJ IN NUMBER   ,
                                                  pNM_ATRIBUTO_OBJ IN VARCHAR2 , 
                                                  pDS_ATRIBUTO_OBJ IN VARCHAR2 ,
                                                  pCD_TIPO         IN NUMBER   ,
                                                  pFL_ATRIB_RELAC  IN VARCHAR2 ,
                                                  vResult           out number) is
begin
   
   insert into APPP_TB_ATRIBUTO_OBJ( CD_ATRIBUTO_OBJ,
                                     NM_ATRIBUTO_OBJ, 
                                     DS_ATRIBUTO_OBJ,
                                     CD_TIPO        ,
                                     FL_ATRIB_RELAC
                                    )
                             values( pCD_ATRIBUTO_OBJ,
                                     pNM_ATRIBUTO_OBJ, 
                                     pDS_ATRIBUTO_OBJ,
                                     pCD_TIPO        ,
                                     pFL_ATRIB_RELAC 
                                    );
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_ATRIBUTO_OBJ;
