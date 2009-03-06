/******************************************************************************
* Project Name     : SiGEPAPP
* APPP_INS_PERSONA : Procedure para criação de dados de PERSONAS
*                    vResult( 1=OK; -99=ErroGeral)
*                     
* Author           : WeeDo 
* History          : 04/03/2009 - Matheus Gonçalves
*******************************************************************************/
create or replace procedure APPP_INS_PERSONA(pCD_PERSONA NUMBER,
                                             pNM_PERSONA VARCHAR2,
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
        vResult := -99; -- Erro genérico.
               
end APPP_INS_PERSONA;
