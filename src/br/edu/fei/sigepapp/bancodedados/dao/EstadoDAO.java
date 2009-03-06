package br.edu.fei.sigepapp.bancodedados.dao;
/*
 * @(#)EstadoDAO.java 0.01 05/03/09
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
 * |   Andrey    | 05/03/09    | Criacao e elaboracao inicial         |
 * |------------------------------------------------------------------|
 *
 */

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.Estado;
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
 * @version 0.01 Mar 05, 2009
 */
public class EstadoDAO {

    private Connection conn;

    public EstadoDAO() throws SQLException{
        this.conn = ConnectionFactory.getConnection();
    }

    public List<Estado> APPP_SEL_ESTADO(Estado estado){
        long pCD_ESTADO = 0;
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_SEL_ESTADO(?, ?, ?, ?); end;");
            pCD_ESTADO = estado.getCd_estado();
            if(pCD_ESTADO > 0){
                cstmt.setLong(1, pCD_ESTADO);
            }else{
                cstmt.setNull(1, OracleTypes.NUMBER);
            }
            cstmt.setString(2, estado.getNm_estado());
            cstmt.setString(3, estado.getSg_sigla());
            cstmt.registerOutParameter(4, OracleTypes.CURSOR);

            cstmt.execute();

            ResultSet rs = (ResultSet) cstmt.getObject(4);

            List<Estado> estados = new ArrayList<Estado>();

            while(rs.next()){
                Estado e = new Estado();

                e.setCd_estado(rs.getLong("cd_estado"));
                e.setNm_estado(rs.getString("nm_estado"));
                e.setSg_sigla(rs.getString("sg_sigla"));

                estados.add(e);
            }

            //fecha a instancia dos objetos
            rs.close();
            cstmt.close();

            //Grava log com a informação de sucesso
            GravarLog.gravaInformacao(EstadoDAO.class.getName() + ": pesquisa no banco de dados realizada com sucesso");

            return estados;
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
            GravarLog.gravaErro(EstadoDAO.class.getName() + ": erro ao finalizar connexao com o banco: " + e.getMessage());
        }
    }

}
