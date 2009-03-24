/*
 * @(#)Estrutura_ObjDAO.java 0.01 21/02/09
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
 * | Guilherme   | 21/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 *
 */

//~-- JDK import --------------------------------------------------------------
package br.edu.fei.sigepapp.bancodedados.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Date;
import java.util.Vector;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author lopespt
 */
public class Estrutura_ObjDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexao com o banco de dados
     * @throws SQLException
     */
    public Estrutura_ObjDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Estrutura> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo Estrutura
        List<Estrutura> estruturas = new ArrayList<Estrutura>();

        //Cria e preenche uma lista contendo os nomes das colunas da tabela
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_ESTRUTURA");
        camposDaTabela.add("NM_ESTRUTURA");
        camposDaTabela.add("DS_ESTRUTURA");
        camposDaTabela.add("DT_CRIACAO");
        camposDaTabela.add("CD_USER");
        camposDaTabela.add("TP_ESTRUTURA");

        while (rs.next()) {
            // Cria um objeto do tipo Estrutura
            Estrutura EstruturaNovo = new Estrutura();

            //Para cada coluna
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                //Atribui o nome da coluna atual a variavel nomeColuna
                String nomeColuna = rs.getMetaData().getColumnName(i);
                //retorna o indice que esta coluna se encontra na lista
                int selecao = camposDaTabela.indexOf(nomeColuna);
                //seleciona cada caso de acordo com o indice e atribui ao objeto
                switch (selecao) {
                    case 0:
                        EstruturaNovo.setCd_estrutura(rs.getLong(i));
                        break;
                    case 1:
                        EstruturaNovo.setNm_estrutura(rs.getString(i));
                        break;
                    case 2:
                        EstruturaNovo.setDs_estrutura(rs.getString(i));
                        break;
                    case 3:
                        EstruturaNovo.setDt_criacao(rs.getDate(i));
                        break;
                    case 4:
                        EstruturaNovo.setCod_user(rs.getLong(i));
                        break;
                    case 5:
                        EstruturaNovo.setTp_estrutura(rs.getString(i));
                        break;
                }
            }
            //Adiciona o objeto a lista.
            estruturas.add(EstruturaNovo);
        }
        //retorna a lista de Estruturas.
        return estruturas;
    }

    public List<Estrutura> APPP_SEL_Estrutura_OBJ(Estrutura estrutPesquisa, Date dataFim) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_ESTRUTURA_OBJ = 0;
        long pCD_USUARIO = 0;
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_SEL_ESTRUT_OBJ(?, ?, ?, ?, ?, ?, ?, ?); end;");

            pCD_ESTRUTURA_OBJ = estrutPesquisa.getCd_estrutura();
            pCD_USUARIO = estrutPesquisa.getCod_user();

            if (pCD_ESTRUTURA_OBJ > 0) {
                cstmt.setLong(1, pCD_ESTRUTURA_OBJ);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            cstmt.setString(2, estrutPesquisa.getNm_estrutura());
            cstmt.setString(3, estrutPesquisa.getDs_estrutura());

            cstmt.setDate(4, estrutPesquisa.getDt_criacao());
            cstmt.setDate(5, dataFim);

            if (pCD_USUARIO > 0) {
                cstmt.setLong(6, estrutPesquisa.getCod_user());
            } else {
                cstmt.setNull(6, OracleTypes.NUMBER);
            }

            cstmt.setString(7, estrutPesquisa.getTp_estrutura());

            cstmt.registerOutParameter(8, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(8);

            //Cria um array do tipo Estrutura
            List<Estrutura> Estruturas = PreencheList(rs);

            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Estrutura.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return Estruturas;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Estrutura.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public List<Estrutura> APPP_SEL_Estrutura_Geral(Estrutura estrutPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_SEL_ESTRUT_OBJ(?, ?, ?, ?, ?, ?, ?, ?); end;");

            cstmt.setNull(1, OracleTypes.NUMBER);
            cstmt.setNull(2, OracleTypes.VARCHAR);
            cstmt.setNull(3, OracleTypes.VARCHAR);
            cstmt.setNull(4, OracleTypes.DATE);
            cstmt.setNull(5, OracleTypes.DATE);
            cstmt.setNull(6, OracleTypes.NUMBER);
            cstmt.setString(7, estrutPesquisa.getTp_estrutura());

            cstmt.registerOutParameter(8, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(8);

            //Cria um array do tipo Estrutura
            List<Estrutura> Estruturas = PreencheList(rs);

            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Estrutura.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return Estruturas;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Estrutura.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public long APPP_INS_Estrutura_Obj(Estrutura estrutAdicionar) {
        CallableStatement cstmt = null;

        try {
            long result = 0;
            long cod_estrutura = 0;
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_INS_ESTRUT_OBJ(?, ?, ?, ?, ?, ?); end;");

            cstmt.setLong(4, estrutAdicionar.getCod_user());
            cstmt.setString(3, estrutAdicionar.getDs_estrutura());
            cstmt.setString(2, estrutAdicionar.getNm_estrutura());
            cstmt.setString(5, estrutAdicionar.getTp_estrutura());

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            cstmt.execute();
            cod_estrutura = cstmt.getLong(1);
            result = cstmt.getLong(6);

            //fecha a instancia dos objetos
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Estrutura.class.getName() + ": Insercao no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return cod_estrutura;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Estrutura.class.getName() + ": erro na Insercao referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return -1;
        }
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
            GravarLog.gravaErro(Estrutura_ObjDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
