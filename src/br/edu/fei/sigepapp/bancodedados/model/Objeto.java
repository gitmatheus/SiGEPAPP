package br.edu.fei.sigepapp.bancodedados.model;

import java.util.Date;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 11, 2009
 */
public class Objeto {

    private long cd_objeto;
    private String nm_objeto;
    private long cd_estrutura;
    private String ds_objeto;
    private Date dt_criacao;
    private long cd_user_criacao;
    private long fl_ativo;

    public long getCd_estrutura() {
        return cd_estrutura;
    }

    public void setCd_estrutura(long cd_estrutura) {
        this.cd_estrutura = cd_estrutura;
    }

    public long getCd_objeto() {
        return cd_objeto;
    }

    public void setCd_objeto(long cd_objeto) {
        this.cd_objeto = cd_objeto;
    }

    public long getCd_user_criacao() {
        return cd_user_criacao;
    }

    public void setCd_user_criacao(long cd_user_criacao) {
        this.cd_user_criacao = cd_user_criacao;
    }

    public String getDs_objeto() {
        return ds_objeto;
    }

    public void setDs_objeto(String ds_objeto) {
        this.ds_objeto = ds_objeto;
    }

    public Date getDt_criacao() {
        return dt_criacao;
    }

    public void setDt_criacao(Date dt_criacao) {
        this.dt_criacao = dt_criacao;
    }

    public long getFl_ativo() {
        return fl_ativo;
    }

    public void setFl_ativo(long fl_ativo) {
        this.fl_ativo = fl_ativo;
    }

    public String getNm_objeto() {
        return nm_objeto;
    }

    public void setNm_objeto(String nm_objeto) {
        this.nm_objeto = nm_objeto;
    }

}
