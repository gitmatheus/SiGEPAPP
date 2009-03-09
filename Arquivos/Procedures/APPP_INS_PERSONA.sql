/******************************************************************************
* Project Name     : SiGEPAPP
* APPP_INS_PERSONA : Procedure para cria��o de dados de PERSONAS
*                    vResult( 1=OK; -99=ErroGeral)
*                     
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gon�alves
*******************************************************************************/
create or replace procedure APPP_INS_PERSONA(pCD_PERSONA IN NUMBER,
                                             pNM_PERSONA IN VARCHAR2,
                                             vResult     out number) is
 vImgPath varchar2(6) := '/img/';                                           
                                              
begin
    
      
 
   insert into APPP_TB_PERSONA(CD_PERSONA ,
                               NM_PERSONA ,
                               URL_FOTO
                              )
                        values(pCD_PERSONA ,
                               pNM_PERSONA ,
                               vImgPath || 'IMG_' || to_char(pCD_PERSONA,'9999999999') || '.jpg'
                              );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_PERSONA;
