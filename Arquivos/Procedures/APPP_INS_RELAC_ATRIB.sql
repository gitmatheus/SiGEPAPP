/****************************************************************************************
* Project Name         : SiGEPAPP
* APPP_INS_RELAC_ATRIB : Procedure para cria��o de dados de ATRIBUTOS DE RELACIONAMENTOS
*                        vResult(-99=ErroGeral, XX - c�digo criado.)
* Author               : WeeDo 
* History              : 03/03/2009 - Matheus Gon�alves
*****************************************************************************************/
create or replace procedure APPP_INS_RELAC_ATRIB(pCD_RELAC    in out NUMBER,
                                                 pCD_ATRIBUTO in NUMBER,
                                                 pVL_RELAC    in VARCHAR2,
                                                 vResult     out number) is
vERRO        VARCHAR2(600);
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
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_RELAC_ATRIB;
/