/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_SPLIT	       : Function divide o texto de acordo com o delimitador e retorna um vetor
* Author               : WeeDo 
* History              : 29/03/2009 - Guilherme Wachs Lopes
***************************************************************************************************/
create or replace function APPP_FN_SPLIT( pString IN VARCHAR2
                                        , pChar IN VARCHAR2)
                                         RETURN appp_pkg_vetores.CHAR_VECTOR
IS
	
	arr_str appp_pkg_vetores.CHAR_VECTOR ;
	indx PLS_INTEGER := 0;
	vstring VARCHAR2(2000) :=
	pstring;
  
BEGIN

    WHILE INSTR(vstring,pchar,1) > 0 LOOP
      indx := indx + 1;
      arr_str(indx) :=
      SUBSTR(vstring,1,instr(vstring,pchar,1) - 1);
      vstring :=
      SUBSTR(vstring,instr(vstring,pchar,1)+1);
    END LOOP;

    IF vstring IS NOT NULL THEN
      indx := indx + 1;
      arr_str(indx) := vstring;
    END IF;

    RETURN arr_str;

    EXCEPTION
       WHEN OTHERS THEN
          RETURN arr_str;
          
END APPP_FN_SPLIT;
