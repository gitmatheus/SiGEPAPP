/*
 * @(#)AntiPatternDAO.java 0.01 15/04/2009
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
 * | Matheus     | 15/04/2009    | Criação e elaboração inicial       |
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
import br.edu.fei.sigepapp.bancodedados.model.AntiPattern;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.util.Vector;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author matheus.goncalves
 */
public class AntiPatternDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexao com o banco de dados
     * @throws SQLException
     */
    public AntiPatternDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<AntiPattern> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo Estrutura
        List<AntiPattern> AntiPatterns = new ArrayList<AntiPattern>();

        //Cria e preenche uma lista contendo os nomes das colunas da tabela
        Vector<String> camposDaTabela = new Vector<String>();
        
        camposDaTabela.add("CD_ANTI_PATTERN");
        camposDaTabela.add("DS_SINTOMAS");
        camposDaTabela.add("DS_RECOMENDACOES");
        camposDaTabela.add("DS_CONSEQUENCIAS");
        camposDaTabela.add("DS_BARREIRAS");
        camposDaTabela.add("DS_PROBLEMA");
       
        while (rs.next()) {
            // Cria um objeto do tipo Estrutura
            AntiPattern AntiPatternNovo = new AntiPattern();

            //Para cada coluna
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                //Atribui o nome da coluna atual a variavel nomeColuna
                String nomeColuna = rs.getMetaData().getColumnName(i);
                //retorna o indice que esta coluna se encontra na lista
                int selecao = camposDaTabela.indexOf(nomeColuna);
                //seleciona cada caso de acordo com o indice e atribui ao objeto
                switch (selecao) {
                    case 0:
                        AntiPatternNovo.setCd_AntiPattern(rs.getLong(i));
                        break;
                    case 1:
                        AntiPatternNovo.setDs_Sintomas(rs.getString(i));
                        break;
                    case 2:
                        AntiPatternNovo.setDs_Recomendacoes(rs.getString(i));
                        break;
                    case 3:
                        AntiPatternNovo.setDs_Consequencias(rs.getString(i));
                        break;    
                    case 4:
                        AntiPatternNovo.setDs_Barreiras(rs.getString(i));
                        break;
                    case 5:
                        AntiPatternNovo.setDs_Problema(rs.getString(i));
                        break;
                }
            }
            //Adiciona o objeto a lista.
             AntiPatterns.add(AntiPatternNovo);
        }
        //retorna a lista de AntiPatterns.
        return AntiPatterns;
    }

    public List<AntiPattern> APPP_SEL_ANTI_PATTERN(AntiPattern AntiPatternPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_AntiPattern = 0;
        String pDS_SINTOMAS = "";
        String pDS_RECOMENDACOES = "";
        String pDS_CONSEQUENCIAS = "";
        String pDS_BARREIRAS = "";
        String pDS_PROBLEMA = "";
        
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin APPP_SEL_ANTI_PATTERN(?, ?, ?, ?, ?, ?, ?); end;");

            pCD_AntiPattern = AntiPatternPesquisa.getCd_AntiPattern();
            pDS_SINTOMAS = AntiPatternPesquisa.getDs_Sintomas();
            pDS_RECOMENDACOES = AntiPatternPesquisa.getDs_Recomendacoes();
            pDS_CONSEQUENCIAS = AntiPatternPesquisa.getDs_Consequencias();
            pDS_BARREIRAS = AntiPatternPesquisa.getDs_Barreiras();
            pDS_PROBLEMA = AntiPatternPesquisa.getDs_Problema();

            if (pCD_AntiPattern > 0) {
                cstmt.setLong(1, pCD_AntiPattern);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(2, pDS_SINTOMAS);
            cstmt.setString(3, pDS_RECOMENDACOES);
            cstmt.setString(4, pDS_CONSEQUENCIAS);
            cstmt.setString(5, pDS_BARREIRAS);
            cstmt.setString(6, pDS_PROBLEMA);
           
            cstmt.registerOutParameter(7, OracleTypes.CURSOR);

            cstmt.execute();
            
            rs = (ResultSet) cstmt.getObject(7);

            //Cria um array do tipo AntiPattern
            List<AntiPattern> AntiPatterns = PreencheList(rs);

            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Estrutura.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return AntiPatterns;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Estrutura.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public long APPP_INS_ANTI_PATTERN(AntiPattern AntiPatternAdicionar) {
        CallableStatement cstmt = null;

        try {
            long result = 0;
             //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin APPP_INS_ANTI_PATTERN(?, ?, ?, ?, ?, ?, ?); end;");
            
            cstmt.setLong(1, AntiPatternAdicionar.getCd_AntiPattern());
            cstmt.setString(2, AntiPatternAdicionar.getDs_Sintomas());
            cstmt.setString(3, AntiPatternAdicionar.getDs_Recomendacoes());
            cstmt.setString(4, AntiPatternAdicionar.getDs_Consequencias());
            cstmt.setString(5, AntiPatternAdicionar.getDs_Barreiras());
            cstmt.setString(6, AntiPatternAdicionar.getDs_Problema());
            cstmt.registerOutParameter(7, OracleTypes.NUMBER);

            cstmt.execute();
            result = cstmt.getLong(7);

            //fecha a instancia dos objetos
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(AntiPattern.class.getName() + ": Insercao no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return result;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(AntiPattern.class.getName() + ": erro na Insercao referente a uma exceção de SQL: " + e.getMessage());

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
            GravarLog.gravaErro(AntiPatternDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
