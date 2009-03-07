/*
 * @(#)AtributoDAO.java 0.01 21/02/09
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
 * | Guilherme   | 01/03/09    | Mudanca de metodos para utilizacao   |
 * |             |             | das procedures do banco              |
 * |------------------------------------------------------------------|
 * | Guilherme   | 07/03/09    | Insercao dos metodos de ADD,DEL e UPD|
 * |             |             | de acordo com as procedures.         |
 * |             |             | Eliminado atributo DS_TAM_ATRIB.     |
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
        camposDaTabela.add("CD_TIPO");
        camposDaTabela.add("FL_ATRIB_RELAC");
        while (rs.next()) {
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
                        atributoNovo.setCd_tipo(rs.getLong(i));
                        break;
                    case 4:
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
        long pCD_TIPO_OBJ = 0;
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_SEL_ATRIBUTO_OBJ(?, ?, ?, ?, ?, ?); end;");

            pCD_ATRIBUTO_OBJ = atribPesquisa.getCd_atributo_obj();
            pCD_TIPO_OBJ = atribPesquisa.getCd_tipo();

            if (pCD_ATRIBUTO_OBJ > 0) {
                cstmt.setLong(1, pCD_ATRIBUTO_OBJ);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            cstmt.setString(2, atribPesquisa.getNm_atributo_obj());
            cstmt.setString(3, atribPesquisa.getDs_atributo_obj());
            if (pCD_TIPO_OBJ > 0) {
                cstmt.setLong(4, atribPesquisa.getCd_tipo());
            } else {
                cstmt.setNull(4, OracleTypes.NUMBER);
            }

            cstmt.setString(5, atribPesquisa.getFl_atrib_relac());
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(6);

            //Cria um array do tipo Atributo
            List<Atributo> atributos = PreencheList(rs);


            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Atributo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");



            //retorna uma lista com os usuarios selecionados
            return atributos;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getSQLState());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public boolean APPP_INS_ATRIBUTO_OBJ(Atributo atributoInserir) {
        CallableStatement cstmt = null;
        long resultado = 0;

        try {
            cstmt = conn.prepareCall("begin  APPP_INS_ATRIBUTO_OBJ(?, ?, ?, ?, ?, ?); end;");
            cstmt.setString(2, atributoInserir.getNm_atributo_obj());
            cstmt.setString(3, atributoInserir.getDs_atributo_obj());
            cstmt.setLong(4, atributoInserir.getCd_tipo());

            cstmt.setString(5, atributoInserir.getFl_atrib_relac());

            cstmt.registerOutParameter(6, OracleTypes.NUMBER);
            cstmt.execute();

            resultado = cstmt.getLong(6);

            cstmt.close();




            if (resultado == 1) {
                GravarLog.gravaInformacao(Atributo.class.getName() + ": adicao no banco de dados realizada com sucesso");
                return true;
            } else {
                GravarLog.gravaErro(Atributo.class.getName() + ": erro na adicao no banco de dados: Erro generico.");
                return false;
            }
        } catch (SQLException ex) {
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na adicao no banco de dados: " + ex.getSQLState());
            return false;
        }

    }

    public boolean APPP_UPD_ATRIBUTO_OBJ(Atributo atributoAtualizar) {
        CallableStatement cstmt = null;
        long resultado = 0;

        try {
            cstmt = conn.prepareCall("begin  APPP_UPD_ATRIBUTO_OBJ(?, ?, ?, ?, ?, ?); end;");

            //Seta o codigo do atributo NULL (A chave sera gerada automaticamente pela procedure do banco)
            cstmt.setNull(1, OracleTypes.NUMBER);
            cstmt.setString(2, atributoAtualizar.getNm_atributo_obj());
            cstmt.setString(3, atributoAtualizar.getDs_atributo_obj());
            cstmt.setLong(4, atributoAtualizar.getCd_tipo());

            cstmt.setString(5, atributoAtualizar.getFl_atrib_relac());

            cstmt.registerOutParameter(6, OracleTypes.NUMBER);
            cstmt.execute();

            resultado = cstmt.getLong(6);

            cstmt.close();


            if (resultado == 1) {
                GravarLog.gravaInformacao(Atributo.class.getName() + ": adicao no banco de dados realizada com sucesso");
                return true;
            } else {
                GravarLog.gravaErro(Atributo.class.getName() + ": erro na adicao no banco de dados: Erro generico.");
                return false;
            }
        } catch (SQLException ex) {
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na adicao no banco de dados: " + ex.getSQLState());
            return false;
        }

    }

    public boolean APPP_DEL_ATRIBUTO_OBJ(Atributo atributoDeletar) {

        CallableStatement cstmt = null;
        long resultado = 0;

        //Seta as variaveis longs
        long pCD_ATRIBUTO_OBJ = atributoDeletar.getCd_atributo_obj();
        long pCD_TIPO_OBJ = atributoDeletar.getCd_tipo();

        try {
            cstmt = conn.prepareCall("begin  APPP_DEL_ATRIBUTO_OBJ(?, ?, ?, ?, ?, ?); end;");
            if (pCD_ATRIBUTO_OBJ > 0) {
                cstmt.setLong(1, pCD_ATRIBUTO_OBJ);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            if (pCD_TIPO_OBJ > 0) {
                cstmt.setLong(4, pCD_TIPO_OBJ);
            } else {
                cstmt.setNull(4, OracleTypes.NUMBER);
            }

            cstmt.setString(2, atributoDeletar.getNm_atributo_obj());
            cstmt.setString(3, atributoDeletar.getDs_atributo_obj());
            cstmt.setString(5, atributoDeletar.getFl_atrib_relac());
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);
            cstmt.execute();

            resultado = cstmt.getLong(6);
            cstmt.close();

            if (resultado > 0) {
                GravarLog.gravaInformacao(Atributo.class.getName() + ": remocao no banco de dados realizada com sucesso");
                return true;
            } else if (resultado == 0) {
                GravarLog.gravaErro(Atributo.class.getName() + ": erro na remocao no banco de dados: Registro nao encontrado.");
                return false;
            } else {
                GravarLog.gravaErro(Atributo.class.getName() + ": erro na remocao no banco de dados: Erro generico.");
                return false;
            }

        } catch (SQLException ex) {
            GravarLog.gravaErro(Atributo.class.getName() + ": erro na remocao no banco de dados:" + ex.getSQLState());
            return false;
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
}
