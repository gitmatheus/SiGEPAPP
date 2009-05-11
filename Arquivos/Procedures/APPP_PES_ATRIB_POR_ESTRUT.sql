create or replace procedure APPP_PES_ATRIB_POR_ESTRUT(pCD_ESTRUTURA    IN NUMBER,
                                                      p_cursor    OUT SYS_REFCURSOR   ) is
begin

       open p_cursor FOR
       select EO.CD_ESTRUTURA,
              AE.CD_ATRIBUTO_OBJ,
              AO.NM_ATRIBUTO_OBJ,
              AO.DS_ATRIBUTO_OBJ,
              AO.CD_TIPO,
              T.NM_TIPO,
              DECODE(T.FL_EXP_REG,'S','VARCHAR2',
                                  'N',upper(T.DS_TIPO)) T_TYPE,
              T.FL_EXP_REG,
              DECODE(T.FL_EXP_REG,'S',T.DS_TIPO,
                                  'N',null) EXP_REG,
              AO.NM_COLUNA
       from appp_tb_estrut_obj EO,
            appp_tb_atrib_estrutura AE,
            appp_tb_atributo_obj AO,
            APPP_TB_TIPO T
       where EO.cd_estrutura    = pCD_ESTRUTURA
       AND   AE.CD_ESTRUTURA    = EO.CD_ESTRUTURA
       AND   AO.CD_ATRIBUTO_OBJ = AE.CD_ATRIBUTO_OBJ
       AND   T.CD_TIPO          = AO.CD_TIPO
       ORDER BY AE.ROWID;

end APPP_PES_ATRIB_POR_ESTRUT;
/
