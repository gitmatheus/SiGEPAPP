package br.edu.fei.sigepapp.bancodedados;

/*
 * @(#)ConexaoBanco.java 0.1 15/02/09
 *
 * Este código é parte integrante do projeto de formatura,
 * do curso de ciências da computação, do Centro Universitário da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * ATENÇÃO:
 * Para essa classe se conectar com o banco de dados é necessário modificar o
 * arquivo context.xml e web.xml de sua aplicação da seguinte forma:
 *
 * context.xml (Dentro da tag: <Context>)
 *    </resource-ref>
 *    <Resource name="jdbc/sigepapp" auth="Application"
 *    type="javax.sql.DataSource" driverClassName="oracle.jdbc.OracleDriver"
 *    url="jdbc:oracle:thin:@127.0.0.1:1521"
 *    username="system" password="<SENHA DO BANCO>" maxActive="20" maxIdle="10"
 *    maxWait="-1"/>
 *
 * web.xml  (Dentro da tag: <web-app>)
 * 
 *       <resource-ref>
 *       <description>Oracle Datasource example</description>
 *       <res-ref-name>jdbc/sigepapp</res-ref-name>
 *       <res-type>javax.sql.DataSource</res-type>
 *       <res-auth>Container</res-auth>
 * 
 *
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * | Guilherme   | 15/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 */
//~--- JDK imports ------------------------------------------------------------
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


/**
 *
 * Classe responsável pelo gerenciamento da conexão e execução de comandos SQL
 * com banco de dados ORACLE versão 10
 *<p>
 *  <b>Para usar essa classe, sua aplicação deve estar configurada corretamente.
 * Olhar cabeçalho do arquivo ConexaoBanco.java para maiores informações.</b>
 *</p>
 * @author Guilherme Wachs Lopes
 *@version 0.01 15 FEV 2009
 */
public class ConexaoBanco{

    private Statement stSQL = null;
    private String status = "Não Conectado";
    private Connection conn;

    /**
     * Construtor padrão da classe
     */
    public ConexaoBanco() {


        try {

            // Tenta ler o contexto para encontrar o banco de dados do sigepapp
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");

            // Seta o DataSource ds com o jndi sigepapp
            DataSource ds = (DataSource) envContext.lookup("jdbc/sigepapp");

            // pega a conexão
            conn = ds.getConnection();

            // seta o status da classe como conectado
            status = "Conectado!";

            // cria o statement do objeto
            stSQL = conn.createStatement();
        } catch (Exception e) {
            // seta o status com o erro
            status = "Erro na conexão: " + e.getMessage();
        }
    }

    /**
     * @return O status da conexão<ul>
     * <li><i>Conectado!</i> Conectado com sucesso</li>
     * <li><i>Não conectado:</i> Banco não conectado</li>
     * <li><i>Erro:</i> Exibe qual função deu erro e a descrição</li>
     * </ul>
     */
    public String getStatus() {


        return status;
    }

    /**
     * @return A conexão em aberto. Retorna NULL caso esteja fechada
     *
     */
    public Connection getConn() {
        return conn;
        
    }

    /**
     * @param cmdSQL Comando SQL à ser consultado.Esse comando só pode ser do tipo select
     * @return Executa um comando de consulta SQL e retorna um ResultSet
     */
    public ResultSet ConsultaSQL(String cmdSQL) {


        ResultSet rsResultado = null;

        try {

            // Tenta executar o comando SQL. Caso aconteça algum problema seta
            // a variável status como erro
            rsResultado = stSQL.executeQuery(cmdSQL);
        } catch (SQLException ex) {
            status = "Erro em ConsultaSQL: " + ex.getMessage() + "\nErro SQL: " + ex.getSQLState();
        }

        return rsResultado;
    }

    /**
     * Executa um comando SQL no banco
     * @param cmdSQL Comando SQL à ser executado.<b>Atenção: Não pode ser um cláusula "SELECT"</b>
     * @return true se a instrução foi executada com sucesso.
     */
    public boolean ExecutaSQL(String cmdSQL) {


        boolean bSucesso = false;

        try {
            bSucesso = stSQL.execute(cmdSQL);
        } catch (SQLException ex) {
            status = "Erro em ExecutaSQL: " + ex.getMessage() + "\nErro SQL: " + ex.getSQLState();
        }

        return bSucesso;
    }

}

