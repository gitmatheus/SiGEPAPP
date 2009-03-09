/**********************************************************************************************************************
* Project Name  : SiGEPAPP
* APPP_INS_USER : Procedure para cria��o de dados de usu�rio
*                 vResult( 1=OK; -99=ErroGeral)
*                 pCDUser deve ser sempre o CPF do usu�rio
* Author        : WeeDo 
* History       : 28/02/2009 - Matheus Gon�alves
***********************************************************************************************************************/
create or replace procedure APPP_INS_USER(pCDUser        in number  ,
                                          pPrimNome      in varchar2,
                                          pUltNome       in varchar2,
                                          pDtNasc        in date  ,
                                          pNrNota        in number,
                                          pDtCadastro    in date  ,
                                          pDSInteresse   in varchar2  ,
                                          pMSN           in varchar2  ,
                                          pSkype         in varchar2  ,
                                          vResult        OUT number) is
begin
    
  insert into appp_tb_user ( cd_user           , 
                             nm_prim_nome      ,
                             nm_ult_nome       , 
                             dt_nasc           , 
                             nr_nota           , 
                             dt_cadastro       , 
                             ds_area_interesse , 
                             nm_msn            , 
                             nm_skype
                            ) 
                    values ( pCDUser           ,
                             pPrimNome         ,
                             pUltNome          ,
                             pDtNasc           ,
                             pNrNota           ,
                             pDtCadastro       ,
                             pDSInteresse      ,
                             pMSN              ,
                             pSkype
                           );          
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.    
       
               
end APPP_INS_USER;
