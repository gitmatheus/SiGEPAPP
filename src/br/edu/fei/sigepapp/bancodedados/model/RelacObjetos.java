package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 20, 2009
 */
public class RelacObjetos {

    private long cd_relac;
    private long cd_obj_relacionado;
    private long cd_obj_relacionando;
    private long cd_atributo_obj;
    private String vl_relac;

    public long getCd_atributo_obj() {
        return cd_atributo_obj;
    }

    public void setCd_atributo_obj(long cd_atributo_obj) {
        this.cd_atributo_obj = cd_atributo_obj;
    }

    public long getCd_obj_relacionado() {
        return cd_obj_relacionado;
    }

    public void setCd_obj_relacionado(long cd_obj_relacionado) {
        this.cd_obj_relacionado = cd_obj_relacionado;
    }

    public long getCd_obj_relacionando() {
        return cd_obj_relacionando;
    }

    public void setCd_obj_relacionando(long cd_obj_relacionando) {
        this.cd_obj_relacionando = cd_obj_relacionando;
    }

    public long getCd_relac() {
        return cd_relac;
    }

    public void setCd_relac(long cd_relac) {
        this.cd_relac = cd_relac;
    }

    public String getVl_relac() {
        return vl_relac;
    }

    public void setVl_relac(String vl_relac) {
        this.vl_relac = vl_relac;
    }

}
