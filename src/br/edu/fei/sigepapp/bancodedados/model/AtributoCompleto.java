/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class AtributoCompleto extends Atributo {
    private String nm_tipo;
    private String t_type;
    private String exp_reg;
    private String fl_exp_reg;

    @Override
    public long getCd_atributo_obj() {
        return super.getCd_atributo_obj();
    }

    @Override
    public void setCd_atributo_obj(long cd_atributo_obj) {
        super.setCd_atributo_obj(cd_atributo_obj);
    }

    @Override
    public long getCd_tipo() {
        return super.getCd_tipo();
    }

    @Override
    public void setCd_tipo(long cd_tipo) {
        super.setCd_tipo(cd_tipo);
    }

    @Override
    public String getDs_atributo_obj() {
        return super.getDs_atributo_obj();
    }

    @Override
    public void setDs_atributo_obj(String ds_atributo_obj) {
        super.setDs_atributo_obj(ds_atributo_obj);
    }

    @Override
    public String getFl_atrib_relac() {
        return super.getFl_atrib_relac();
    }

    @Override
    public void setFl_atrib_relac(String fl_atrib_relac) {

        super.setFl_atrib_relac(fl_atrib_relac);
    }

    @Override
    public String getNm_atributo_obj() {
        return super.getNm_atributo_obj();
    }

    @Override
    public void setNm_atributo_obj(String nm_atributo_obj) {
        super.setNm_atributo_obj(nm_atributo_obj);
    }

    public String getExp_reg() {
        return exp_reg;
    }

    public void setExp_reg(String exp_reg) {
        this.exp_reg = exp_reg;
    }

    public String getFl_exp_reg() {
        return fl_exp_reg;
    }

    public void setFl_exp_reg(String fl_exp_reg) {
        this.fl_exp_reg = fl_exp_reg;
    }

    public String getNm_tipo() {
        return nm_tipo;
    }

    public void setNm_tipo(String nm_tipo) {
        this.nm_tipo = nm_tipo;
    }

    public String getT_type() {
        return t_type;
    }

    public void setT_type(String t_type) {
        this.t_type = t_type;
    }


}
