/**********************************************************************************************************************
* Project Name             : SiGEPAPP
* APPP_INS_RELAC_QUEST_OBJ : Procedure para criação de dados de RELAC_QUEST_OBJ
*                           vResult( 1=OK; -99=ErroGeral)
* Author                   : WeeDo 
* History                  : 24/03/2009 - Matheus Gonçalves
***********************************************************************************************************************/
create or replace procedure APPP_INS_RELAC_QUEST_OBJ(pCD_QUEST_PREENCH  in out number,
                                                     pCD_QUEST          in number,
                                                     pCD_OBJETO         in number,         
                                                     pCD_USER           in NUMBER,
                                                     vResult        out number) is
vERRO        VARCHAR2(600);
begin
   
   insert into APPP_TB_RELAC_QUEST_OBJ( CD_QUEST_PREENCH  ,
                                        CD_QUEST          ,
                                        CD_OBJETO         ,         
                                        CD_USER
                                    )
                             values( pCD_QUEST_PREENCH  ,
                                     pCD_QUEST          ,
                                     pCD_OBJETO         ,         
                                     pCD_USER        
                                    );
                                    
   select APPP_SEQ_RELAC_QUEST_OBJ.CURRVAL
   into pCD_QUEST_PREENCH
   from dual;  
   
   vResult := 1;
   commit;
   
   EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);
               
end APPP_INS_RELAC_QUEST_OBJ;
/
