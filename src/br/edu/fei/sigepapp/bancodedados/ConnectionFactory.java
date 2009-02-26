package br.edu.fei.sigepapp.bancodedados;

/*
 * @(#)ConnectionFactory.java 0.01 15/02/09
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
 * (diretório onde o arquivo é encontrado: %CATALINA_HOME%\conf)
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
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 15/02/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 * | Andrey      | 19/02/09    | Alteração do método de conexão com o |
 * |             |             | Banco de Dados, para uma Factory de  |
 * |             |             | Conexão.                             |
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
* Classe responsável pela conexão com banco de dados ORACLE 10g Express Edition
*
*<p>
*  <b>Para usar essa classe, sua aplicação deve estar configurada corretamente.
* Olhar cabeçalho do arquivo para maiores informações.</b>
*</p>
* @author Guilherme Wachs Lopes
* @version 0.01 15 Fev 2009 
*/
public class ConnectionFactory {
	/**
	 * @return Retorna a conexão com o banco de dados
	 * @throws SQLException
	 */
	public static Connection getConnection() throws SQLException{
		try{
			// Tenta ler o contexto para encontrar o banco de dados do sigepapp.
            Context initContext = new InitialContext();
            // Seta o DataSource ds com o jndi sigepapp.
            DataSource ds = (DataSource) initContext.lookup("java:/comp/env/jdbc/sigepapp");
            // Retorna a conexão com o banco de dados.
            return ds.getConnection();
		}catch (Exception e){
			// Lança um Exception caso ocorra algum erro.
			throw new SQLException(e.getMessage());
		}
	}

}