package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)QuestPreenchDAO.java 0.01 06/04/09
 *
 * Este código é parte integrante do projeto de formatura,
 * do curso de ciências da computação, do Centro Universitário da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * | Tom Mix     | 06/04/09    | Criacao                              |
 * |------------------------------------------------------------------|
 *
 */

//~-- JDK import --------------------------------------------------------------
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.QuestPreench;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Date;
import oracle.jdbc.OracleTypes;

/**
 *
 * Classe responsavel por acessar o banco de dados através do modelo pergunta
 *
 * @author Tom Mix
 * @version 0.01 06 Abr 2009
 */
public class QuestPreenchDAO {

    private Connection conn;

    public QuestPreenchDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public long APPP_INS_QUEST_PREENCH(QuestPreench questPreench) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_QUEST_PREENCH(?, ?, ?, ?, ?, ?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setLong(1, questPreench.getCd_quest_preench());
            
            cstmt.setLong(2, questPreench.getVl_avaliacao());
            cstmt.setString(3, questPreench.getDs_proj_aplic());
            cstmt.setLong(4, questPreench.getCd_user());
            cstmt.setLong(5, questPreench.getCd_objeto());

            cstmt.setNull(6, OracleTypes.NUMBER);
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();

            long cResult = cstmt.getLong(6);

            //Grava log com a informação de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(QuestPreenchDAO.class.getName() + ": inserção no banco de dados do questionario preenchido realizado com sucesso");
                cstmt.close();
                return 1;
            } else if (cResult < 1) {
                GravarLog.gravaInformacao(QuestPreenchDAO.class.getName() + ": " + cResult + ": erro ao cadastrar questionario preenchido no banco de dados");
                cstmt.close();
                return 2;
            }
            return cResult;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(QuestPreenchDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return 2;
        }
    }

    public boolean APPP_DEL_QUEST_PREENCH(QuestPreench questPreench) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_QUEST_PREENCH(?, ?, ?, ?, ?, ?, ?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setLong(1, questPreench.getCd_quest_preench());
            cstmt.setDate(2, questPreench.getDt_aplicacao());
            cstmt.setLong(3, questPreench.getVl_avaliacao());
            cstmt.setString(4, questPreench.getDs_proj_aplic());
            cstmt.setLong(5, questPreench.getCd_user());
            cstmt.setLong(6, questPreench.getCd_objeto());

            cstmt.setNull(7, OracleTypes.NUMBER);
            cstmt.registerOutParameter(7, OracleTypes.NUMBER);

            cstmt.execute();

            long cResult = cstmt.getLong(7);

            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    public List<QuestPreench> APPP_SEL_QUEST_PREENCH(QuestPreench pesquisarQuestPreench) {

        CallableStatement cstmt = null;
        ResultSet rs = null;
        List<QuestPreench> listaQuestPreench = new ArrayList<QuestPreench>();


        long cd_quest_preench = pesquisarQuestPreench.getCd_objeto();
        Date dt_aplicacao = pesquisarQuestPreench.getDt_aplicacao();
        long vl_avaliacao = pesquisarQuestPreench.getVl_avaliacao();
        String ds_proj_aplic = pesquisarQuestPreench.getDs_proj_aplic();
        long cd_user = pesquisarQuestPreench.getCd_user();
        long cd_objeto = pesquisarQuestPreench.getCd_objeto();

        try {
            cstmt = conn.prepareCall("begin APPP_SEL_QUEST_PREENCH(?, ?, ?, ?, ?, ?, ?); end;");

            if (cd_quest_preench == 0) {
                cstmt.setNull(1, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(1, cd_quest_preench);
            }

            if (dt_aplicacao == null) {
                cstmt.setNull(2, OracleTypes.DATE);
            } else {
                cstmt.setDate(2, dt_aplicacao);
            }

            if (vl_avaliacao == 0) {
                cstmt.setNull(3, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(3, vl_avaliacao);
            }

            if (ds_proj_aplic == null) {
                cstmt.setNull(4, OracleTypes.VARCHAR);
            } else {
                cstmt.setString(4, ds_proj_aplic);
            }

            if (cd_user == 0) {
                cstmt.setNull(5, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(5, cd_user);
            }

            if (cd_objeto == 0) {
                cstmt.setNull(6, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(6, cd_objeto);
            }

            cstmt.registerOutParameter(7, OracleTypes.CURSOR);
            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(7);

            while (rs.next()) {
                listaQuestPreench.add(new QuestPreench(rs.getLong(1), rs.getDate(2), rs.getLong(3), rs.getString(4), rs.getLong(5), rs.getLong(6)));
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(QuestPreench.class.getName() + ": pesquisa de questionario preenchido realizada com sucesso");

        } catch (SQLException ex) {
            GravarLog.gravaErro(QuestPreench.class.getName() + ": Erro na pesquisa de questionario preenchido referente à uma exceção SQL: " + ex.getMessage());
        }
        return listaQuestPreench;
    }

    /**
     * Metodo para fechar o banco de dados da classe
     */
    public void fechaConexao() {
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }


        } catch (SQLException e) {
            GravarLog.gravaErro(QuestPreenchDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}



