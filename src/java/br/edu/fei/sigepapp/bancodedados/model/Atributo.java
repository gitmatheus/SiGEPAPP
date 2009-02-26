/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class Atributo {

    private long cd_atributo_obj;
    private String nm_atributo_obj;
    private String ds_atributo_obj;
    private String ds_tam_atrib;
    private long cd_tipo;
    private String fl_atrib_relac;

    public Atributo(){
        
    };

    public Atributo(long cd_atributo_obj, String nm_atributo_obj, String ds_atributo_obj, String ds_tam_atrib, long cd_tipo, String fl_atrib_relac) {
        this.cd_atributo_obj = cd_atributo_obj;
        this.nm_atributo_obj = nm_atributo_obj;
        this.ds_atributo_obj = ds_atributo_obj;
        this.ds_tam_atrib = ds_tam_atrib;
        this.cd_tipo = cd_tipo;
        this.fl_atrib_relac = fl_atrib_relac;
    }

    public long getCd_atributo_obj() {
        return cd_atributo_obj;
    }

    public void setCd_atributo_obj(long cd_atributo_obj) {
        this.cd_atributo_obj = cd_atributo_obj;
    }

    public long getCd_tipo() {
        return cd_tipo;
    }

    public void setCd_tipo(long cd_tipo) {
        this.cd_tipo = cd_tipo;
    }

    public String getDs_atributo_obj() {
        return ds_atributo_obj;
    }

    public void setDs_atributo_obj(String ds_atributo_obj) {
        this.ds_atributo_obj = ds_atributo_obj;
    }

    public String getDs_tam_atrib() {
        return ds_tam_atrib;
    }

    public void setDs_tam_atrib(String ds_tam_atrib) {
        this.ds_tam_atrib = ds_tam_atrib;
    }

    public String getFl_atrib_relac() {
        return fl_atrib_relac;
    }

    public void setFl_atrib_relac(String fl_atrib_relac) {
        this.fl_atrib_relac = fl_atrib_relac;
    }

    public String getNm_atributo_obj() {
        return nm_atributo_obj;
    }

    public void setNm_atributo_obj(String nm_atributo_obj) {
        this.nm_atributo_obj = nm_atributo_obj;
    }
}
