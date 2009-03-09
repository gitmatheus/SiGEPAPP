package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author Andrey
 * @version 0.01 Mar 08, 2009
 */
public class CodigoPostal {

    private long cd_cep;
    private String nm_rua;
    private long cd_cidade;
    private long cd_estado;

    public long getCd_cep() {
        return cd_cep;
    }

    public void setCd_cep(long cd_cep) {
        this.cd_cep = cd_cep;
    }

    public long getCd_cidade() {
        return cd_cidade;
    }

    public void setCd_cidade(long cd_cidade) {
        this.cd_cidade = cd_cidade;
    }

    public long getCd_estado() {
        return cd_estado;
    }

    public void setCd_estado(long cd_estado) {
        this.cd_estado = cd_estado;
    }

    public String getNm_rua() {
        return nm_rua;
    }

    public void setNm_rua(String nm_rua) {
        this.nm_rua = nm_rua;
    }

    

}
