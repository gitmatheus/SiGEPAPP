/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_AVALIA_QUEST : Função retorna valor númerico indicando se APPP deve ser bloqueado ou não.
*                      : Tipos de retorno:
*                      : 1 = Permanece, 2 = Não há quantidade mínima para avaliação, 3 = Bloqueio
* Author               : WeeDo
* History              : 28/04/2009 - Andrey Araujo Masiero
*		       : 25/05/2009 - Guilherme Lopes - Transformado em Procedure.
***************************************************************************************************/
CREATE OR REPLACE PROCEDURE APPP_PROC_AVALIA_QUEST
(pCD_OBJ in NUMBER, pCD_USER in NUMBER, pRetorno out NUMBER) IS
  Result LONG;
  pQTDE_AVALIACOES number := 0;
  pMEDIA number := 0;
BEGIN
  
  SELECT COUNT(*)
  INTO pQTDE_AVALIACOES
  FROM APPP_TB_QUEST_PREENCH
  WHERE CD_OBJETO = pCD_OBJ;
  
  IF pQTDE_AVALIACOES < 10 THEN
     Result := 2; -- Sem quantidade para avaliação
  ELSE
     SELECT AVG(VL_AVALIACAO)
     INTO pMEDIA
     FROM APPP_TB_QUEST_PREENCH
     WHERE CD_OBJETO = pCD_OBJ;
     
     IF pMEDIA < 5 THEN
        Result := 3; -- Bloqueia
        
        UPDATE APPP_TB_OBJETO 
        SET FL_ATIVO = 0 
        WHERE CD_OBJETO = pCD_OBJ;
        
     ELSE
        Result := 1; -- Permanece
     END IF;
  END IF;

  DELETE 
  FROM APPP_TB_AVAL_OBJ_USER 
  WHERE CD_OBJETO = pCD_OBJ  AND
        CD_USER   = pCD_USER;

  pRetorno:=Result;
END APPP_PROC_AVALIA_QUEST;
/