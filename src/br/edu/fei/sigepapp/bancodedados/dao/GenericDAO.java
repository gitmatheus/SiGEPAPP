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
import br.edu.fei.sigepapp.servlet.CadUsuarioServlet;
import com.sun.net.ssl.internal.ssl.Debug;
import java.sql.Date;
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
