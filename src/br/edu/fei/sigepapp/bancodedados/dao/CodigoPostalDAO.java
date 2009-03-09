package br.edu.fei.sigepapp.bancodedados.dao;

import br.edu.fei.sigepapp.bancodedados.ConnectionFactory;
import br.edu.fei.sigepapp.bancodedados.model.CodigoPostal;
import br.edu.fei.sigepapp.log.GravarLog;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import oracle.jdbc.OracleTypes;

/**
 *
 * @author Andrey
 * @version 0.01 Mar 08, 2009
 */
public class CodigoPostalDAO {

    private Connection conn;

    public CodigoPostalDAO() throws SQLException{
        try{
            this.conn = ConnectionFactory.getConnection();
        }catch(SQLException e){
            GravarLog.gravaErro(CodigoPostalDAO.class.getName() + ": erro ao tentar abrir uma conexão: " + e.getMessage());
        }
    }

    public boolean insere(CodigoPostal codigoPostal){
        try{
            CallableStatement cstmt = this.conn.prepareCall("begin APPP_INS_CODIGO_POSTAL(?,?,?,?,?); end;");
            cstmt.setLong(1, codigoPostal.getCd_cep());
            cstmt.setString(2, codigoPostal.getNm_rua());
            cstmt.setLong(3, codigoPostal.getCd_cidade());
            cstmt.setLong(4, codigoPostal.getCd_estado());
            cstmt.registerOutParameter(5, OracleTypes.NUMBER);
            cstmt.execute();
            
            long cResult = (long) cstmt.getLong(5);
            
            if(cResult == 1){
                cstmt.close();
                return true;
            }else{
                cstmt.close();
                return false;
            }
        }catch(SQLException e){
            return false;
        }
    }

}
