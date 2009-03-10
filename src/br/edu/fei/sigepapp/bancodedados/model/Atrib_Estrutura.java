/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class Atrib_Estrutura {

    long cd_estrutura;
    long cd_atributo_obj;

    public Atrib_Estrutura() {
    }
    
    public Atrib_Estrutura(long cd_estrutura, long cd_atributo_obj) {
        setCd_atributo_obj(cd_atributo_obj);
        setCd_estrutura(cd_estrutura);
    }


    public long getCd_atributo_obj() {
        return cd_atributo_obj;
    }

    public void setCd_atributo_obj(long cd_atributo_obj) {
        this.cd_atributo_obj = cd_atributo_obj;
    }

    public long getCd_estrutura() {
        return cd_estrutura;
    }

    public void setCd_estrutura(long cd_estrutura) {
        this.cd_estrutura = cd_estrutura;
    }



}
