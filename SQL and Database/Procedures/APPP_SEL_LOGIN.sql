/**********************************************************************************************************************
* Project Name   : SiGEPAPP
* APPP_SEL_LOGIN : Functiom para criação de dados de login
*                  p_cursor retorna o cursor com o select.
* Author         : WeeDo 
* History        : 28/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_LOGIN(pNm_login in varchar2,
                                           pPw_Senha in varchar2,
                                           p_cursor OUT SYS_REFCURSOR) is
begin
  
  open p_cursor FOR
  select U.CD_USER,
         U.NM_PRIM_NOME,
         U.NM_ULT_NOME,
         U.DT_NASC,
         U.NR_NOTA,
         U.DT_CADASTRO,
         U.DS_AREA_INTERESSE,
         U.NM_MSN,
         U.NM_SKYPE,
         L.NM_LOGIN       
  from appp_tb_user  U,
       appp_tb_login L
  where L.NM_LOGIN = pNm_login
  and   L.PW_SENHA = pPw_Senha
  and   U.CD_USER = L.CD_USER;     
   
               
end APPP_SEL_LOGIN;
/