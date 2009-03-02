/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_INS_ANTI_PATTERN : Procedure para criação de dados de ANTI-PATTERNS
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 02/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_ANTI_PATTERN(vCD_ANTI_PATTERN  in NUMBER  , 
                                                  vDS_SINTOMAS      in VARCHAR2, 
                                                  vDS_RECOMENDACOES in VARCHAR2,
                                                  vDS_CONSEQUENCIAS in VARCHAR2,
                                                  vDS_BARREIRAS     in VARCHAR2,
                                                  vResult           out number) is
begin
    
   insert into APPP_TB_ANTI_PATTERN(CD_ANTI_PATTERN  ,
                                    DS_SINTOMAS      , 
                                    DS_RECOMENDACOES ,
                                    DS_CONSEQUENCIAS ,
                                    DS_BARREIRAS
                                    )
                              values(vCD_ANTI_PATTERN  ,
                                     vDS_SINTOMAS      , 
                                     vDS_RECOMENDACOES ,
                                     vDS_CONSEQUENCIAS ,
                                     vDS_BARREIRAS
                                    );
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_ANTI_PATTERN;
