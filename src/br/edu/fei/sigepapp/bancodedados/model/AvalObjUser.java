/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class AvalObjUser {

    long cd_user;
    long cd_obj;

    public AvalObjUser() {
    }

    public AvalObjUser(long cd_user, long cd_obj) {
        this.cd_user = cd_user;
        this.cd_obj = cd_obj;
    }

    public long getCd_obj() {
        return cd_obj;
    }

    public void setCd_obj(long cd_obj) {
        this.cd_obj = cd_obj;
    }

    public long getCd_user() {
        return cd_user;
    }

    public void setCd_user(long cd_user) {
        this.cd_user = cd_user;
    }
    
}
