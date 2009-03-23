/*
 * @(#)TipoDAO.java 0.01 21/02/09
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
 * | Guillherme  | 21/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 *
 */
package br.edu.fei.sigepapp.bancodedados.dao;
//~-- JDK import --------------------------------------------------------------
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Tipo;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.util.Vector;
import oracle.jdbc.OracleTypes;

/** Classe responsavel pelo acesso as procedures do banco: <ul>
 * <li> APPP_SEL_TIPO - Seleciona tipos </li>
 * <li> APPP_INS_TIPO - Insere tipos    </li>
 * <li> APPP_UPD_TIPO - Atualiza tipos  </li>
 * <li> APPP_DEL_TIPO - Deleta tipos    </li>
 * </ul>
 */
public class TipoDAO {

    private Connection conn;

    public TipoDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();

    }


// <editor-fold defaultstate="collapsed" desc="Função - Preenche Lista">
    public List<Tipo> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo Tipo
        List<Tipo> tipos = new ArrayList<Tipo>();

        //Cria e preenche uma lista contendo os nomes das colunas da tabela
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_TIPO");
        camposDaTabela.add("NM_TIPO");
        camposDaTabela.add("DS_TIPO");
        camposDaTabela.add("FL_EXP_REG");

        while (rs.next()) {
            // Cria um objeto do tipo Tipo
            Tipo tipoNovo = new Tipo();

            //Para cada coluna
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                //Atribui o nome da coluna atual a variavel nomeColuna
                String nomeColuna = rs.getMetaData().getColumnName(i);
                //retorna o indice que esta coluna se encontra na lista
                int selecao = camposDaTabela.indexOf(nomeColuna);
                //seleciona cada caso de acordo com o indice e atribui ao objeto

                switch (selecao) {
                    case 0:
                        tipoNovo.setCd_tipo(rs.getLong(i));
                        break;
                    case 1:
                        tipoNovo.setNm_tipo(rs.getString(i));
                        break;
                    case 2:
                        tipoNovo.setDs_tipo(rs.getString(i));
                        break;
                    case 3:
                        tipoNovo.setFl_exp_reg(rs.getString(i));
                        break;
                }

            }
            //Adiciona o objeto a lista.
            tipos.add(tipoNovo);
        }
        //retorna a lista de tipos.
        return tipos;
    }

// </editor-fold>
    public List<Tipo> APPP_SEL_TIPO_OBJ(Tipo tipoPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_TIPO = tipoPesquisa.getCd_tipo();

        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin  APPP_SEL_TIPO(?, ?, ?, ?, ?); end;");


            if (pCD_TIPO > 0) {
                cstmt.setLong(1, pCD_TIPO);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            cstmt.setString(2, tipoPesquisa.getDs_tipo());
            cstmt.setString(3, tipoPesquisa.getFl_exp_reg());
            cstmt.setString(4, tipoPesquisa.getNm_tipo());

            cstmt.registerOutParameter(5, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(5);

            //Cria um array do tipo Tipo
            List<Tipo> tipos = PreencheList(rs);


            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Tipo.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return tipos;

        } catch (SQLException e) {
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Tipo.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());
            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public boolean APPP_INS_TIPO(Tipo tipoInserir) {
        CallableStatement cstmt = null;
        long resultado = 0;
        long pCD_TIPO=tipoInserir.getCd_tipo();

        try {
            cstmt = conn.prepareCall("begin  APPP_INS_TIPO( ?, ?, ?, ?, ?); end;");

            if (pCD_TIPO > 0) {
                cstmt.setLong(1, pCD_TIPO);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(2, tipoInserir.getNm_tipo());
            cstmt.setString(3, tipoInserir.getDs_tipo());
            cstmt.setString(4, tipoInserir.getFl_exp_reg());

            cstmt.registerOutParameter(5, OracleTypes.NUMBER);
            cstmt.execute();

            resultado = cstmt.getLong(5);

            cstmt.close();

            if (resultado == 1) {
                GravarLog.gravaInformacao(Tipo.class.getName() + ": adicao no banco de dados realizada com sucesso");
                return true;
            } else {
                GravarLog.gravaErro(Tipo.class.getName() + ": erro na adicao no banco de dados: Erro generico.");
                return false;
            }
        } catch (SQLException ex) {
            GravarLog.gravaErro(Tipo.class.getName() + ": erro na adicao no banco de dados: " + ex.getSQLState());
            return false;
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
            GravarLog.gravaErro(TipoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
