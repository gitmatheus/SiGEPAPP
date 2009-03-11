/****************************************************************************************
* Project Name        : SiGEPAPP
* APPP_UPD_ESTRUT_OBJ : Procedure para ATUALIZAÇÃO de dados de ESTRUT_OBJS
*                      vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gonçalves
*                     : 09/03/2009 - Matheus Gonçalves - Criação do atributo NM_TB_ESTRUT
******************************************************************************************/
create or replace procedure APPP_UPD_ESTRUT_OBJ(pCD_ESTRUTURA IN NUMBER,
                                                pNM_ESTRUTURA IN VARCHAR2,
                                                pDS_ESTRUTURA IN VARCHAR2,
                                                pDT_CRIACAO   IN DATE    ,
                                                pCD_USER      IN NUMBER  ,
                                                pTP_ESTRUTURA IN VARCHAR2,
                                                pNM_TB_ESTRUT IN VARCHAR2,
                                                vResult     out number) is
begin
    
   IF pNM_ESTRUTURA IS NOT NULL THEN
      UPDATE APPP_TB_ESTRUT_OBJ 
      SET NM_ESTRUTURA = pNM_ESTRUTURA
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA;
   END IF;  

   IF pDS_ESTRUTURA IS NOT NULL THEN
      UPDATE APPP_TB_ESTRUT_OBJ 
      SET DS_ESTRUTURA = pDS_ESTRUTURA
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA;
   END IF;    
   
   IF pDT_CRIACAO IS NOT NULL THEN
      UPDATE APPP_TB_ESTRUT_OBJ 
      SET DT_CRIACAO = pDT_CRIACAO
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA;
   END IF;   

   IF pCD_USER IS NOT NULL THEN
      UPDATE APPP_TB_ESTRUT_OBJ 
      SET CD_USER = pCD_USER
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA;
   END IF;   

   IF pTP_ESTRUTURA IS NOT NULL THEN
      UPDATE APPP_TB_ESTRUT_OBJ 
      SET TP_ESTRUTURA = pTP_ESTRUTURA
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA;
   END IF;
 
   IF pNM_TB_ESTRUT IS NOT NULL THEN
      UPDATE APPP_TB_ESTRUT_OBJ 
      SET NM_TB_ESTRUT = pNM_TB_ESTRUT
      WHERE CD_ESTRUTURA = pCD_ESTRUTURA;
   END IF;
 
   
   
   vResult := 1; -- OK
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro genérico.
               
end APPP_UPD_ESTRUT_OBJ;
/