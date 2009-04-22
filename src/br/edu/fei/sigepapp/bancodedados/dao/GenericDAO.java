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
import br.edu.fei.sigepapp.log.GravarLog;

/**
 *
 * @author Andrey
 * @version 0.01 15 Abr 2009
 */
public class GenericDAO {

    private Connection conn;
    private boolean erro = false;
    private long cd_estrutura;

    /**
     * Contrutor da classe:- cria uma conexão com o banco de dados
     *
     * @throws SQLException
     */
    public GenericDAO() throws SQLException{

        this.conn = ConnectionFactory.getConnection();
        
    }

    public long insertData(String strValores[], String strAtributos[]){
        try{
            int i = 0, tamVetorOracle = 0;
            for (int j=4; j < strAtributos.length;j++){
                tamVetorOracle++;
            }
            String strAtribOracle[] = new String[tamVetorOracle - 4];
            String strVlrAtribOracle[] = new String[tamVetorOracle - 4];
            boolean erroBuscaAtrib = false;

            for (int j = 4; j < strAtributos.length; j++){
                strVlrAtribOracle[i] = strAtributos[j];
                i++;
            }

            insereTabelaEstrutura(strValores, strAtributos);
            if(erro){
                GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro na rotina de inserção na tabela de estrutura.");
                return 4;
            }

            CallableStatement cstmt = this.conn.prepareCall("begin APPP_EXEC_MANIP_GENERICA(?,?,?,?,?,?); end;");

            String nm_tabela = new String();

            nm_tabela = buscaNomeTabela(this.cd_estrutura);

            if(nm_tabela.equals("")){
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": nome da tabela nao encontrado.");
                return 3;
            }else{
                cstmt.setString(1, nm_tabela);
            }
            cstmt.setString(2, "INS"); //Parametro fixo para que a proccedure possa saber que é uma operação de inserção no BD

            // Constroi o vetor com o tipo dos atributos
            for (int j = 4; j < strAtributos.length && !erroBuscaAtrib; j++){
                String temp = buscaTipoAtributo(strAtributos[j]);
                if (temp.equals("")){
                    erroBuscaAtrib = true;
                }else{
                    strAtribOracle[i] = temp;
                }
            }

            if (erroBuscaAtrib){
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": problemas ao montar vetor de tipos de atributos.");
                return 5;
            }

            cstmt.setObject(3, strVlrAtribOracle);
            cstmt.setObject(4, strAtribOracle);
            cstmt.registerOutParameter(5, OracleTypes.NUMBER);
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);

            cstmt.execute();

            int cResult = (int) cstmt.getInt(5);

            cstmt.close();

            if (cResult == 1){
                GravarLog.gravaInformacao(GenericDAO.class.getName() + ": inserção efetuada com sucesso");
                return 1;
            }
            else{
                GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro no banco de dados durante a operação de inserção : erro " + cResult);
                return 2;
            }
            
        }catch (SQLException e){
            GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro durante a inserção de dados : " + e.getMessage() + " : " + e.getSQLState());
            return 0;
        }
    }

    public void insereTabelaEstrutura(String strValores[], String strAtributos[]){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_ESTRUT_OBJ(?,?,?,?,?); end;");

            cstmt.registerOutParameter(1, OracleTypes.NUMBER);
            cstmt.registerOutParameter(6, OracleTypes.NUMBER);

            for (int i=0;i<4;i++){
                if(strAtributos[i].equals("NM_ESTRUTURA")){
                    cstmt.setString(2, strValores[i]);
                }else{
                    if(strAtributos[i].equals("DS_ESTRUTURA")){
                        cstmt.setString(3, strValores[i]);
                    }else{
                        if(strAtributos[i].equals("CD_USER")){
                            cstmt.setLong(4, Long.parseLong(strValores[i]));
                        }else{
                            if(strAtributos[i].equals("TP_ESTRUTURA")){
                                cstmt.setString(5,strValores[i]);
                            }
                        }
                    }
                }
            }

            cstmt.execute();

            int pCD_ESTRUTURA = (int) cstmt.getLong(1);
            int cResult = (int) cstmt.getLong(6);

            cstmt.close();

            if (pCD_ESTRUTURA < 1){
                this.erro = true;
                GravarLog.gravaErro(GenericDAO.class.getName() + ": código da estrutura é nulo.");
            }else{
                this.erro = false;
                this.cd_estrutura = pCD_ESTRUTURA;
                GravarLog.gravaInformacao(GenericDAO.class.getName() + ": código da estrutura gerado com sucesso.");
            }

            if (cResult != 1){
                this.erro = true;
                GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro no banco de dados durante a operação de inserção da estrutura : erro " + cResult);
            }
        }catch(SQLException e){
            GravarLog.gravaErro(GenericDAO.class.getName() + ": ocorreu um erro durante a inserção de dados da estrutura: " + e.getMessage() + " : " + e.getSQLState());
            this.erro = true;
        }
    }

    public String buscaNomeTabela(long cod_estr){
        try{

            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_ESTRUT_OBJ(?,?,?,?,?,?,?,?); end;");
            cstmt.setLong(1, cod_estr);
            cstmt.setNull(2, OracleTypes.VARCHAR);
            cstmt.setNull(3, OracleTypes.VARCHAR);
            cstmt.setNull(4, OracleTypes.DATE);
            cstmt.setNull(5, OracleTypes.DATE);
            cstmt.setNull(6, OracleTypes.NUMBER);
            cstmt.setNull(7,OracleTypes.VARCHAR);
            cstmt.registerOutParameter(8, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(8);

            int tamResultSet = 0;
            while (rs.next()){
                tamResultSet++;
            }

            cstmt.close();

            if (tamResultSet != 1){
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": numero de linhas encontradas não esperadas : Nro: " + tamResultSet);
                return "";
            }else{
                String s = rs.getString("NM_TB_ESTRUT");
                rs.close();
                return s;
            }
        }catch(SQLException e){
            GravarLog.gravaErro(GenericDAO.class.getName() + ": erro ao pesquisar o nome da tabela: " + e.getMessage() + " : " + e.getSQLState());
            return "";
        }
    }

    public String buscaTipoAtributo(String str){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_ATRIBUTO_OBJ(?,?,?,?,?,?); end;");
            cstmt.setNull(1, OracleTypes.NUMBER);
            cstmt.setString(2, str);
            cstmt.setNull(3, OracleTypes.VARCHAR);
            cstmt.setNull(4, OracleTypes.NUMBER);
            cstmt.setNull(5, OracleTypes.NUMBER);
            cstmt.registerOutParameter(6, OracleTypes.CURSOR);
            
            cstmt.execute();
            
            ResultSet rs = (ResultSet) cstmt.getObject(6);

            int tamResultSet = 0;
            while(rs.next()){
                tamResultSet++;
            }

            if (tamResultSet != 1){
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": buscaTipoAtributo : numero de linhas encontradas não esperadas : Nro: " + tamResultSet);
                return "";
            }

            long pCD_TIPO_ATRIBUTO = rs.getLong("CD_TIPO");
            
            cstmt = this.conn.prepareCall("begin APPP_SEL_TIPO(?,?,?,?,?); end;");
            cstmt.setLong(1, pCD_TIPO_ATRIBUTO);
            cstmt.setNull(2, OracleTypes.VARCHAR);
            cstmt.setNull(3, OracleTypes.VARCHAR);
            cstmt.setNull(4, OracleTypes.VARCHAR);
            cstmt.registerOutParameter(5, OracleTypes.CURSOR);

            cstmt.execute();

            rs = (ResultSet) cstmt.getObject(5);
            tamResultSet = 0;

            while(rs.next()){
                tamResultSet++;
            }

            cstmt.close();

            if (tamResultSet != 1){
                GravarLog.gravaAlerta(GenericDAO.class.getName() + ": buscaTipoAtributo : Tipo : numero de linhas encontradas não esperadas : Nro: " + tamResultSet);
                return "";
            }else{
                String s = rs.getString("NM_TIPO");
                rs.close();
                return s;
            }

        }catch(SQLException e){
            GravarLog.gravaErro(GenericDAO.class.getName() + ": erro ao pesquisar o tipo do atributo: " + e.getMessage() + " : " + e.getSQLState());
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
