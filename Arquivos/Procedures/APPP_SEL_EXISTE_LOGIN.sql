/**********************************************************************************************************************
* Project Name          : SiGEPAPP
* APPP_SEL_EXISTE_LOGIN : Procedure para busca de login existente
*                         vResult( 1=OK; -99=ErroGeral)
* Author                : WeeDo 
* History               : 03/03/2009 - Andrey Masiero
***********************************************************************************************************************/
create or replace procedure APPP_SEL_EXISTE_LOGIN (pNmLogin in varchar2,
                                                   vResult  OUT number) is

begin

	select count(nm_login)
	into vResult
	from appp_tb_login L
	where L.NM_LOGIN = pNmLogin;

end APPP_SEL_EXISTE_LOGIN;