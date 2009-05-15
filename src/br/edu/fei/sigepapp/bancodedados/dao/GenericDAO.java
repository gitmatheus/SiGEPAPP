package br.edu.fei.sigepapp.bancodedados.dao;
/*
 * @(#)UsuarioDAO.java 0.01 20/02/09
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
 * | Andrey      | 20/02/09    | Criação e elaboração inicial         |
 * | Guilherme   | 14/05/09    | Adicao de Busca por Similaridade     |
 * |------------------------------------------------------------------|
 *
 */

//~-- JDK import --------------------------------------------------------------
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;

import oracle.jdbc.OracleTypes;
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.AtributosBuscaSimilaridade;
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import br.edu.fei.sigepapp.servlet.CadUsuarioServlet;
import com.sun.net.ssl.internal.ssl.Debug;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Vector;

/**
 *
 * @author Andrey
 * @version 0.01 15 Abr 2009
 */
public class GenericDAO {

    private Connection conn;

    /**
     * Contrutor da classe:- cria uma conexão com o banco de dados
     *
     * @throws SQLException
     */
    public GenericDAO() throws SQLException {

        this.conn = ConnectionFactory.getConnection();

    }

    /**
     *
     * @param strValores
     * @param strAtributos
     * @return
     */
    public long insertData(Long codigo_est, Long codigo_user, String strValores[], String strColuna[], String strAtributos[]) {
        try {
            String nm_tabela = new String();
            String sql = new String();

            Objeto objeto = new Objeto();
            objeto.setCd_estrutura(codigo_est);
            objeto.setNm_objeto(strValores[0]);
            objeto.setDs_objeto(strValores[1]);
            objeto.setCd_user_criacao(codigo_user);
            objeto.setFl_ativo(1);

            ObjetoDAO dao = new ObjetoDAO();
            long codigo_obj = dao.insereObjeto(objeto);
            dao.fechaConexao();

            if (codigo_obj < 1) {
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": erro na criação do objeto.");
                return 3;
            }

            nm_tabela = buscaNomeTabela(codigo_est);

            if (nm_tabela.equals("")) {
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": nome da tabela nao encontrado.");
                return 4; //Tabela não encontrada
            }

            sql = "begin APPP_INS_" + nm_tabela.substring(8, nm_tabela.length()) + "(";
            for (int i = 0; i < (strAtributos.length + 2); i++) {
                if (i == (strAtributos.length + 1)) {
                    sql += "?";
                } else {
                    sql += "?, ";
                }
            }
            sql += "); end;";

            CallableStatement cstmt = this.conn.prepareCall(sql);
            cstmt.setLong("pCD_OBJETO", codigo_obj);
            for (int i = 0; i < strAtributos.length; i++) {
                if (strAtributos[i].equals("NUMBER")) {
                    cstmt.setLong("p" + strColuna[i], Long.parseLong(strValores[i]));
                } else if (strAtributos[i].equals("DATE")) {
                    SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                    try {
                        Date dt = new Date(df.parse(strValores[i]).getTime());
                        cstmt.setDate("p" + strColuna[i], dt);
                    } catch (ParseException e) {
                        GravarLog.gravaErro(CadUsuarioServlet.class.getName() + ": erro no parse da data: " + e.getMessage());
                    }
                } else if (strAtributos[i].equals("VARCHAR") || strAtributos[i].equals("VARCHAR2")) {
                    cstmt.setString("p" + strColuna[i], strValores[i]);
                }
            }
            cstmt.registerOutParameter("vResult", OracleTypes.NUMBER);

            cstmt.execute();

            int cResult = (int) cstmt.getLong("vResult");

            if (cResult == 1) {
                GravarLog.gravaInformacao(GenericDAO.class.getName() + ": inserção efetuada com sucesso");
                return 1;
            } else {
                GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro no banco de dados durante a operação de inserção : erro " + cResult);
                return 2;
            }

        } catch (SQLException e) {
            GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro durante a inserção de dados : " + e.getMessage() + " : " + e.getSQLState());
            return 0;
        }
    }

    public String buscaNomeTabela(long cod_estr) {
        try {

            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_ESTRUT_OBJ(?,?,?,?,?,?,?,?); end;");
            cstmt.setLong(1, cod_estr);
            cstmt.setNull(2, OracleTypes.VARCHAR);
            cstmt.setNull(3, OracleTypes.VARCHAR);
            cstmt.setNull(4, OracleTypes.DATE);
            cstmt.setNull(5, OracleTypes.DATE);
            cstmt.setNull(6, OracleTypes.NUMBER);
            cstmt.setNull(7, OracleTypes.VARCHAR);
            cstmt.registerOutParameter(8, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(8);
            String s = new String();
            int tamResultSet = 0;
            while (rs.next()) {
                tamResultSet++;
                s = rs.getString("NM_TB_ESTRUT");
            }

            rs.close();
            cstmt.close();

            if (tamResultSet != 1) {
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": numero de linhas encontradas não esperadas : Nro: " + tamResultSet);
                return "";
            } else {
                return s;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(GenericDAO.class.getName() + ": erro ao pesquisar o nome da tabela: " + e.getMessage() + " : " + e.getSQLState() + " : " + e.getLocalizedMessage());
            return "";
        }
    }

    /*
     *
     * Método que retorna objetos do tipo Pattern e Anti-Pattern que são similares ao parâmetros fornecidos.
     *
     */
    
    public List<AtributosBuscaSimilaridade> buscaSimilaridade(String nome_procurado, String contexto_procurado, String problema_procurado, String solucao_procurado) {
        List<AtributosBuscaSimilaridade> retorno=new Vector<AtributosBuscaSimilaridade>();

        try {

            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_APP_SIMILARIDADE(?,?,?,?,?,?,?,?,?,?); end;");
            cstmt.registerOutParameter(1, OracleTypes.CURSOR);
            //Atributos
            cstmt.setString(2, nome_procurado);
            cstmt.setString(3, contexto_procurado);
            cstmt.setString(4, problema_procurado);
            cstmt.setString(5, solucao_procurado);
            //Pesos
            cstmt.setString(6, "0.25");
            cstmt.setString(7, "0.25");
            cstmt.setString(8, "0.25");
            cstmt.setString(9, "0.25");
            //Retorno
            cstmt.registerOutParameter(10, OracleTypes.NUMBER);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(1);

            if (cstmt.getLong(10)!=1){
                throw new SQLException("Retorno da procedure de similaridade diferente de 1 valor: "+cstmt.getLong(1));
            }

            AtributosBuscaSimilaridade regSimilaridade=new AtributosBuscaSimilaridade();

            while(rs.next()){
                regSimilaridade.setSimilaridade(rs.getDouble(1));
                System.out.println(rs.getDouble(1));
                regSimilaridade.setCd_objeto(rs.getLong(2));
                regSimilaridade.setTp_estrutura(rs.getString(3));
                regSimilaridade.setNm_objeto(rs.getString(4));
                regSimilaridade.setContexto(rs.getString(5));
                regSimilaridade.setProblema(rs.getString(6));
                regSimilaridade.setSolucao(rs.getString(7));

                retorno.add(regSimilaridade);
            }


            cstmt.close();
            rs.close();
                        
            return retorno;
            
        } catch (SQLException e) {
            GravarLog.gravaErro(GenericDAO.class.getName() + ": erro ao pesquisar o nome da tabela: " + e.getMessage() + " : " + e.getSQLState() + " : " + e.getLocalizedMessage());
            return null;
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
            GravarLog.gravaErro(LoginDAO.class.getName() + ": erro ao finalizar conexao com o banco: " + e.getMessage());
        }
    }
}
