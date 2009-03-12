/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_ESTADO : Procedure para DELETAR dados de ESTADOS
*                   vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -90=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_ESTADO(pCD_ESTADO IN NUMBER,
                                            pNM_ESTADO IN VARCHAR2,
                                            pSG_SIGLA  VARCHAR2,
                                            vResult    out number) is
                                                  
  CURSOR C IS 
       SELECT CD_ESTADO
       FROM APPP_TB_ESTADO
       WHERE (NM_ESTADO like ('%'|| pNM_ESTADO || '%') OR pNM_ESTADO  IS NULL)
       AND   (SG_SIGLA  = pSG_SIGLA OR pSG_SIGLA IS NULL);
             
  vTemp  NUMBER(5);
  vERRO        VARCHAR2(600);
  
begin
    
   if pCD_ESTADO is not null then

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_ESTADO T
      WHERE T.CD_ESTADO  = pCD_ESTADO;

      if vResult > 0 then

         DELETE FROM APPP_TB_ESTADO C
         WHERE C.CD_ESTADO  = pCD_ESTADO;

         commit;
         
      end if;   
      
   else 
      
       OPEN C;
       LOOP 
          
          FETCH C INTO vTemp;
          EXIT WHEN C%NOTFOUND;
          
          DELETE FROM APPP_TB_ESTADO C
          WHERE C.CD_ESTADO  = vTemp; 
          
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
                 vResult := SQLCODE; -- Erro generico.
                 vERRO   := SUBSTR(SQLERRM,600);            
             END IF;
         END;      
               
end APPP_DEL_ESTADO;
/
