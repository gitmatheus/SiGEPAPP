/**************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_FN_REMOVE_ACENTO : Function que remove acentos
* Author                : WeeDo 
* History               : 09/03/2009 - Matheus Gon�alves
***************************************************************************************************/
create or replace function APPP_FN_REMOVE_ACENTO
(pString in varchar2) return varchar2 is
-- 
vStringReturn varchar2(2000);
-- 
begin
  vStringReturn := translate( pString,
                    '����������������������������������������',
                    'ACEIOUAEIOUAEIOUAOEUaceiouaeiouaeiouaoeu');
  --
  return vStringReturn;
  --
end APPP_FN_REMOVE_ACENTO; 

/