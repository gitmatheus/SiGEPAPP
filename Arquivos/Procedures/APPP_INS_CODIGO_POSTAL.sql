create or replace procedure APPP_INS_CODIGO_POSTAL(pCD_CEP    IN NUMBER   ,
                                                   pNM_RUA    IN VARCHAR2 ,
                                                   pCD_CIDADE IN NUMBER   ,
                                                   pCD_ESTADO IN NUMBER   ,
                                                   vResult     out number) is
begin

   insert into APPP_TB_CODIGO_POSTAL(CD_CEP    ,
                                     NM_RUA    ,
                                     CD_CIDADE ,
                                     CD_ESTADO
                                    )
                             values( pCD_CEP    ,
                                     pNM_RUA    ,
                                     pCD_CIDADE ,
                                     pCD_ESTADO
                                   );
   vResult := 1; -- OK
   commit;

   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.

end APPP_INS_CODIGO_POSTAL;
/
