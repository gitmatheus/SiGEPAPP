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
import br.edu.fei.sigepapp.bancodedados.model.Objeto;
import br.edu.fei.sigepapp.log.GravarLog;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
    public long insertData(Long codigo_est, Long codigo_user, String strValores[], String strAtributos[]) {
        try {
            String nm_tabela = new String();
            String[] atributos = new String[strAtributos.length - 2];
            String[] valores = new String[strValores.length - 2];

            Objeto objeto = new Objeto();
            objeto.setCd_estrutura(codigo_est);
            objeto.setNm_objeto(strValores[0]);
            objeto.setDs_objeto(strValores[1]);
            objeto.setCd_user_criacao(codigo_user);
            objeto.setFl_ativo(1);

            ObjetoDAO dao = new ObjetoDAO();
            long codigo_obj = dao.insereObjeto(objeto);
            dao.fechaConexao();

            if (codigo_obj > 0) {
                atributos[0] = "NUMBER";
                valores[0] = Long.toString(codigo_obj);
            }else{
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": erro na criação do objeto.");
                return 3;
            }


            CallableStatement cstmt = this.conn.prepareCall("begin APPP_EXEC_MANIP_GENERICA(?,?,?,?,?,?); end;");

            if (atributos.length != valores.length) {
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": vetores de tamanhos diferentes.");
                return 4; //Problemas no tamanho dos vetores
            }

            nm_tabela = buscaNomeTabela(codigo_est);

            if (nm_tabela.equals("")) {
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": nome da tabela nao encontrado.");
                return 5; //Tabela não encontrada
            } else {
                cstmt.setString(1, nm_tabela);
            }
            cstmt.setString(2, "INS"); //Parametro fixo para que a proccedure possa saber que é uma operação de inserção no BD

            // Constroi o vetor com o tipo dos atributos
            //for (int j = 2; j < strAtributos.length; j++) { // <-- oficial tirar comentario apos correcao da proc
            for (int j = 0; j < strAtributos.length; j++) {
                int i = 1;
                atributos[i] = strAtributos[j];
                valores[i] = strValores[j];
                i++;
            }

            cstmt.setObject(3, valores);
            cstmt.setObject(4, atributos);
            cstmt.registerOutParameter(5, OracleTypes.NUMBER);
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);

            cstmt.execute();

            int cResult = (int) cstmt.getInt(5);

            cstmt.close();

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

            cstmt.close();

            if (tamResultSet != 1) {
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": numero de linhas encontradas não esperadas : Nro: " + tamResultSet);
                return "";
            } else {
                rs.close();
                return s;
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(GenericDAO.class.getName() + ": erro ao pesquisar o nome da tabela: " + e.getMessage() + " : " + e.getSQLState() + " : " + e.getLocalizedMessage());
            return "";
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
