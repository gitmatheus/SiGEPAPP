package br.edu.fei.sigepapp.bancodedados.model;

public class Resposta {

    private long cd_resposta;
    private String ds_resposta;
    private int nro_peso_resposta;

    public Resposta(long cd_resposta, String ds_resposta) {
        this.cd_resposta = cd_resposta;
        this.ds_resposta = ds_resposta;
    }

    public Resposta() {
        cd_resposta=0;
    } 

    public long getCd_resposta() {
        return cd_resposta;
    }

    public void setCd_resposta(long cd_resposta) {
        this.cd_resposta = cd_resposta;
    }

    public String getDs_resposta() {
        return ds_resposta;
    }

    public void setDs_resposta(String ds_resposta) {
        this.ds_resposta = ds_resposta;
    }

    public int getNro_peso_resposta() {
        return nro_peso_resposta;
    }

    public void setNro_peso_resposta(int nro_peso_resposta) {
        this.nro_peso_resposta = nro_peso_resposta;
    }



}
