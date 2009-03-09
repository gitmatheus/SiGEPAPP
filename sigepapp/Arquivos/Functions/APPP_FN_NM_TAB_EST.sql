/**************************************************************************************************
* Project Name       : SiGEPAPP
* APPP_FN_NM_TAB_EST : Function que gera o nome das tabelas de estruturas evitando homônimos
* Author             : WeeDo 
* History            : 09/03/2009 - Matheus Gonçalves
***************************************************************************************************/
create or replace function APPP_FN_NM_TAB_EST(NM_ESTRUTURA IN VARCHAR2)
   return varchar2 is

   Result VARCHAR2(30);

   i         number(5) := 1;
   vTEMP     NUMBER(5) := 1;
   vCHARTEMP VARCHAR2(2000);

begin

   RESULT    := 'APPP_TB_' ||
                UPPER(TRIM(SUBSTR(TRANSLATE(NM_ESTRUTURA, ' -', '__'), 0, 18)));
   vCHARTEMP := RESULT;

   Loop
   
      SELECT COUNT(*)
        INTO vTEMP
        FROM APPP_TB_ESTRUT_OBJ EO
       WHERE TRIM(UPPER(EO.NM_TB_ESTRUT)) = vCHARTEMP;
   
      EXIT WHEN vTEMP = 0;
   
      IF vTEMP > 0 THEN
      
         IF i < 10 THEN
            vCHARTEMP := RESULT || '0' || i;
         eLSE
            vCHARTEMP := RESULT || i;
         END IF;
      END IF;
      i := i + 1;
   
   end loop;

   RESULT := vCHARTEMP;

   return(Result);

end APPP_FN_NM_TAB_EST;
