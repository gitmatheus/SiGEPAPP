package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)respostaDAO.java 0.01 18/04/09
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
 * | Tom Mix     | 18/04/09    | Criacao                              |
 * |------------------------------------------------------------------|
 * | Tom Mix     | 21/04/09    | Criacao do metodo upadate            |
 * |------------------------------------------------------------------|
 *
 *
 */

//~-- JDK import --------------------------------------------------------------
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleTypes;
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Resposta;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * Classe responsavel por acessar o banco de dados através do modelo resposta
 *
 * @author Tom Mix
 * @version 0.01 31 Mar 2009
 */
public class RespostaDAO {

    private Connection conn;

    /**
     * Contrutor da classe:- cria uma conexão com o banco de dados
     *
     * @throws SQLException
     */
    public RespostaDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    /**
     * Metodo de inserção de pergunta no banco de dados
     * @param pergunta
     * @return 1 = Cadastrado / 2 = Existente no BD / 3 = Erro
     */
    public long APPP_INS_RESPOSTA(Resposta resposta) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_RESPOSTA(?, ?, ?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setNull(1, OracleTypes.NUMBER);
            cstmt.registerOutParameter(1, OracleTypes.NUMBER);

            cstmt.setString(2, resposta.getDs_resposta());

            cstmt.setNull(3, OracleTypes.NUMBER);
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            long cResult = cstmt.getLong(3);

            //Grava log com a informação de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(RespostaDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            } else if (cResult < 1) {
                GravarLog.gravaInformacao(RespostaDAO.class.getName() + ": " + cResult + ": erro ao cadastrar nova resposta.");
                cstmt.close();
                return 2;
            }
            return cResult;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(RespostaDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return 2;
        }
    }

    public boolean APPP_UPD_PERGUNTA(Resposta resposta) {
        CallableStatement cstmt = null;
        long resultado = 0;

        try {
            cstmt = conn.prepareCall("begin APPP_UPD_RESPOSTA(?, ?, ?); end;");

            //Seta o codigo do atributo NULL (A chave sera gerada automaticamente pela procedure do banco)
            cstmt.setLong(1, resposta.getCd_resposta());
            cstmt.setString(2, resposta.getDs_resposta());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            resultado = cstmt.getLong(3);

            cstmt.close();

            if (resultado == 1) {
                GravarLog.gravaInformacao(Resposta.class.getName() + ": atualizacao no banco de dados realizada com sucesso");
                return true;
            } else {
                GravarLog.gravaErro(Resposta.class.getName() + ": erro na adicao no banco de dados: Erro generico.");
                return false;
            }
        } catch (SQLException ex) {
            GravarLog.gravaErro(Resposta.class.getName() + ": erro na adicao no banco de dados: " + ex.getSQLState());
            return false;
        }
    }

    public boolean APPP_DEL_RESPOSTA(Resposta resposta) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_RESPOSTA(?,?,?); end;");

            cstmt.setLong(1, resposta.getCd_resposta());
            cstmt.setString(2, resposta.getDs_resposta());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(13);

            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    public List<Resposta> APPP_SEL_RESPOSTA(Resposta respPesquisar) {

        CallableStatement cstmt = null;
        ResultSet rs = null;
        List<Resposta> listaRespostas = new ArrayList<Resposta>();

        long cd_resposta = respPesquisar.getCd_resposta();
        String ds_resposta = respPesquisar.getDs_resposta();

        try {
            cstmt = conn.prepareCall("begin APPP_SEL_RESPOSTA(?,?,?); end;");

            if (cd_resposta == 0) {
                cstmt.setNull(1, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(1, cd_resposta);
            }

            if (ds_resposta == null) {
                cstmt.setNull(2, OracleTypes.VARCHAR);
            } else {
                cstmt.setString(2, ds_resposta);
            }

            cstmt.registerOutParameter(3, OracleTypes.CURSOR);

            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(3);

            while (rs.next()) {
                listaRespostas.add(new Resposta(rs.getLong(1), rs.getString(2)));
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(Resposta.class.getName() + ": pesquisa de uma resposta realizada com sucesso");

        } catch (SQLException ex) {
            GravarLog.gravaErro(Resposta.class.getName() + ": Erro na pesquisa de uma resposta referente à uma exceção SQL: " + ex.getMessage());
        }

        return listaRespostas;
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
            GravarLog.gravaErro(PerguntaDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
