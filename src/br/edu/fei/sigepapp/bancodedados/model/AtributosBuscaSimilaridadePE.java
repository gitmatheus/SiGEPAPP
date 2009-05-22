/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class AtributosBuscaSimilaridadePE {

    long cd_objeto;
    double similaridade;
    String nm_objeto;
    String ds_objeto;

    public AtributosBuscaSimilaridadePE() {
    }

    public AtributosBuscaSimilaridadePE(long cd_objeto, double similaridade, String nm_objeto, String ds_objeto) {
        this.cd_objeto = cd_objeto;
        this.similaridade = similaridade;
        this.nm_objeto = nm_objeto;
        this.ds_objeto = ds_objeto;
    }



    public long getCd_objeto() {
        return cd_objeto;
    }

    public void setCd_objeto(long cd_objeto) {
        this.cd_objeto = cd_objeto;
    }

    public String getDs_objeto() {
        return ds_objeto;
    }

    public void setDs_objeto(String ds_objeto) {
        this.ds_objeto = ds_objeto;
    }

    public String getNm_objeto() {
        return nm_objeto;
    }

    public void setNm_objeto(String nm_objeto) {
        this.nm_objeto = nm_objeto;
    }

    public double getSimilaridade() {
        return similaridade;
    }

    public void setSimilaridade(double similaridade) {
        this.similaridade = similaridade;
    }


}
