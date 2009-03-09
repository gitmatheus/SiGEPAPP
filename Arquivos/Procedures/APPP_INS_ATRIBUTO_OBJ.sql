/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_INS_ATRIBUTO_OBJ : Procedure para criação de dados de ATRIBUTOS
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
*                       : 09/03/2009 - Matheus Gonçalves - Criação da coluna NM_COLUNA
***********************************************************************************************************************/
create or replace procedure APPP_INS_ATRIBUTO_OBJ(pCD_ATRIBUTO_OBJ IN OUT NUMBER   ,
                                                  pNM_ATRIBUTO_OBJ IN VARCHAR2 , 
                                                  pDS_ATRIBUTO_OBJ IN VARCHAR2 ,
                                                  pCD_TIPO         IN NUMBER   ,
                                                  pFL_ATRIB_RELAC  IN VARCHAR2 ,
                                                  vResult           out number) is
   vNM_COLUNA VARCHAR2(100);
                                                  
begin
   
   vNM_COLUNA := APPP_FN_NM_COL_ATRIB(pNM_ATRIBUTO_OBJ);
   
   insert into APPP_TB_ATRIBUTO_OBJ( CD_ATRIBUTO_OBJ,
                                     NM_ATRIBUTO_OBJ, 
                                     DS_ATRIBUTO_OBJ,
                                     CD_TIPO        ,
                                     FL_ATRIB_RELAC ,
                                     NM_COLUNA
                                    )
                             values( pCD_ATRIBUTO_OBJ,
                                     pNM_ATRIBUTO_OBJ, 
                                     pDS_ATRIBUTO_OBJ,
                                     pCD_TIPO        ,
                                     pFL_ATRIB_RELAC ,
                                     vNM_COLUNA
                                    );
   select APPP_SEQ_ATRIBUTO_OBJ.CURRVAL
   into pCD_ATRIBUTO_OBJ
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_ATRIBUTO_OBJ;
