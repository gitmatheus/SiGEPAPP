/****************************************************************************************
* Project Name         : SiGEPAPP
* APPP_INS_RELAC_ATRIB : Procedure para criação de dados de ATRIBUTOS DE RELACIONAMENTOS
*                        vResult(-99=ErroGeral, XX - código criado.)
* Author               : WeeDo 
* History              : 03/03/2009 - Matheus Gonçalves
*****************************************************************************************/
create or replace procedure APPP_INS_RELAC_ATRIB(pCD_RELAC    in out NUMBER,
                                                 pCD_ATRIBUTO in NUMBER,
                                                 pVL_RELAC    in VARCHAR2,
                                                 vResult     out number) is
begin
   
   insert into APPP_TB_RELAC_ATRIB( CD_RELAC    ,
                                    CD_ATRIBUTO ,
                                    VL_RELAC 
                                  )
                           values( pCD_RELAC    ,
                                   pCD_ATRIBUTO ,
                                   pVL_RELAC    
                                 );
   select APPP_SEQ_RELAC_ATRIB.CURRVAL 
   into pCD_RELAC 
   from dual;
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_INS_RELAC_ATRIB;
