package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)RelacPergRespDAO.java 0.01 19/04/09
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
 * | Tom Mix     | 19/04/09    | Criacao                              |
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
import br.edu.fei.sigepapp.bancodedados.model.Relac_Perg_Resp;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import oracle.jdbc.OracleTypes;

/**
 *
 * Classe responsavel por acessar o banco de dados através do modelo pergunta
 *
 * @author Tom Mix
 * @version 0.01 19 Abr 2009
 */
public class RelacPergRespDAO {

    private Connection conn;

    public RelacPergRespDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public long APPP_INS_RELAC_PERG_RESP(Relac_Perg_Resp relac_perg_resp) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_RELAC_PERG_RESP(?, ?, ?, ?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setLong(1, relac_perg_resp.getCd_pergunta());
            cstmt.setLong(2, relac_perg_resp.getCd_resposta());
            cstmt.setLong(3, relac_perg_resp.getNro_valor_resp());

            cstmt.setNull(4, OracleTypes.NUMBER);
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();

            long cResult = cstmt.getLong(4);

            //Grava log com a informação de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(RelacPergRespDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            } else if (cResult < 1) {
                GravarLog.gravaInformacao(RelacPergRespDAO.class.getName() + ": " + cResult + ": erro ao cadastrar relac de perguntas e perguntas no banco de dados");
                cstmt.close();
                return 2;
            }
            return cResult;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(RelacPergRespDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return 2;
        }
    }

    public boolean APPP_DEL_PERGUNTA(Relac_Perg_Resp relac_perg_resp) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_RELAC_PERG_RESP(?, ?, ?, ?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setLong(1, relac_perg_resp.getCd_pergunta());
            cstmt.setLong(2, relac_perg_resp.getCd_resposta());
            cstmt.setLong(3, relac_perg_resp.getNro_valor_resp());

            cstmt.setNull(4, OracleTypes.NUMBER);
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();

            long cResult = (int) cstmt.getLong(13);

            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    public List<Relac_Perg_Resp> APPP_SEL_RELAC_PERG_RESP(Relac_Perg_Resp pesquisarRelacPergResp) {

        CallableStatement cstmt = null;
        ResultSet rs = null;
        List<Relac_Perg_Resp> listaRelacPergResp = new ArrayList<Relac_Perg_Resp>();

        long cd_pergunta = pesquisarRelacPergResp.getCd_pergunta();
        long cd_resposta = pesquisarRelacPergResp.getCd_resposta();
        long nro_valor_resp = pesquisarRelacPergResp.getNro_valor_resp();

        try {
            cstmt = conn.prepareCall("begin APPP_SEL_RELAC_PERG_RESP(?,?,?, ?); end;");

            if (cd_pergunta == 0) {
                cstmt.setNull(1, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(1, cd_pergunta);
            }

            if (cd_resposta == 0) {
                cstmt.setNull(2, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(2, cd_resposta);
            }

            if (nro_valor_resp == 0) {
                cstmt.setNull(3, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(3, nro_valor_resp);
            }

            cstmt.registerOutParameter(4, OracleTypes.CURSOR);
            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(3);

            while (rs.next()) {
                listaRelacPergResp.add(new Relac_Perg_Resp(rs.getLong(1), rs.getLong(2), rs.getLong(3)));
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(Relac_Perg_Resp.class.getName() + ": pesquisa de relac de pergunta e resposta realizada com sucesso");

        } catch (SQLException ex) {
            GravarLog.gravaErro(Relac_Perg_Resp.class.getName() + ": Erro na pesquisa de relac de pergunta e resposta referente à uma exceção SQL: " + ex.getMessage());
        }

        return listaRelacPergResp;
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
            GravarLog.gravaErro(RelacPergRespDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}



