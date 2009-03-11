/**********************************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_INS_ESTADO : Procedure para cria��o de dados de ESTADOS
*                   vResult( 1=OK; -99=ErroGeral)
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_INS_ESTADO(pCD_ESTADO OUT NUMBER,
                                            pNM_ESTADO IN VARCHAR2  ,
                                            pSG_SIGLA  VARCHAR2     ,
                                            vResult    out number) is
begin
   
   insert into APPP_TB_ESTADO( CD_ESTADO,
                               NM_ESTADO, 
                               SG_SIGLA 
                             )
                       values( pCD_ESTADO,
                               pNM_ESTADO, 
                               pSG_SIGLA 
                             );
                             
   select APPP_SEQ_ESTADO.CURRVAL
   into pCD_ESTADO
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_ESTADO;
/