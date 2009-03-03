/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_INS_ANTI_PATTERN : Procedure para criação de dados de ANTI-PATTERNS
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_ANTI_PATTERN(pCD_ANTI_PATTERN  in NUMBER  , 
                                                  pDS_SINTOMAS      in VARCHAR2, 
                                                  pDS_RECOMENDACOES in VARCHAR2,
                                                  pDS_CONSEQUENCIAS in VARCHAR2,
                                                  pDS_BARREIRAS     in VARCHAR2,
                                                  vResult           out number) is
begin
    
   insert into APPP_TB_ANTI_PATTERN(CD_ANTI_PATTERN  ,
                                    DS_SINTOMAS      , 
                                    DS_RECOMENDACOES ,
                                    DS_CONSEQUENCIAS ,
                                    DS_BARREIRAS
                                    )
                              values(pCD_ANTI_PATTERN  ,
                                     pDS_SINTOMAS      , 
                                     pDS_RECOMENDACOES ,
                                     pDS_CONSEQUENCIAS ,
                                     pDS_BARREIRAS
                                    );
  
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_ANTI_PATTERN;
