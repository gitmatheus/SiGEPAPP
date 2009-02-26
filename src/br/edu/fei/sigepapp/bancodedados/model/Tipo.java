/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class Tipo {

    private long cd_tipo;
    private String nm_tipo;
    private String ds_exp_regular;

    public Tipo(){
    }

    public Tipo(long cd_tipo, String nm_tipo, String ds_exp_regular) {
        this.cd_tipo = cd_tipo;
        this.nm_tipo = nm_tipo;
        this.ds_exp_regular = ds_exp_regular;
    }

    public long getCd_tipo() {
        return cd_tipo;
    }

    public void setCd_tipo(long cd_tipo) {
        this.cd_tipo = cd_tipo;
    }

    public String getDs_exp_regular() {
        return ds_exp_regular;
    }

    public void setDs_exp_regular(String ds_exp_regular) {
        this.ds_exp_regular = ds_exp_regular;
    }

    public String getNm_tipo() {
        return nm_tipo;
    }

    public void setNm_tipo(String nm_tipo) {
        this.nm_tipo = nm_tipo;
    }

}
