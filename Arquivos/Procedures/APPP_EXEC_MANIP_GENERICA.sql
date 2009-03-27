/**********************************************************************************************************************
* Project Name              : SiGEPAPP
* APPP_PES_PARAM_PROCEDURE  : Procedure para EXECUTAR PROCEDURES GENERICAS.
*                             TODOS OS PARAMETROS DE ENTRADA DEVEM SER PREENCHIDOS.
*                             vResult=( 1 = ok; 
*                                      -4 = TP_ACESSO COM CÓDIGO ERRADO;
*                                      -5 = todos os paramentros de entrada devem ser preenchidos;
*                                      -6 = número incompatível de parâmetros e valores dos vetores; 
*                                     ) 
* Author                    : WeeDo 
* History                   : 26/03/2009 - Matheus Goncalves
***********************************************************************************************************************/
create or replace procedure APPP_EXEC_MANIP_GENERICA(pNM_TABELA  IN VARCHAR2,
                                                     pTP_ACESSO  IN VARCHAR2, -- UPD, SEL, DEL, INS
                                                     pVT_VALORES IN APPP_PKG_VETORES.CHAR_VECTOR,
                                                     pVT_ORATYPE IN APPP_PKG_VETORES.CHAR_VECTOR,                                                       
                                                     vResult OUT NUMBER,   
                                                     p_cursor OUT SYS_REFCURSOR) is
  vERRO         VARCHAR2(600);
  vNM_PROCEDURE VARCHAR2(60) ;
  vNM_PARAMETRO VARCHAR2(60) ;
  vSQL          VARCHAR2(32000);
  vCONTA_PARAM     number(10) := 0;

  CURSOR C IS 
         SELECT AA.ARGUMENT_NAME PARAMETRO 
         FROM ALL_ARGUMENTS AA
         where aa.object_name = UPPER(vNM_PROCEDURE)
         ORDER BY AA.SEQUENCE;


begin     
       IF pNM_TABELA IS NULL OR pTP_ACESSO IS NULL OR pVT_VALORES.LAST <=0 OR pVT_ORATYPE.LAST <= 0 THEN
           vResult := -5;
       ELSIF TRIM(UPPER(pTP_ACESSO)) NOT IN ('UPD', 'SEL', 'DEL', 'INS') THEN
           vResult := -4;
       ELSE
           vResult := 1;  
           vNM_PROCEDURE := 'APPP_'||pTP_ACESSO|| SUBSTR(pNM_TABELA,8,LENGTH(pNM_TABELA));
           
           IF TRIM(UPPER(pTP_ACESSO)) = 'SEL' THEN
                 
                 vSQL :=  'begin '                    || chr(10);                                 
                 vSQL := vSQL || vNM_PROCEDURE || '(' ;
                 
                 open C;
                 LOOP
                    FETCH C INTO vNM_PARAMETRO;
                    EXIT WHEN C%NOTFOUND OR vResult = -6;

                    vCONTA_PARAM := vCONTA_PARAM + 1;
                    
                    IF (vCONTA_PARAM - 1) <= pVT_VALORES.LAST AND (vCONTA_PARAM - 1) <= pVT_ORATYPE.LAST THEN 
                       
                       --VERIFICA SE É O PARÂMETRO DE CURSOR
                       IF UPPER(vNM_PARAMETRO) = 'P_CURSOR' THEN
                          vSQL := chr(10) || vSQL || ':p_cursor,';
                       ELSE
                           IF UPPER(pVT_ORATYPE(vCONTA_PARAM)) = 'VARCHAR2' THEN
                              vSQL := vSQL || chr(10) || '''' ||pVT_VALORES(vCONTA_PARAM)||''''||','; 
                           ELSIF UPPER(pVT_ORATYPE(vCONTA_PARAM)) = 'DATE' THEN
                              vSQL := vSQL || chr(10) ||' TO_DATE('||''''|| pVT_VALORES(vCONTA_PARAM)||''''||','||''''||'DD/MM/RRRR'||''''||'),';
                           ELSIF UPPER(pVT_ORATYPE(vCONTA_PARAM)) = 'NUMBER' THEN
                              vSQL := vSQL || chr(10) ||pVT_VALORES(vCONTA_PARAM)||',';
                           ELSE
                              vSQL := vSQL || chr(10) ||' NULL ,';
                           END IF;
                       END IF;       
                    ELSE
                       vResult := -6;
                    END IF;   
                   
                 END LOOP;
                 CLOSE C;
                 
                 vSQL := SUBSTR(vSQL,0,LENGTH(vSQL) - 1); -- TIRA A ULTIMA VIRGULA
                 vSQL := vSQL || ');' || chr(10);
                 vSQL := vSQL || 'end;';
                 
                 IF (vResult > -6) THEN
                 
                     EXECUTE IMMEDIATE vSQL  
                     USING   p_cursor;  
                           
                 END IF;      
           END IF;
       END IF;    
       
    EXCEPTION
     WHEN OTHERS THEN
        rollback;
        vResult := SQLCODE; -- Erro generico.
        vERRO   := SUBSTR(SQLERRM,600);      

END APPP_EXEC_MANIP_GENERICA;       
       
