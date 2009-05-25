package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 12, 2009
 */
public class Pattern extends Objeto {

    public Pattern() {
    }

    public Pattern(long cd_pattern,
            String ds_pat_problema,
            String ds_pat_solucao) {

        setCd_Pattern(cd_pattern);
        setDs_Pat_problema(ds_pat_problema);
        setDs_Pat_solucao(ds_pat_solucao);

    }
    private long cd_Pattern;
    private String ds_Pat_problema;
    private String ds_Pat_solucao;

    public long getCd_Pattern() {
        return cd_Pattern;
    }

    public void setCd_Pattern(long cd_Pattern) {
        this.cd_Pattern = cd_Pattern;
    }

    public String getDs_Pat_problema() {
        return ds_Pat_problema;
    }

    public void setDs_Pat_problema(String ds_Pat_problema) {
        this.ds_Pat_problema = ds_Pat_problema;
    }

    public String getDs_Pat_solucao() {
        return ds_Pat_solucao;
    }

    public void setDs_Pat_solucao(String ds_Pat_solucao) {
        this.ds_Pat_solucao = ds_Pat_solucao;
    }
}
