/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_CIDADE : Procedure para DELETAR dados de CIDADES
*                   vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -90=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 03/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_CIDADE(pCD_CIDADE IN NUMBER,
                                            pNM_CIDADE IN VARCHAR2,
                                            pNM_ABREV  IN VARCHAR2,
                                            pCD_ESTADO IN NUMBER,
                                            vResult     out number) is
                                                  
  CURSOR C IS 
       SELECT CD_CIDADE
       FROM APPP_TB_CIDADE C
       WHERE (C.NM_CIDADE like ('%'|| pNM_CIDADE || '%') OR pNM_CIDADE  IS NULL)
       AND   (C.NM_ABREV  like ('%'|| pNM_ABREV || '%')  OR pNM_ABREV   IS NULL)
       AND   (C.CD_ESTADO = pCD_ESTADO OR pCD_ESTADO IS NULL); 
       
  vTemp  NUMBER(5); 
  
begin
    
   if pCD_CIDADE is not null then

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_CIDADE T
      WHERE T.CD_CIDADE  = pCD_CIDADE;

      if vResult > 0 then

         DELETE FROM APPP_TB_CIDADE C
         WHERE C.CD_CIDADE  = pCD_CIDADE;

         commit;
         
      end if;   
      
   else 
      
       OPEN C;
       LOOP 
          
          FETCH C INTO vTemp;
          EXIT WHEN C%NOTFOUND;
          
          DELETE FROM APPP_TB_CIDADE C
          WHERE C.CD_CIDADE  = vTemp; 
          
          vResult := vResult + 1;

       END LOOP; 
       CLOSE C;  

       if vResult > 0 then
          commit;
       end if;   
       
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
                vResult := -90; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := -99; -- Erro genérico.             
             END IF;
         END;      
               
end APPP_DEL_CIDADE;

/
