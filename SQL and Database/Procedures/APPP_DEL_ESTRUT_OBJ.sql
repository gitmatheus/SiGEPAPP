/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_ESTRUT_OBJ : Procedure para DELETAR dados de ESTRUT_OBJS
*                       vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -90=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 04/03/2009 - Matheus Gonçalves
******************************************************************************************************/
create or replace procedure APPP_DEL_ESTRUT_OBJ(pCD_ESTRUTURA  IN NUMBER,
                                                pNM_ESTRUTURA  IN VARCHAR2,
                                                pDS_ESTRUTURA  IN VARCHAR2,
                                                pDT_CRIACAOINI IN DATE    ,
                                                pDT_CRIACAOFIM IN DATE    ,
                                                pCD_USER       IN NUMBER  ,
                                                pTP_ESTRUTURA  IN VARCHAR2,
                                                vResult        out number) is
                                                  
  CURSOR C IS 
       SELECT CD_ESTRUTURA
       FROM APPP_TB_ESTRUT_OBJ
       WHERE (NM_ESTRUTURA like ('%'|| pNM_ESTRUTURA || '%') OR pNM_ESTRUTURA  IS NULL)
       AND   (DS_ESTRUTURA like ('%'|| pDS_ESTRUTURA || '%') OR pDS_ESTRUTURA  IS NULL)
       AND   (DT_CRIACAO  >= pDT_CRIACAOINI                  OR pDT_CRIACAOINI IS NULL)
       AND   (DT_CRIACAO  <= pDT_CRIACAOFIM                  OR pDT_CRIACAOFIM IS NULL)
       AND   (CD_USER      = pCD_USER                        OR pCD_USER       IS NULL)
       AND   (TP_ESTRUTURA = pTP_ESTRUTURA                   OR pTP_ESTRUTURA  IS NULL);
       
  vTemp  NUMBER(5);
  vERRO        VARCHAR2(600);
  
begin
    
   if pCD_ESTRUTURA is not null then

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_ESTRUT_OBJ
      WHERE CD_ESTRUTURA  = pCD_ESTRUTURA;

      if vResult > 0 then

         DELETE FROM APPP_TB_ESTRUT_OBJ
         WHERE CD_ESTRUTURA  = pCD_ESTRUTURA;

         commit;
         
      end if;   
      
   else 
      
       OPEN C;
       LOOP 
          
          FETCH C INTO vTemp;
          EXIT WHEN C%NOTFOUND;
          
          DELETE FROM APPP_TB_ESTRUT_OBJ
          WHERE CD_ESTRUTURA  = vTemp; 
          
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
               
end APPP_DEL_ESTRUT_OBJ;
/
