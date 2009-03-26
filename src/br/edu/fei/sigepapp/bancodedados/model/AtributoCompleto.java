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
