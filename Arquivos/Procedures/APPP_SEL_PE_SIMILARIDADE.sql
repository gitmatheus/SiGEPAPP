/**************************************************************************************************
* Project Name         : SiGEPAPP
* PERSONA SIMILARIDADE : Reponsável por criar um cursor com a similaridade e todos os atributos rele- 
					   : vantes para exibir os dados ao usuário.
* Author               : WeeDo
* History              : 23/05/2009 - Guilherme Wachs Lopes
***************************************************************************************************/
  CREATE OR REPLACE PROCEDURE "SYSTEM"."APPP_SEL_PE_SIMILARIDADE" (p_cursor out SYS_REFCURSOR,
                                                 nome_procurado VARCHAR2,
                                                 descricao_procurado VARCHAR2,
                                                 peso_nome VARCHAR2,
                                                 peso_descricao VARCHAR2) AS
BEGIN
  open p_cursor for
  select appp_pkg_similaridade.similaridade(nm_objeto, nome_procurado)* peso_nome+ 
         appp_pkg_similaridade.similaridade(ds_objeto, descricao_procurado) * peso_descricao sim,
         cd_objeto, 
         nm_objeto,
         ds_objeto
        from appp_tb_objeto
        where cd_estrutura in(select cd_estrutura from appp_tb_estrut_obj where tp_estrutura='PE')
        order by sim desc;
  
END APPP_SEL_PE_SIMILARIDADE;
/
 