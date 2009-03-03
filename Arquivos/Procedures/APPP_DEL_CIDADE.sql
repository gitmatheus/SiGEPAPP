/*****************************************************************************************************
* Project Name    : SiGEPAPP
* APPP_DEL_CIDADE : Procedure para DELETAR dados de CIDADES
*                   vResult( 0=NadaDeletado; 
*                            xx=OK (Quantidade de registros apagados); 
*                            -99=ErroGeral; 
*                            -90=Existem Registros Filhos;
*                           )
* Author          : WeeDo 
* History         : 03/03/2009 - Matheus Gon�alves
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
       
  vEXISTE  NUMBER(5); 
  i        number(10); 
  
  --Declara��o de vetor
  TYPE NUMS IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  VETOR NUMS;
  
begin
    
   if pCD_CIDADE is not null then
      /**********************************************************
      *  EXECUTA ESSA PARTE SE FOI INFORMADO O C�DIGO DA CIDADE.
      *  VERIFICA SE A CIDADE PODE SER EXCLU�DA.
      ***********************************************************/

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_CIDADE T
      WHERE T.CD_CIDADE  = pCD_CIDADE;
      
      SELECT COUNT(*) INTO vEXISTE
      FROM APPP_TB_CODIGO_POSTAL CP
      WHERE CP.CD_CIDADE = pCD_CIDADE;

      IF vEXISTE > 0 THEN 
          --N�o � poss�vel excluir o registro, existem c�digos postais com essa cidade.
          vResult := -90 ;       
     
      elsif vResult > 0 then

         DELETE FROM APPP_TB_CIDADE C
         WHERE C.CD_CIDADE  = pCD_CIDADE;

         commit;
         
      end if;   
      
   else 
       
     /**************************************************************
      *  EXECUTA ESSA PARTE SE N�O FOI INFORMADO O C�DIGO DA CIDADE.
      *  ABRE UM CURSOR USANDO OS PAR�METROS.
      *  JOGA TODOS OS C�DIGOS DE CIDADE RETORNADOS PELO CURSOR EM 
         UM VETOR DE C�DIGOS, QUE SER� USADO PARA VERIFICAR SE A(S) 
         CIDADE(s) PODE(m) SER EXCLU�DA(S).
      **************************************************************/
       vResult := 1;
       i       := 1;
       vEXISTE := 0;
       
       OPEN C;
       LOOP 
          
          FETCH C INTO VETOR(i);
          EXIT WHEN C%NOTFOUND OR vEXISTE > 0;
          
          -- VERIFICA SE EXISTE ALGUM C�DIGO POSTAL
          -- FOI CADASTRADO COM ESSA CIDADE.
          SELECT COUNT(*) INTO vEXISTE
          FROM APPP_TB_CODIGO_POSTAL CP
          WHERE CP.CD_CIDADE = VETOR(i);
          
          IF vEXISTE > 0 then
             --N�o � poss�vel excluir os registro, existem c�digos postais com essa cidade.
             vResult := -90 ; 
          END IF;
          
          i := i + 1;
       END LOOP; 
       CLOSE C;  
        i := i - 1;
       if vResult > 0 then
             
          -- Ok. Ent�o todas as cidades retornadas pelo cursor podem ser exclu�das.
          -- Varre agora o vetor e vai executando os deletes.
          FOR j IN 1 .. i LOOP
              
             DELETE FROM APPP_TB_CIDADE C
             WHERE C.CD_CIDADE  = VETOR(j); 
            
          END LOOP;
          vResult := i;
          commit;
       end if;   
       
   end if;
   
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
        rollback;
        vResult := 0; -- N�o existe dado a ser deletado. 
        
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_DEL_CIDADE;
