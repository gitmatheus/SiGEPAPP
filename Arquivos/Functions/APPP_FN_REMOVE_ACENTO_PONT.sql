/**************************************************************************************************
* Project Name               : SiGEPAPP
* APPP_FN_REMOVE_ACENTO_PONT : Function que remove acentos e pontuacao
* Author                     : WeeDo 
* History                    : 30/03/2009 - Matheus Goncalves
***************************************************************************************************/
create or replace function APPP_FN_REMOVE_ACENTO_PONT
(pString in varchar2) return varchar2 is
-- 
vStringReturn varchar2(2000);
-- 
begin
  vStringReturn := translate( ltrim(rtrim(pString)),
                    'ÁÇÉÍÓÚÀÈÌÒÙÂÊÎÔÛÃÕËÜáçéíóúàèìòùâêîôûãõëü´`.,;:+-*<>{}[]ªº_!?/\|@#¨()^~¬¢¹²³£§',
                    'ACEIOUAEIOUAEIOUAOEUaceiouaeiouaeiouaoeu                                123  ');
  --
  
  -- Remove os espacos duplos:
  while instr(vStringReturn,'  ') > 1 loop
        vStringReturn := replace( vStringReturn,'  ',' ');
  end loop;
  
  return vStringReturn;
  --
end APPP_FN_REMOVE_ACENTO_PONT; 

/
