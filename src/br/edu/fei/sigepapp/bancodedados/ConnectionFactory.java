package br.edu.fei.sigepapp.bancodedados;

/*
 * @(#)ConnectionFactory.java 0.01 15/02/09
 *
 * Este c�digo � parte integrante do projeto de formatura,
 * do curso de ci�ncias da computa��o, do Centro Universit�rio da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * ATEN��O:
 * Para essa classe se conectar com o banco de dados � necess�rio modificar o
 * arquivo context.xml e web.xml de sua aplica��o da seguinte forma:
 *
 * context.xml (Dentro da tag: <Context>) 
 * (diret�rio onde o arquivo � encontrado: %CATALINA_HOME%\conf)
 *    </resource-ref>
 *    <Resource name="jdbc/sigepapp" auth="Application"
 *    type="javax.sql.DataSource" driverClassName="oracle.jdbc.OracleDriver"
 *    url="jdbc:oracle:thin:@127.0.0.1:1521"
 *    username="system" password="<SENHA DO BANCO>" maxActive="20" maxIdle="10"
 *    maxWait="-1"/>
 *
 * web.xml  (Dentro da tag: <web-app>)
 *    <resource-ref>
 *    <description>Oracle Datasource example</description>
 *    <res-ref-name>jdbc/sigepapp</res-ref-name>
 *    <res-type>javax.sql.DataSource</res-type>
 *    <res-auth>Container</res-auth>
 * 
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 15/02/09    | Cria��o e elabora��o inicial         |
 * |------------------------------------------------------------------|
 * | Andrey      | 19/02/09    | Altera��o do m�todo de conex�o com o |
 * |             |             | Banco de Dados, para uma Factory de  |
 * |             |             | Conex�o.                             |
 * |------------------------------------------------------------------|
 * 
 */
import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
/**
*
* Classe respons�vel pela conex�o com banco de dados ORACLE 10g Express Edition
*
*<p>
*  <b>Para usar essa classe, sua aplica��o deve estar configurada corretamente.
* Olhar cabe�alho do arquivo para maiores informa��es.</b>
*</p>
* @author Guilherme Wachs Lopes
* @version 0.01 15 Fev 2009 
*/
public class ConnectionFactory {
	/**
	 * @return Retorna a conex�o com o banco de dados
	 * @throws SQLException
	 */
    
	public static Connection getConnection() throws SQLException{
		try{
			// Tenta ler o contexto para encontrar o banco de dados do sigepapp.
            Context initContext = new InitialContext();
            // Seta o DataSource ds com o jndi sigepapp.
            DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/sigepapp");
            
            // Retorna a conex�o com o banco de dados.
            
            return ds.getConnection();
		}catch (Exception e){
			// Lanca um Exception caso ocorra algum erro.
			throw new SQLException(e.getMessage());
		}
	}
    /*public static Connection getConnection() throws SQLException{
		try{
			// Tenta ler o contexto para encontrar o banco de dados do sigepapp.

            // Seta o DataSource ds com o jndi sigepapp.
            Class.forName("oracle.jdbc.OracleDriver");
            return DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","admin");


            // Retorna a conex�o com o banco de dados.

            
		}catch (Exception e){
			// Lan�a um Exception caso ocorra algum erro.
			throw new SQLException(e.getMessage());
		}
    }*/
}
