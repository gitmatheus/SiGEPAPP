/**************************************************************************************
* Project Name        : SiGEPAPP
* APPP_INS_ESTRUT_OBJ : Procedure para cria��o de dados de ESTRUT_OBJS
*                       vResult( 1=OK; -99=ErroGeral)
* Author              : WeeDo 
* History             : 04/03/2009 - Matheus Gon�alves
*                     : 09/03/2009 - Matheus Gon�alves - Remo��o Par�metro pDT_CRIACAO 
***************************************************************************************/
create or replace procedure APPP_INS_ESTRUT_OBJ(pCD_ESTRUTURA OUT NUMBER,
                                                pNM_ESTRUTURA IN VARCHAR2,
                                                pDS_ESTRUTURA IN VARCHAR2,
                                                pCD_USER      IN NUMBER  ,
                                                pTP_ESTRUTURA IN VARCHAR2,
                                                vResult    out number) is
begin
   
   insert into APPP_TB_ESTRUT_OBJ( CD_ESTRUTURA ,
                                   NM_ESTRUTURA , 
                                   DS_ESTRUTURA ,
                                   DT_CRIACAO   ,
                                   CD_USER      ,
                                   TP_ESTRUTURA 
                                  )
                           values( pCD_ESTRUTURA ,
                                   pNM_ESTRUTURA ,
                                   pDS_ESTRUTURA ,
                                   sysdate       ,
                                   pCD_USER      ,
                                   pTP_ESTRUTURA  
                                  );
                             
   select APPP_SEQ_ESTRUT_OBJ.CURRVAL
   into pCD_ESTRUTURA
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := -99; -- Erro gen�rico.
               
end APPP_INS_ESTRUT_OBJ;
