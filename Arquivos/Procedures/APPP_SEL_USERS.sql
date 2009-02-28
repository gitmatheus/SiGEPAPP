/**********************************************************************************************************************
* Project Name   : SiGEPAPP
* APPP_SEL_USERS : Functiom para criação de dados de usuários
*                  p_cursor retorna o cursor com o select.
* Author         : WeeDo 
* History        : 28/02/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_SEL_USERS(pCDUser        in number  ,
                                           pPrimNome      in varchar2,
                                           pUltNome       in varchar2,
                                           pDtNascIni     in date    , 
                                           pDtNascFim     in date    ,
                                           pNrNotaIni     in number  , 
                                           pNrNotaFim     in number  ,
                                           pDtCadastroIni in date    , 
                                           pDtCadastroFim in date    ,
                                           pDSInteresse   in varchar2  ,
                                           pMSN           in varchar2  ,
                                           pSkype         in varchar2  ,
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
  from   appp_tb_user  U,
         appp_tb_login L
  where  U.CD_USER = L.CD_USER
  AND   (U.CD_USER = pCDUser or pCDUser is null)
  AND   (U.NM_PRIM_NOME LIKE '%'||pPrimNome||'%' OR pPrimNome      IS NULL)
  AND   (U.NM_ULT_NOME  LIKE '%'||pUltNome ||'%' OR pUltNome       IS NULL)
  AND   (U.DT_NASC     >= pDtNascIni             OR pDtNascIni     IS NULL)
  AND   (U.DT_NASC     <= pDtNascFim             OR pDtNascFim     IS NULL)
  AND   (U.NR_NOTA     >= pNrNotaIni             OR pNrNotaIni     IS NULL)
  AND   (U.NR_NOTA     <= pNrNotaFim             OR pNrNotaFim     IS NULL)
  AND   (U.DT_CADASTRO >= pDtCadastroIni         OR pDtCadastroIni IS NULL)
  AND   (U.DT_CADASTRO <= pDtCadastroFim         OR pDtCadastroFim IS NULL)
  AND   (U.NM_MSN   = pMSN                       OR pMSN           IS NULL)
  AND   (U.NM_SKYPE = pSkype                     OR pSkype         IS NULL)
  ORDER BY U.NM_PRIM_NOME;
               
end APPP_SEL_USERS;
