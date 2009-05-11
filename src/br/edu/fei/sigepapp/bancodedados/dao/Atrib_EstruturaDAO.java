/*
 * @(#)Atrib_EstruturaDAO.java 0.01 03/03/09
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
 * | Guilherme   | 03/03/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 *
 */

//~-- JDK import --------------------------------------------------------------
package br.edu.fei.sigepapp.bancodedados.dao;

import java.sql.Connection;
import java.sql.SQLException;

//~SIGEPAPP import ------------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.model.Atrib_Estrutura;
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Atributo;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author lopespt
 */
public class Atrib_EstruturaDAO {

    private Connection conn;

    public Atrib_EstruturaDAO() throws SQLException {
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

    public List<Atrib_Estrutura> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo atributo
        List<Atrib_Estrutura> AtribEsts = new ArrayList<Atrib_Estrutura>();
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_ESTRUTURA");
        camposDaTabela.add("CD_ATRIBUTO_OBJ");

        while (rs.next()) {
            // Cria um objeto do tipo Atributo
            Atrib_Estrutura atributoEstNovo = new Atrib_Estrutura();

            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                String nomeColuna = rs.getMetaData().getColumnName(i);
                int selecao = returnIndex(nomeColuna, camposDaTabela);
                switch (selecao) {
                    case 0:
                        atributoEstNovo.setCd_estrutura(rs.getLong(i));
                        break;
                    case 1:
                        atributoEstNovo.setCd_atributo_obj(rs.getLong(i));
                        break;
                }

            }
            AtribEsts.add(atributoEstNovo);
        }
        return AtribEsts;
    }

    public List<Atrib_Estrutura> APPP_SEL_ATRIB_ESTRUTURA(Atrib_Estrutura atrib_EstruturaPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_ATRIBUTO_OBJ = 0;
        long pCD_ESTRUTURA = 0;
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_SEL_ATRIB_ESTRUTURA(?, ?, ?); end;");

            pCD_ATRIBUTO_OBJ = atrib_EstruturaPesquisa.getCd_atributo_obj();
            pCD_ESTRUTURA = atrib_EstruturaPesquisa.getCd_estrutura();

            if (pCD_ESTRUTURA > 0) {
                cstmt.setLong(1, pCD_ESTRUTURA);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            if (pCD_ATRIBUTO_OBJ > 0) {
                cstmt.setLong(2, pCD_ATRIBUTO_OBJ);
            } else {
                cstmt.setNull(2, OracleTypes.NUMBER);
            }

            cstmt.registerOutParameter(3, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(3);

            //Cria um array do tipo Atributo
            List<Atrib_Estrutura> atributoEstruturas = PreencheList(rs);


            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Atributo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");



            //retorna uma lista com os usuarios selecionados
            return atributoEstruturas;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getSQLState());

            //Retorno da função como null em caso de erro
            return null;
        }

    }

    public boolean APPP_INS_ATRIB_ESTRUTURA(Atrib_Estrutura atrib_EstruturaInserir) {
        CallableStatement cstmt = null;
        ResultSet rs = null;
        long vResult = 0;

        try {
            if (atrib_EstruturaInserir.getCd_atributo_obj() == 0 || atrib_EstruturaInserir.getCd_estrutura() == 0) {
                return false;
            } else {

                cstmt = conn.prepareCall("begin APPP_INS_ATRIB_ESTRUTURA(?,?,?); end;");
                cstmt.setLong(1, atrib_EstruturaInserir.getCd_estrutura());
                cstmt.setLong(2, atrib_EstruturaInserir.getCd_atributo_obj());

                cstmt.registerOutParameter(3, OracleTypes.NUMBER);

                cstmt.execute();

                vResult = cstmt.getLong(3);

                if (vResult == 1) {
                    return true;
                } else {
                    return false;
                }

            }
        } catch (SQLException ex) {
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na inserção referente a uma exceção de SQL: " + ex.getSQLState());

            return false;

        }
    }

    public long APPP_CRIA_TABELA_ESTRUT(long CodEstrut) {

        CallableStatement cstmt = null;
        ResultSet rs = null;
        long vResult = 0;

        try {
                cstmt = conn.prepareCall("begin APPP_CRIA_TABELA_ESTRUT(?,?); end;");
                cstmt.setLong(1, CodEstrut);
                cstmt.registerOutParameter(2, OracleTypes.NUMBER);
                cstmt.execute();
                vResult = cstmt.getLong(2);

                return vResult;
        } catch (SQLException ex) {
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na criação da tabela de estrutura no banco: " + ex.getSQLState());
                return vResult;
        }
    }

    public void fechaConexao() {
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(AtributoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }

    public boolean campoDescritivo(String vCampo) {

        return ((vCampo.toUpperCase().matches("DESCRIÇÃO")) || (vCampo.toUpperCase().matches("CONTEXTO")) || (vCampo.toUpperCase().matches("PROBLEMA")) || (vCampo.toUpperCase().matches("SOLUÇÃO")) || (vCampo.toUpperCase().matches("BARREIRAS")) || (vCampo.toUpperCase().matches("SINTOMAS")) || (vCampo.toUpperCase().matches("CONSEQUÊNCIAS")) || (vCampo.toUpperCase().matches("RECOMENDAÇÕES")));
    }
}
