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
       
  vEXISTE  NUMBER(5); 
  i        number(10); 
  
  --Declaração de vetor
  TYPE NUMS IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  VETOR NUMS;
  
begin
    
   if pCD_CIDADE is not null then
      /**********************************************************
      *  EXECUTA ESSA PARTE SE FOI INFORMADO O CÓDIGO DA CIDADE.
      *  VERIFICA SE A CIDADE PODE SER EXCLUÍDA.
      ***********************************************************/

      SELECT COUNT(*) INTO vResult
      FROM APPP_TB_CIDADE T
      WHERE T.CD_CIDADE  = pCD_CIDADE;
      
      SELECT COUNT(*) INTO vEXISTE
      FROM APPP_TB_CODIGO_POSTAL CP
      WHERE CP.CD_CIDADE = pCD_CIDADE;

      IF vEXISTE > 0 THEN 
          --Não é possível excluir o registro, existem códigos postais com essa cidade.
          vResult := -90 ;       
     
      elsif vResult > 0 then

         DELETE FROM APPP_TB_CIDADE C
         WHERE C.CD_CIDADE  = pCD_CIDADE;

         commit;
         
      end if;   
      
   else 
       
     /**************************************************************
      *  EXECUTA ESSA PARTE SE NÃO FOI INFORMADO O CÓDIGO DA CIDADE.
      *  ABRE UM CURSOR USANDO OS PARÂMETROS.
      *  JOGA TODOS OS CÓDIGOS DE CIDADE RETORNADOS PELO CURSOR EM 
         UM VETOR DE CÓDIGOS, QUE SERÁ USADO PARA VERIFICAR SE A(S) 
         CIDADE(s) PODE(m) SER EXCLUÍDA(S).
      **************************************************************/
       vResult := 1;
       i       := 1;
       vEXISTE := 0;
       
       OPEN C;
       LOOP 
          
          FETCH C INTO VETOR(i);
          EXIT WHEN C%NOTFOUND OR vEXISTE > 0;
          
          -- VERIFICA SE EXISTE ALGUM CÓDIGO POSTAL
          -- FOI CADASTRADO COM ESSA CIDADE.
          SELECT COUNT(*) INTO vEXISTE
          FROM APPP_TB_CODIGO_POSTAL CP
          WHERE CP.CD_CIDADE = VETOR(i);
          
          IF vEXISTE > 0 then
             --Não é possível excluir os registro, existem códigos postais com essa cidade.
             vResult := -90 ; 
          END IF;
          
          i := i + 1;
       END LOOP; 
       CLOSE C;  
        i := i - 1;
       if vResult > 0 then
             
          -- Ok. Então todas as cidades retornadas pelo cursor podem ser excluídas.
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
        vResult := 0; -- Não existe dado a ser deletado. 
        
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_DEL_CIDADE;
