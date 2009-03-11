/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_OBJETO : Procedure para DELETAR dados de OBJETOS
*                   vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -2292=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_OBJETO(pCD_OBJETO       IN NUMBER ,
                                            pNM_OBJETO       IN VARCHAR2,
                                            pCD_ESTRUTURA    IN NUMBER  ,
                                            pDS_OBJETO       IN VARCHAR2,
                                            pDT_CRIACAOINI   IN DATE  , 
                                            pDT_CRIACAOFIM   IN DATE  , 
                                            pCD_USER_CRIADOR IN NUMBER,
                                            vResult    out number) is
                                                  
  CURSOR C IS 
       SELECT CD_OBJETO
       FROM APPP_TB_OBJETO
       WHERE (NM_OBJETO like ('%'|| pNM_OBJETO ||'%') OR pNM_OBJETO       IS NULL)
       AND   (CD_ESTRUTURA    = pCD_ESTRUTURA         OR pCD_ESTRUTURA    IS NULL)
       AND   (DS_OBJETO LIKE ('%'|| pDS_OBJETO ||'%') OR pDS_OBJETO       IS NULL)
       AND   (DT_CRIACAO     >= pDT_CRIACAOINI        OR pDT_CRIACAOINI   IS NULL)
       AND   (DT_CRIACAO     <= pDT_CRIACAOFIM        OR pDT_CRIACAOFIM   IS NULL)
       AND   (CD_USER_CRIADOR = pCD_USER_CRIADOR      OR pCD_USER_CRIADOR IS NULL);
             
  vTemp  NUMBER(5); 
  
begin
    
   if pCD_OBJETO is not null then

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_OBJETO
      WHERE CD_OBJETO  = pCD_OBJETO;

      if vResult > 0 then

         DELETE FROM APPP_TB_OBJETO
         WHERE CD_OBJETO  = pCD_OBJETO;

         commit;
         
      end if;   
      
   else 
      
       OPEN C;
       LOOP 
          
          FETCH C INTO vTemp;
          EXIT WHEN C%NOTFOUND;
          
          DELETE FROM APPP_TB_OBJETO
          WHERE CD_OBJETO  = vTemp; 
          
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
                vResult := -2292; -- Registros Filhos encontrados.
             ELSE
                rollback;
                vResult := -99; -- Erro genérico.             
             END IF;
         END;      
               
end APPP_DEL_OBJETO;
/
