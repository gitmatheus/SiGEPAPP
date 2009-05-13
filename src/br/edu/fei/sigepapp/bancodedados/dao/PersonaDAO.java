/*
 * @(#)PersonaDAO.java 0.01 15/04/2009
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
 * | Matheus     | 15/04/2009    | Criação e elaboração inicial       |
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

//~-- Sigepapp import ---------------------------------------------------------
import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Estrutura;
import br.edu.fei.sigepapp.bancodedados.model.Persona;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.util.Vector;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author matheus.goncalves
 */
public class PersonaDAO {

    private Connection conn;

    /**
     * Construtor da classe:- cria uma conexao com o banco de dados
     * @throws SQLException
     */
    public PersonaDAO() throws SQLException {
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Persona> PreencheList(ResultSet rs) throws SQLException {
        // Cria um array do tipo Estrutura
        List<Persona> Personas = new ArrayList<Persona>();

        //Cria e preenche uma lista contendo os nomes das colunas da tabela
        Vector<String> camposDaTabela = new Vector<String>();
        camposDaTabela.add("CD_PERSONA");
        camposDaTabela.add("URL_FOTO");
       
        while (rs.next()) {
            // Cria um objeto do tipo Estrutura
            Persona PersonaNovo = new Persona();

            //Para cada coluna
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                //Atribui o nome da coluna atual a variavel nomeColuna
                String nomeColuna = rs.getMetaData().getColumnName(i);
                //retorna o indice que esta coluna se encontra na lista
                int selecao = camposDaTabela.indexOf(nomeColuna);
                //seleciona cada caso de acordo com o indice e atribui ao objeto
                switch (selecao) {
                    case 0:
                        PersonaNovo.setCd_Persona(rs.getLong(i));
                        break;
                    case 1:
                        PersonaNovo.setUrl_Foto(rs.getString(i));
                        break;
                }
            }
            //Adiciona o objeto a lista.
             Personas.add(PersonaNovo);
        }
        //retorna a lista de Personas.
        return Personas;
    }

    public List<Persona> APPP_SEL_PERSONA(Persona PersonaPesquisa) {
        CallableStatement cstmt = null;
        ResultSet rs = null;

        long pCD_Persona = 0;
        String pURL_FOTO = "";
        
        try {
            //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin APPP_SEL_PERSONA(?, ?, ?); end;");

            pCD_Persona = PersonaPesquisa.getCd_Persona();
            pURL_FOTO = PersonaPesquisa.getUrl_Foto();

            if (pCD_Persona > 0) {
                cstmt.setLong(1, pCD_Persona);
            } else {
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(2, pURL_FOTO);

            cstmt.registerOutParameter(3, OracleTypes.CURSOR);
            cstmt.execute();
            rs = (ResultSet) cstmt.getObject(3);

            //Cria um array do tipo Persona
            List<Persona> Personas = PreencheList(rs);

            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Estrutura.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return Personas;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Estrutura.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public long APPP_INS_PERSONA(Persona PersonaAdicionar) {
        CallableStatement cstmt = null;

        try {
            long result = 0;
             //Instancia um objeto da classe PreparedStatement com o comando para pesquisar registros no banco
            //PreparedStatement stmt = this.conn.prepareStatement(query);

            cstmt = conn.prepareCall("begin APPP_INS_PERSONA(?, ?, ?); end;");
            
            cstmt.setLong(1, PersonaAdicionar.getCd_Persona());
            cstmt.setString(2, PersonaAdicionar.getUrl_Foto());
            cstmt.registerOutParameter(3, OracleTypes.NUMBER);

            cstmt.execute();
            result = cstmt.getLong(3);

            //fecha a instancia dos objetos
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(Persona.class.getName() + ": Insercao no banco de dados realizada com sucesso");

            //retorna uma lista com os usuarios selecionados
            return result;

        } catch (SQLException e) {

            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(Persona.class.getName() + ": erro na Insercao referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return -1;
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
            GravarLog.gravaErro(PersonaDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }
}
