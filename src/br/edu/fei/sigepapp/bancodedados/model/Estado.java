package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author Andrey
 * @version 0.01 Mar 16, 2009
 */
public class Estado {

    private long cd_estado;
    private String nm_estado;
    private String sg_sigla;

    public long getCd_estado() {
        return cd_estado;
    }

    public void setCd_estado(long cd_estado) {
        this.cd_estado = cd_estado;
    }

    public String getNm_estado() {
        return nm_estado;
    }

    public void setNm_estado(String nm_estado) {
        this.nm_estado = nm_estado;
    }

    public String getSg_sigla() {
        return sg_sigla;
    }

    public void setSg_sigla(String sg_sigla) {
        this.sg_sigla = sg_sigla;
    }
}
