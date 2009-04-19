package br.edu.fei.sigepapp.bancodedados.dao;

/*
 * @(#)perguntaDAO.java 0.01 30/03/09
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
 * | Tom Mix     | 30/03/09    | Criacao                              |
 * |------------------------------------------------------------------|
 * | Tom Mix     | 18/04/09    | Atualizacao                          |
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
import br.edu.fei.sigepapp.bancodedados.model.Pergunta;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * Classe responsavel por acessar o banco de dados através do modelo pergunta
 *
 * @author Tom Mix
 * @version 0.01 31 Mar 2009
 */
public class PerguntaDAO {

    private Connection conn;

    /**
     * Contrutor da classe:- cria uma conexão com o banco de dados
     *
     * @throws SQLException
     */
    public PerguntaDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    /**
     * Metodo de inserção de pergunta no banco de dados
     * @param pergunta
     * @return 1 = Cadastrado / 2 = Existente no BD / 3 = Erro
     */
    public long APPP_INS_PERGUNTA(Pergunta pergunta) {
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para inserção do registro no banco
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_PERGUNTA(?, ?, ?); end;");

            //Seta os valores para os pontos de interrogação indexados pela ordem deles na string
            cstmt.setNull(1, OracleTypes.NUMBER);
            cstmt.registerOutParameter(1, OracleTypes.NUMBER);

            cstmt.setString(2, pergunta.getDs_pergunta());

            cstmt.setNull(3, OracleTypes.NUMBER);
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            long cResult = cstmt.getLong(3);

            //Grava log com a informação de sucesso
            if (cResult == 1) {
                GravarLog.gravaInformacao(PerguntaDAO.class.getName() + ": inserção no banco de dados realizada com sucesso");
                cstmt.close();
                return 1;
            } else if (cResult < 1) {
                GravarLog.gravaInformacao(PerguntaDAO.class.getName() + ": " + cResult + ": erro ao cadastrar nova pergunta.");
                cstmt.close();
                return 2;
            }
            return cResult;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(PerguntaDAO.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como false em caso de erro
            return 2;
        }
    }

    public boolean APPP_DEL_PERGUNTA(Pergunta pergunta) {
        try {
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_DEL_PERGUNTA(?,?,?); end;");

            cstmt.setLong(1, pergunta.getCd_pergunta());
            cstmt.setString(2, pergunta.getDs_pergunta());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong(13);

            return true;
        } catch (SQLException e) {
            return false;
        }
    }

    public List<Pergunta> APPP_SEL_PERGUNTA(Pergunta pergPesquisar) {

        CallableStatement cstmt = null;
        ResultSet rs = null;
        List<Pergunta> listaPerguntas = new ArrayList<Pergunta>();

        long cd_pergunta = pergPesquisar.getCd_pergunta();
        String ds_pergunta = pergPesquisar.getDs_pergunta();

        try {
            cstmt = conn.prepareCall("begin APPP_SEL_PERGUNTA(?,?,?); end;");

            if (cd_pergunta == 0) {
                cstmt.setNull(1, OracleTypes.NUMBER);
            } else {
                cstmt.setLong(1, cd_pergunta);
            }

            if (ds_pergunta == null) {
                cstmt.setNull(2, OracleTypes.VARCHAR);
            } else {
                cstmt.setString(2, ds_pergunta);
            }

            cstmt.registerOutParameter(3, OracleTypes.CURSOR);

            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(3);

            while (rs.next()) {
                listaPerguntas.add(new Pergunta(rs.getLong(1), rs.getString(2)));
            }

            rs.close();
            cstmt.close();

            GravarLog.gravaInformacao(Pergunta.class.getName() + ": pesquisa de pergunta realizada com sucesso");

        } catch (SQLException ex) {
            GravarLog.gravaErro(Pergunta.class.getName() + ": Erro na pesquisa de pergunta referente à uma exceção SQL: " + ex.getMessage());
        }

        return listaPerguntas;
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
