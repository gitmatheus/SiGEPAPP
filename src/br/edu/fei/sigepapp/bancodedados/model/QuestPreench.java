package br.edu.fei.sigepapp.bancodedados.model;

import java.sql.Date;

public class QuestPreench {

    private long cd_quest_preench;
    private Date dt_aplicacao;
    private long vl_avaliacao;
    private String ds_proj_aplic;
    private long cd_user;
    private long cd_objeto;

    public QuestPreench(long cd_quest_preench, Date dt_aplicacao, long vl_avaliacao, String ds_proj_aplic, long cd_user, long cd_objeto) {
        this.cd_quest_preench = cd_quest_preench;
        this.dt_aplicacao = dt_aplicacao;
        this.vl_avaliacao = vl_avaliacao;
        this.ds_proj_aplic = ds_proj_aplic;
        this.cd_user = cd_user;
        this.cd_objeto = cd_objeto;
    }

    public QuestPreench() {
    }

    public long getCd_objeto() {
        return cd_objeto;
    }

    public void setCd_objeto(long cd_objeto) {
        this.cd_objeto = cd_objeto;
    }

    public long getCd_quest_preench() {
        return cd_quest_preench;
    }

    public void setCd_quest_preench(long cd_quest_preench) {
        this.cd_quest_preench = cd_quest_preench;
    }

    public long getCd_user() {
        return cd_user;
    }

    public void setCd_user(long cd_user) {
        this.cd_user = cd_user;
    }

    public String getDs_proj_aplic() {
        return ds_proj_aplic;
    }

    public void setDs_proj_aplic(String ds_proj_aplic) {
        this.ds_proj_aplic = ds_proj_aplic;
    }

    public Date getDt_aplicacao() {
        return dt_aplicacao;
    }

    public void setDt_aplicacao(Date dt_aplicacao) {
        this.dt_aplicacao = dt_aplicacao;
    }

    public long getVl_avaliacao() {
        return vl_avaliacao;
    }

    public void setVl_avaliacao(long vl_avaliacao) {
        this.vl_avaliacao = vl_avaliacao;
    }
}
