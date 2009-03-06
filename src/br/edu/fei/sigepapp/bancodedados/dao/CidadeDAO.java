package br.edu.fei.sigepapp.bancodedados.dao;
/*
 * @(#)CidadeDAO.java 0.01 06/03/09
 *
 * Este codigo e parte integrante do projeto de formatura,
 * do curso de ciencias da computacao, do Centro Universitario da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificacoes no Codigo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descricao                          |
 * |------------------------------------------------------------------|
 * |   Andrey    | 06/03/09    | Criacao e elaboracao inicial         |
 * |------------------------------------------------------------------|
 *
 */

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Cidade;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Andrey
 * @version 0.01 Mar 06, 2009
 */
public class CidadeDAO {

    private Connection conn;

    public CidadeDAO() throws SQLException{
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Cidade> APPP_SEL_CIDADE(Cidade cidade){
        long pCD_CIDADE = 0;
        long pCD_ESTADO = 0;
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_CIDADE(? ,? ,? ,? ,?); end;");

            pCD_CIDADE = cidade.getCd_cidade();
            pCD_ESTADO = cidade.getCd_estado();

            if (pCD_CIDADE>0){
                cstmt.setLong(1, pCD_CIDADE);
            }else{
                cstmt.setNull(1, OracleTypes.NUMBER);
            }

            if (pCD_ESTADO>0){
                cstmt.setLong(4, pCD_ESTADO);
            }else{
                cstmt.setNull(4, OracleTypes.NUMBER);
            }

            cstmt.setString(2, cidade.getNm_cidade());
            cstmt.setString(3, cidade.getNm_abrev());
            cstmt.registerOutParameter(5, OracleTypes.CURSOR);

            ResultSet rs = (ResultSet) cstmt.getObject(5);

            List<Cidade> cidades = new ArrayList<Cidade>();

            while(rs.next()){
                Cidade c = new Cidade();

                c.setCd_cidade(rs.getLong("cd_cidade"));
                c.setNm_cidade(rs.getString("nm_cidade"));
                c.setNm_abrev(rs.getString("nm_abrev"));
                c.setCd_estado(rs.getLong("cd_estado"));

                cidades.add(c);
            }
            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(CidadeDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return cidades;

        }catch(SQLException e){
            //Grava log com o erro que ocorreu durante a execução do comando SQL
            GravarLog.gravaErro(EstadoDAO.class.getName() + ": erro na pesquisa referente a uma exceção de SQL: " + e.getMessage());

            //Retorno da função como null em caso de erro
            return null;
        }
    }

    public void fechaConexao(){
        try {
            if (!this.conn.isClosed()) {
                this.conn.close();
            }
        } catch (SQLException e) {
            GravarLog.gravaErro(CidadeDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }

}
