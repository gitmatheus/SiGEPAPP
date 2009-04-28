/**************************************************************************************************
* Project Name         : SiGEPAPP
* APPP_FN_AVALIA_QUEST : Função retorna valor númerico indicando se APPP deve ser bloqueado ou não.
*                      : Tipos de retorno:
*                      : 1 = Permanece, 2 = Não há quantidade mínima para avaliação, 3 = Bloqueio
* Author               : WeeDo
* History              : 28/04/2009 - Andrey Araujo Masiero
***************************************************************************************************/
CREATE OR REPLACE FUNCTION APPP_FN_AVALIA_QUEST
(pCD_OBJ in NUMBER) RETURN LONG IS
  Result LONG;
  pQTDE_AVALIACOES number := 0;
  pMEDIA number := 0;
BEGIN
  
  SELECT COUNT(*)
  INTO pQTDE_AVALIACOES
  FROM APPP_TB_RELAC_QUEST_OBJ
  WHERE CD_OBJETO = pCD_OBJ
  
  IF pQTDE_AVALIACOES < 10
     Result := 2; -- Sem quantidade para avaliação
  ELSIF
     SELECT AVG(VL_AVALIACAO)
     INTO pMEDIA
     FROM APPP_TB_QUEST_PREENCH
     WHERE CD_QUEST_PREENCH IN (SELECT CD_QUEST_PREENCH
                                FROM APPP_TB_RELAC_QUEST_OBJ
                                WHERE CD_OBJETO = pCD_OBJ)
     IF pMEDIA < 5
        Result := 3; -- Bloqueia
     ELSE
        Result := 1; -- Permanece
     END IF;
  END IF;

  RETURN(Result);
END APPP_FN_AVALIA_QUEST;
/
