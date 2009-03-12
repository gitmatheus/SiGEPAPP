/*****************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_DEL_USER : Procedure para DELETAR dados de USERS
*                 vResult( 0=NadaDeletado; 
*                          xx=OK (Quantidade de registros apagados); 
*                          -99=ErroGeral; 
*                          -2292=Existem Registros Filhos;
*                        )
* Author        : WeeDo 
* History       : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_USER(pCD_USER           IN NUMBER       ,
                                          pNM_PRIM_NOME      IN VARCHAR2     ,
                                          pNM_ULT_NOME       IN VARCHAR2     , 
                                          pDT_NASCINI        IN DATE         ,
                                          pDT_NASCFIM        IN DATE         ,
                                          pNR_NOTAINI        IN NUMBER       ,
                                          pNR_NOTAFIM        IN NUMBER       ,
                                          pDT_CADASTROINI    IN DATE         , 
                                          pDT_CADASTROFIM    IN DATE         ,
                                          pDS_AREA_INTERESSE IN VARCHAR2     ,
                                          pNM_MSN            IN VARCHAR2     ,
                                          pNM_SKYPE          IN VARCHAR2     ,
                                          vResult    out number) is

  CURSOR C1 IS
     select U.CD_USER         
     from   appp_tb_user  U
     WHERE  U.CD_USER = pCD_USER;

  CURSOR C2 IS 
    select U.CD_USER         
    from   appp_tb_user  U
    where (U.NM_PRIM_NOME LIKE '%'||pNM_PRIM_NOME||'%' OR pNM_PRIM_NOME   IS NULL)
    AND   (U.NM_ULT_NOME  LIKE '%'||pNM_ULT_NOME ||'%' OR pNM_ULT_NOME    IS NULL)
    AND   (U.DT_NASC     >= pDT_NASCINI                OR pDT_NASCINI     IS NULL)
    AND   (U.DT_NASC     <= pDT_NASCFIM                OR pDT_NASCFIM     IS NULL)
    AND   (U.NR_NOTA     >= pNR_NOTAINI                OR pNR_NOTAINI     IS NULL)
    AND   (U.NR_NOTA     <= pNR_NOTAFIM                OR pNR_NOTAFIM     IS NULL)
    AND   (U.DT_CADASTRO >= pDT_CADASTROINI            OR pDT_CADASTROINI IS NULL)
    AND   (U.DT_CADASTRO <= pDT_CADASTROFIM            OR pDT_CADASTROFIM IS NULL)
    AND   (U.NM_MSN       = pNM_MSN                    OR pNM_MSN         IS NULL)
    AND   (U.NM_SKYPE     = pNM_SKYPE                  OR pNM_SKYPE       IS NULL);

  vCD_TEMP appp_tb_user.cd_user%TYPE;                                                  
  vERRO        VARCHAR2(600);
begin
    
   vResult := 0;

   IF pCD_USER IS NOT NULL THEN
     
      OPEN C1;
      LOOP 
          FETCH C1 INTO vCD_TEMP;
          EXIT WHEN C1%NOTFOUND;
          vResult := vResult + 1;
    
          DELETE FROM APPP_TB_USER
          WHERE CD_USER = vCD_TEMP;
         
       END LOOP; 
       CLOSE C1;      
    
    ELSE
    
       OPEN C2;
       --Se não foi informado o código, 
       --Ele busca dados a serem apagados conforme os parâmetros.
       --Com os códigos em mão é só fazer a exclusão dos dados.
       LOOP 
          FETCH C2 INTO vCD_TEMP;
          EXIT WHEN C2%NOTFOUND;
          vResult := vResult + 1; 
   
          DELETE FROM APPP_TB_USER
          WHERE CD_USER = vCD_TEMP;
         
       END LOOP; 
       CLOSE C2;  
       
    END IF;
    
    if vResult > 0 then
          commit;
    end if;        
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- Não existe dado a ser deletado. 
        
     WHEN OTHERS THEN
         DECLARE
             error_code NUMBER := SQLCODE;
         BEGIN
             IF error_code = -2292 THEN
                ROLLBACK;
                vResult := -2292; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := SQLCODE; -- Erro generico.
                vERRO   := SUBSTR(SQLERRM,600);
             END IF;
         END;      
               
end APPP_DEL_USER;
/