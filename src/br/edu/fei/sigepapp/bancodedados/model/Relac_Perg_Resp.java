package br.edu.fei.sigepapp.bancodedados.model;

public class Relac_Perg_Resp {

    private long cd_pergunta;
    private long cd_resposta;
    private long nro_valor_resp;

    public Relac_Perg_Resp() {
        cd_pergunta=0;
        cd_resposta=0;
        nro_valor_resp=0;
    }

    public Relac_Perg_Resp(long cd_pergunta, long cd_resposta, long nro_valor_resp) {
        this.cd_pergunta = cd_pergunta;
        this.cd_resposta = cd_resposta;
        this.nro_valor_resp = nro_valor_resp;
    }

    public long getCd_pergunta() {
        return cd_pergunta;
    }

    public void setCd_pergunta(long cd_pergunta) {
        this.cd_pergunta = cd_pergunta;
    }

    public long getCd_resposta() {
        return cd_resposta;
    }

    public void setCd_resposta(long cd_resposta) {
        this.cd_resposta = cd_resposta;
    }

    public long getNro_valor_resp() {
        return nro_valor_resp;
    }

    public void setNro_valor_resp(long nro_valor_resp) {
        this.nro_valor_resp = nro_valor_resp;
    }


}
