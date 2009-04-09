package br.edu.fei.sigepapp.bancodedados.model;

public class Pergunta {

    public Pergunta(long cd_pergunta, String ds_pergunta) {
        this.cd_pergunta = cd_pergunta;
        this.ds_pergunta = ds_pergunta;
    }

    public Pergunta() {
        cd_pergunta=0;
    }

    

    private long cd_pergunta;
    private String ds_pergunta;

    public long getCd_pergunta() {
        return cd_pergunta;
    }

    public void setCd_pergunta(long cd_pergunta) {
        this.cd_pergunta = cd_pergunta;
    }

    public String getDs_pergunta() {
        return ds_pergunta;
    }

    public void setDs_pergunta(String ds_pergunta) {
        this.ds_pergunta = ds_pergunta;
    }




}
