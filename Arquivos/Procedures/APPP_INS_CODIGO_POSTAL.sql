create or replace procedure APPP_INS_CODIGO_POSTAL(pCD_CEP    IN NUMBER   ,
                                                   pNM_RUA    IN VARCHAR2 ,
                                                   pCD_CIDADE IN NUMBER   ,
                                                   vResult     out number) is
begin

   insert into APPP_TB_CODIGO_POSTAL(CD_CEP    ,
                                     NM_RUA    ,
                                     CD_CIDADE
                                    )
                             values( pCD_CEP    ,
                                     pNM_RUA    ,
                                     pCD_CIDADE
                                   );
   vResult := 1; -- OK
   commit;

   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.

end APPP_INS_CODIGO_POSTAL;
/
