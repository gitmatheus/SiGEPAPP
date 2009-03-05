/*
 * @(#)AtributoDAO.java 0.01 21/02/09
 *
 * Este c�digo � parte integrante do projeto de formatura,
 * do curso de ci�ncias da computa��o, do Centro Universit�rio da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 21/02/09    | Cria��o e elabora��o inicial         |
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
import java.util.Vector;

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Atributo;
import br.edu.fei.sigepapp.log.GravarLog;
import com.sun.net.ssl.internal.ssl.Debug;
import java.sql.CallableStatement;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author lopespt
 */
public class AtributoDAO {

    private Connection conn;

    public AtributoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public int returnIndex(String selecionado, List<String> CamposDaTabela) {
        int posEncontrado = -1;
        for (int i = 0; i < CamposDaTabela.size(); i++) {
            if (CamposDaTabela.get(i).toUpperCase().equals(selecionado.toUpperCase())) {
                return i;
            }
        }
        return posEncontrado;
    }

    public List<Atributo> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo atributo
        List<Atributo> atributos = new ArrayList<Atributo>();
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_ATRIBUTO_OBJ");
        camposDaTabela.add("NM_ATRIBUTO_OBJ");
        camposDaTabela.add("DS_ATRIBUTO_OBJ");
        camposDaTabela.add("DS_TAM_ATRIB");
        camposDaTabela.add("CD_TIPO");
        camposDaTabela.add("FL_ATRIB_RELAC");
        while (rs.next()) {
            Debug.println("Passei!", "ok");
            // Cria um objeto do tipo Atributo
            Atributo atributoNovo = new Atributo();

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                String nomeColuna = rs.getMetaData().getColumnName(i);
                int selecao = returnIndex(nomeColuna, camposDaTabela);
                switch (selecao) {
                    case 0:
                        atributoNovo.setCd_atributo_obj(rs.getLong(i));
                        break;
                    case 1:
                        atributoNovo.setNm_atributo_obj(rs.getString(i));
                        break;
                    case 2:
                        atributoNovo.setDs_atributo_obj(rs.getString(i));
                        break;
                    case 3:
                        atributoNovo.setDs_tam_atrib(rs.getString(i));
                        break;
                    case 4:
                        atributoNovo.setCd_tipo(rs.getLong(i));
                        break;
                    case 5:
                        atributoNovo.setFl_atrib_relac(rs.getString(i));
                        break;
                }

            }
            atributos.add(atributoNovo);
        }
        return atributos;
    }

    public List<Atributo> APPP_SEL_ATRIBUTO_OBJ(Atributo atribPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_ATRIBUTO_OBJ = 0;
        long pCD_TIPO_OBJ=0;
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_SEL_ATRIBUTO_OBJ(?, ?, ?, ?, ?, ?); end;");

            pCD_ATRIBUTO_OBJ = atribPesquisa.getCd_atributo_obj();
            pCD_TIPO_OBJ=atribPesquisa.getCd_tipo();
            
            if(pCD_ATRIBUTO_OBJ > 0)
                cstmt.setLong(1, pCD_ATRIBUTO_OBJ);
            else
                cstmt.setNull(1,OracleTypes.NUMBER);

            cstmt.setString(2, atribPesquisa.getNm_atributo_obj());
            cstmt.setString(3, atribPesquisa.getDs_atributo_obj());
            if(pCD_TIPO_OBJ>0)
            cstmt.setLong(4, atribPesquisa.getCd_tipo());
            else
            cstmt.setNull(4, OracleTypes.NUMBER );

            cstmt.setString(5, atribPesquisa.getFl_atrib_relac());
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(6);

            //Cria um array do tipo Atributo
            List<Atributo> atributos = PreencheList(rs);


            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informa��o de sucesso
            GravarLog.gravaInformacao(Atributo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");



            //retorna uma lista com os usuarios selecionados
            return atributos;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execu��o do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na pesquisa referente a uma exce��o de SQL: " + e.getMessage());

            //Retorno da fun��o como null em caso de erro
            return null;
        }
    }
    /*
    public List<Atributo> seleciona(String query) {
    try {
    this.conn = ConnectionFactory.getConnection();
    // Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
    PreparedStatement stmt = this.conn.prepareStatement(query);

    // Executa a query e armazenando em um Objeto ResultSet
    ResultSet rs = stmt.executeQuery();
    // Enquando a pesquisa nao chegar ao fim ele armazena no array os resultados e permanece no loop
    // Cria um array do tipo atributo e referencia com o a lista do metodo preenchelist
    List<Atributo> atributos = atributos = PreencheList(rs);

    // fecha a instancia dos objetos
    rs.close();
    stmt.close();

    // Grava log com a informacao de sucesso
    GravarLog.gravaInformacao(Atributo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

    // Fecha conexao com o banco de dados
    this.conn.close();

    // retorna uma lista com os atributo selecionados
    return atributos;
    } catch (SQLException e) {

    // Grava log com o erro que ocorreu durante a execucao do comando SQL
    GravarLog.gravaErro(AtributoDAO.class.getName() + ": erro na pesquisa referente a uma excecao de SQL: " + e.getMessage());

    // Retorno da funcao como null em caso de erro
    return null;
    }
    }

    public boolean adiciona(Atributo atributoAdicionar) {
    try {
    this.conn = ConnectionFactory.getConnection();
    // Instancia um objeto da classe PreparedStatement com o comando para insercao do registro no banco
    PreparedStatement stmt =
    this.conn.prepareStatement(
    "insert into APPP_TB_ATRIBUTO_OBJ (CD_ATRIBUTO_OBJ, NM_ATRIBUTO_OBJ, DS_ATRIBUTO_OBJ, DS_TAM_ATRIB," + "CD_TIPO, FL_ATRIB_RELAC)" + "values (?, ?, ?, ?, ?, ?)");

    // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string
    stmt.setLong(1, atributoAdicionar.getCd_atributo_obj());
    stmt.setString(2, atributoAdicionar.getNm_atributo_obj());
    stmt.setString(3, atributoAdicionar.getDs_atributo_obj());
    stmt.setString(4, atributoAdicionar.getDs_tam_atrib());
    stmt.setLong(5, atributoAdicionar.getCd_tipo());
    stmt.setString(6, atributoAdicionar.getFl_atrib_relac());

    // executa o comando e fecha a instancia do objeto
    stmt.execute();
    stmt.close();

    // Grava log com a informacao de sucesso
    GravarLog.gravaInformacao(Atributo.class.getName() + ": insercao no banco de dados realizada com sucesso");

    // Fecha conexao com o banco de dados


    this.conn.close();

    // Retorno da funcao como true



    return true;
    } catch (SQLException e) {

    // Grava log com o erro que ocorreu durante a execucao do comando SQL
    GravarLog.gravaErro(AtributoDAO.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

    // Retorno da funcao como false em caso de erro



    return false;
    }

    }

    public boolean deleta(Atributo atributoDeletar) {
    try {
    this.conn = ConnectionFactory.getConnection();
    PreparedStatement stmt = conn.prepareStatement("delete from APPP_TB_ATRIBUTO_OBJ where CD_ATRIBUTO_OBJ=?");
    stmt.setLong(1, atributoDeletar.getCd_atributo_obj());
    stmt.execute();
    stmt.close();

    this.conn.close();

    return true;
    } catch (SQLException e) {

    // Grava log com o erro que ocorreu durante a execucao do comando SQL
    GravarLog.gravaErro(AtributoDAO.class.getName() + ": erro na insercao referente a uma excecao de SQL: " + e.getMessage());

    // Retorno da funcao como false em caso de erro



    return false;
    }
    }

    public boolean atualiza(Atributo atributoAtualizar) {
    try {
    this.conn = ConnectionFactory.getConnection();
    // Instancia um objeto da classe PreparedStatement com o comando para atualizacao do registro no banco
    PreparedStatement stmt =
    this.conn.prepareStatement(
    "update APPP_TB_ATRIBUTO_OBJ set NM_ATRIBUTO_OBJ=?, DS_ATRIBUTO_OBJ=?, DS_TAM_ATRIB=?," + "CD_TIPO=?, FL_ATRIB_RELAC=? where CD_ATRIBUTO_OBJ=?");

    // Seta os valores para os pontos de interrogacao indexados pela ordem deles na string

    stmt.setString(1, atributoAtualizar.getNm_atributo_obj());
    stmt.setString(2, atributoAtualizar.getDs_atributo_obj());
    stmt.setString(3, atributoAtualizar.getDs_tam_atrib());
    stmt.setLong(4, atributoAtualizar.getCd_tipo());
    stmt.setString(5, atributoAtualizar.getFl_atrib_relac());

    stmt.setLong(6, atributoAtualizar.getCd_atributo_obj());
    // executa o comando e fecha a instancia do objeto
    stmt.execute();
    stmt.close();

    // Grava log com a informacao de sucesso
    GravarLog.gravaInformacao(Atributo.class.getName() + ": atualizacao no banco de dados realizada com sucesso");

    // Fecha conexao com o banco de dados


    this.conn.close();

    // retorno da funcao como true

    return true;
    } catch (SQLException e) {

    // Grava log com o erro que ocorreu durante a execucao do comando SQL
    GravarLog.gravaErro(AtributoDAO.class.getName() + ": erro na atualizacao referente a uma excecao de SQL: " + e.getMessage());

    // Retorno da funcao como false em caso de erro
    return false;
    }
    }
     */

    /**
     * Metodo para fechar o banco de dados da classe
     */
    public void fechaConexao() {
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(AtributoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
