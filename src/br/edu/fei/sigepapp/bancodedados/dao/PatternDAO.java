/*
 * @(#)PatternDAO.java 0.01 15/04/2009
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
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.bancodedados.model.Pattern;
import br.edu.fei.sigepapp.log.GravarLog;
import com.sun.net.ssl.internal.ssl.Debug;
import java.sql.CallableStatement;
import java.util.Vector;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author matheus.goncalves
 */
public class PatternDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexao com o banco de dados
     * @throws SQLException
     */
    public PatternDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Pattern> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array
        List<Pattern> patterns = new ArrayList<Pattern>();

        //Cria e preenche uma lista contendo os nomes das colunas da tabela
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_PATTERN");
        camposDaTabela.add("DS_PAT_PROBLEMA");
        camposDaTabela.add("DS_PAT_SOLUCAO");
        
        while (rs.next()) {
            // Cria um objeto do tipo Estrutura
            Pattern PatternNovo = new Pattern();

            //Para cada coluna
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                //Atribui o nome da coluna atual a variavel nomeColuna
                String nomeColuna = rs.getMetaData().getColumnName(i);
                //retorna o indice que esta coluna se encontra na lista
                int selecao = camposDaTabela.indexOf(nomeColuna);
                //seleciona cada caso de acordo com o indice e atribui ao objeto
                switch (selecao) {
                    case 0:
                        PatternNovo.setCd_Pattern(rs.getLong(i));
                        break;
                    case 1:
                        PatternNovo.setDs_Pat_problema(rs.getString(i));
                        break;
                    case 2:
                        PatternNovo.setDs_Pat_solucao(rs.getString(i));
                        break;
                }
            }
            //Adiciona o objeto a lista.
             patterns.add(PatternNovo);
        }
        //retorna a lista de Patterns.
        return patterns;
    }

    public List<Pattern> APPP_SEL_PATTERN(Pattern PatternPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_PATTERN = 0;
        String pDS_PAT_PROBLEMA = "";
        String pDS_PAT_SOLUCAO = "";

        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin APPP_SEL_PATTERN(?, ?, ?, ?); end;");

            pCD_PATTERN = PatternPesquisa.getCd_Pattern();
            pDS_PAT_PROBLEMA = PatternPesquisa.getDs_Pat_problema();
            pDS_PAT_SOLUCAO  = PatternPesquisa.getDs_Pat_solucao();
                   

            if (pCD_PATTERN > 0) {
                cstmt.setLong(1, pCD_PATTERN);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(2, pDS_PAT_PROBLEMA);
            cstmt.setString(3, pDS_PAT_SOLUCAO);
            
            cstmt.registerOutParameter(4, OracleTypes.CURSOR);

            cstmt.execute();
            
            rs = (ResultSet) cstmt.getObject(4);

            //Cria um array do tipo Pattern
            List<Pattern> Patterns = PreencheList(rs);

            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(PatternDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return Patterns;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(PatternDAO.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public long APPP_INS_PATTERN(Pattern patternAdicionar) {
        CallableStatement cstmt = null;

        try {
            long result = 0;
             //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin APPP_INS_PATTERN(?, ?, ?, ?); end;");
            
            cstmt.setLong(1, patternAdicionar.getCd_Pattern());
            cstmt.setString(2, patternAdicionar.getDs_Pat_problema());
            cstmt.setString(3, patternAdicionar.getDs_Pat_solucao());
            cstmt.registerOutParameter(4, OracleTypes.NUMBER);

            cstmt.execute();
            result = cstmt.getLong(4);

            //fecha a instancia dos objetos
            cstmt.close();

            if(result != 1){
                GravarLog.gravaErro(PatternDAO.class.getName() + ": ocorreu um erro durante a inserção no banco: " + result);
                return 0;
            }else{
                GravarLog.gravaInformacao(PatternDAO.class.getName() + ": inserido com sucesso");
                return 1;
            }
        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Pattern.class.getName() + ": erro na Insercao referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return -1;
        }
    }

    public long APPP_CREATE_PATTERN(Pattern pattern, Objeto objeto) {
        CallableStatement cstmt = null;

        try {
            long result = 0;
            long cObjeto = 0;
            cstmt = conn.prepareCall("begin APPP_CREATE_PATTERN(?, ?, ?, ?, ?, ?, ?, ?); end;");
            
            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            
            cstmt.setString(2, objeto.getNm_objeto());
            cstmt.setLong(3, objeto.getCd_estrutura());
            cstmt.setString(4, objeto.getDs_objeto());
            cstmt.setLong(5, objeto.getCd_user_criacao());
            cstmt.setString(6, pattern.getDs_Pat_problema());
            cstmt.setString(7, pattern.getDs_Pat_solucao());
            
            cstmt.registerOutParameter(8, OracleTypes.NUMBER);

            cstmt.execute();
            cObjeto = cstmt.getLong(1);
            result = cstmt.getLong(8);

            //fecha a instancia dos objetos
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(PatternDAO.class.getName() + ": Insercao no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            Debug.println("Codigo Obj", Long.toString(cObjeto));
            return cObjeto;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Pattern.class.getName() + ": erro na Insercao referente a uma exceção de SQL: " + e.getMessage());

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
            GravarLog.gravaErro(PatternDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
