/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author Andrey
 */
public class Cidade {

    private long cd_cidade;
    private String nm_cidade;
    private String nm_abrev;
    private long cd_estado;

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

    public String getNm_abrev() {
        return nm_abrev;
    }

    public void setNm_abrev(String nm_abrev) {
        this.nm_abrev = nm_abrev;
    }

    public String getNm_cidade() {
        return nm_cidade;
    }

    public void setNm_cidade(String nm_cidade) {
        this.nm_cidade = nm_cidade;
    }

    

}
