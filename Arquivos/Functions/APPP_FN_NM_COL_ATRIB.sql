/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_NM_COL_ATRIB : Function que gera o nome da coluna de determinado atributo.
* Author               : WeeDo 
* History              : 09/03/2009 - Matheus Gonçalves
***************************************************************************************************/
create or replace function APPP_FN_NM_COL_ATRIB(pNM_ATRIBUTO IN VARCHAR2)
   return varchar2 is

   vResult VARCHAR2(30);

   i         number(5) := 1;
   vTEMP     NUMBER(5) := 1;
   vCHARTEMP VARCHAR2(2000);
   
   vTP_TEMP  VARCHAR2(60) := UPPER(pNM_ATRIBUTO);

begin
    
   vRESULT := upper(pNM_ATRIBUTO);
   
   IF INSTR(vTP_TEMP,'DATA ') > 0 THEN
      vRESULT := SUBSTR( vRESULT,0,INSTR(vRESULT,'DATA') -1 ) || SUBSTR( vRESULT,INSTR(vRESULT,'DATA') + 5,LENGTH( vRESULT)) ;
      vTP_TEMP := 'DT_';
   ELSIF INSTR(vTP_TEMP,'NÚMERO') > 0 THEN
      vRESULT := SUBSTR( vRESULT,0,INSTR(vRESULT,'NÚMERO') -1 ) || SUBSTR( vRESULT,INSTR(vRESULT,'NÚMERO') + 7,LENGTH( vRESULT)) ;
      vTP_TEMP := 'NR_';   
   ELSIF INSTR(vTP_TEMP,'NOME') > 0 THEN
      vRESULT := SUBSTR( vRESULT,0,INSTR(vRESULT,'NOME') -1 ) || SUBSTR( vRESULT,INSTR(vRESULT,'NOME') + 5,LENGTH( vRESULT)) ;
      vTP_TEMP := 'NM_'; 
   ELSIF INSTR(vTP_TEMP,'TIPO') > 0 THEN
      vRESULT := SUBSTR( vRESULT,0,INSTR(vRESULT,'TIPO') -1 ) || SUBSTR( vRESULT,INSTR(vRESULT,'TIPO') + 5,LENGTH( vRESULT)) ;
      vTP_TEMP := 'TP_';  
   ELSIF INSTR(vTP_TEMP,'SIGLA') > 0 THEN
      vRESULT := SUBSTR( vRESULT,0,INSTR(vRESULT,'SIGLA') -1 ) || SUBSTR( vRESULT,INSTR(vRESULT,'SIGLA') + 6,LENGTH( vRESULT)) ;
      vTP_TEMP := 'SG_';   
   ELSE
       vTP_TEMP := 'DS_';   
   END IF;     

   vRESULT    := REPLACE(vRESULT,'-','');  
   vRESULT    := REPLACE(vRESULT,'_','');
   vRESULT    := APPP_FN_REMOVE_ACENTO(vRESULT); 
   vRESULT    := UPPER(vRESULT);
   vRESULT    := TRIM(vRESULT);
   vRESULT    := SUBSTR(vRESULT, 0, 10);
   vRESULT    := REPLACE(vRESULT,' ','');
   
   vCHARTEMP := vTP_TEMP || vRESULT;
   
   Loop
   
      SELECT COUNT(*)
        INTO vTEMP
        FROM APPP_TB_ATRIBUTO_OBJ AO
       WHERE TRIM(UPPER(AO.NM_COLUNA)) = vCHARTEMP;
   
      EXIT WHEN vTEMP = 0;
   
      IF vTEMP > 0 THEN
      
         IF i < 10 THEN
            vCHARTEMP := vRESULT || '0' || i;
         eLSE
            vCHARTEMP := vRESULT || i;
         END IF;
      END IF;
      i := i + 1;
   
   end loop;

   vRESULT := vCHARTEMP;

   return(vRESULT);

end APPP_FN_NM_COL_ATRIB;
