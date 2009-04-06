/******************************************************************************
* Project Name     : SiGEPAPP
* APPP_INS_PERSONA : Procedure para criação de dados de PERSONAS
*                    vResult( 1=OK; -99=ErroGeral)
*                     
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Goncalves
*                  : 30/03/2009 - Matheus Goncalves - Alteracao de Parametro
*******************************************************************************/
create or replace procedure APPP_INS_PERSONA(pCD_PERSONA IN NUMBER,
                                             pNM_PERSONA IN VARCHAR2,
                                             pURL_FOTO   IN VARCHAR2,
                                             vResult     out number) is
                                     
vERRO        VARCHAR2(600);
begin
    
      
 
   insert into APPP_TB_PERSONA(CD_PERSONA ,
                               NM_PERSONA ,
                               URL_FOTO
                              )
                        values(pCD_PERSONA ,
                               pNM_PERSONA ,
                               pURL_FOTO
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_PERSONA;
/
