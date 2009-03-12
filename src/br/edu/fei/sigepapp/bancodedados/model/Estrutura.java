package br.edu.fei.sigepapp.bancodedados.model;

import java.sql.Date;

/**
 *
 * @author lopespt
 */
public class Estrutura {

    public Estrutura() {
    }

    public Estrutura(long cd_estrutura, String nm_estrutura, String ds_estrutura, Date dt_criacao, long cod_user, String tp_estrutura) {
        setCd_estrutura(cd_estrutura);
        setNm_estrutura(nm_estrutura);
        setDs_estrutura(ds_estrutura);
        setDt_criacao(dt_criacao);
        setCod_user(cod_user);
        setTp_estrutura(tp_estrutura);
    }

    private long cd_estrutura;
    private String nm_estrutura;
    private String ds_estrutura;
    private Date dt_criacao;
    private long cod_user;
    private String tp_estrutura;

    public long getCd_estrutura() {
        return cd_estrutura;
    }

    public void setCd_estrutura(long cd_estrutura) {
        this.cd_estrutura = cd_estrutura;
    }

    public long getCod_user() {
        return cod_user;
    }

    public void setCod_user(long cod_user) {
        this.cod_user = cod_user;
    }

    public String getDs_estrutura() {
        return ds_estrutura;
    }

    public void setDs_estrutura(String ds_estrutura) {
        this.ds_estrutura = ds_estrutura;
    }

    public Date getDt_criacao() {
        return dt_criacao;
    }

    public void setDt_criacao(Date dt_criacao) {
        this.dt_criacao = dt_criacao;
    }

    public String getNm_estrutura() {
        return nm_estrutura;
    }

    public void setNm_estrutura(String nm_estrutura) {
        this.nm_estrutura = nm_estrutura;
    }

    public String getTp_estrutura() {
        return tp_estrutura;
    }

    public void setTp_estrutura(String tp_estrutura) {
        this.tp_estrutura = tp_estrutura;
    }
}
