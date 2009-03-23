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

/** Classe responsavel pelo acesso as procedures do banco: <ul>
 * <li> APPP_SEL_ATRIBUTO_OBJ - Seleciona atributos </li>
 * <li> APPP_INS_ATRIBUTO_OBJ - Insere atributos    </li>
 * <li> APPP_UPD_ATRIBUTO_OBJ - Atualiza atributos  </li>
 * <li> APPP_DEL_ATRIBUTO_OBJ - Deleta atributos    </li>
 * </ul>
 */
public class AtributoDAO {

    private Connection conn;
    /** Construtor da classe DAO:
     * Todos os atributos da classe terao como valores NULL
     *  
     * @throws java.sql.SQLException caso
     */
    public AtributoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();

    }

    /** Funcao reponsavel para preencher a lista de atributos dado um result set
     * @param rs ResultSet contendo os dados pesquisados.
     * @return Uma lista de atributos contendo os dados do ResultSet
     */
    public List<Atributo> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo atributo
        List<Atributo> atributos = new ArrayList<Atributo>();

        //Cria e preenche uma lista contendo os nomes das colunas da tabela
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_ATRIBUTO_OBJ");
        camposDaTabela.add("NM_ATRIBUTO_OBJ");
        camposDaTabela.add("DS_ATRIBUTO_OBJ");
        camposDaTabela.add("CD_TIPO");
        camposDaTabela.add("FL_ATRIB_RELAC");

        while (rs.next()) {
            // Cria um objeto do tipo Atributo
            Atributo atributoNovo = new Atributo();

            //Para cada coluna
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                //Atribui o nome da coluna atual a variavel nomeColuna
                String nomeColuna = rs.getMetaData().getColumnName(i);
                //retorna o indice que esta coluna se encontra na lista
                int selecao = camposDaTabela.indexOf(nomeColuna);
                //seleciona cada caso de acordo com o indice e atribui ao objeto
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
            //Adiciona o objeto a lista.
            atributos.add(atributoNovo);
        }
        //retorna a lista de atributos.
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

    public boolean APPP_INS_ATRIBUTO_OBJ(Atributo atributoInserir) {
        CallableStatement cstmt = null;
        long resultado = 0;

        try {
            cstmt = conn.prepareCall("begin  APPP_INS_ATRIBUTO_OBJ( ?, ?, ?, ?, ?,?); end;");
            cstmt.setNull(1, OracleTypes.NUMBER);
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
            cstmt = conn.prepareCall("begin  APPP_UPD_ATRIBUTO_OBJ( ?, ?, ?, ?, ?, ?); end;");

            //Seta o codigo do atributo NULL (A chave sera gerada automaticamente pela procedure do banco)
            cstmt.setLong(1, atributoAtualizar.getCd_atributo_obj());
            cstmt.setString(2, atributoAtualizar.getNm_atributo_obj());
            cstmt.setString(3, atributoAtualizar.getDs_atributo_obj());
            cstmt.setLong(4, atributoAtualizar.getCd_tipo());
            cstmt.setString(5, atributoAtualizar.getFl_atrib_relac());

            cstmt.registerOutParameter(6, OracleTypes.NUMBER);
            cstmt.execute();

            resultado = cstmt.getLong(6);

            cstmt.close();


            if (resultado == 1) {
                GravarLog.gravaInformacao(Atributo.class.getName() + ": atualizacao no banco de dados realizada com sucesso");
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
            cstmt = conn.prepareCall("begin  APPP_DEL_ATRIBUTO_OBJ( ?, ?, ?, ?, ?, ?); end;");
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

    public List<Atributo> APPP_PES_ATRIB_POR_ESTRUT(long Cd_Estrutura) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_PES_ATRIB_POR_ESTRUT(?, ?); end;");

            cstmt.setLong(1 , Cd_Estrutura);

            cstmt.registerOutParameter(2, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(2);

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
