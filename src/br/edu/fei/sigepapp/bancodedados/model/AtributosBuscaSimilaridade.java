/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class AtributosBuscaSimilaridade {

    long cd_objeto;
    long similaridade;
    String tp_estrutura;
    String nm_objeto;
    String contexto;
    String problema;
    String solucao;


    public AtributosBuscaSimilaridade() {
    }

    public AtributosBuscaSimilaridade(long cd_objeto, long similaridade,String tp_estrutura, String nm_objeto, String contexto, String problema, String solucao) {
        this.cd_objeto = cd_objeto;
        this.similaridade = similaridade;
        this.tp_estrutura=tp_estrutura;
        this.nm_objeto = nm_objeto;
        this.contexto = contexto;
        this.problema = problema;
        this.solucao = solucao;
    }

    public long getCd_objeto() {
        return cd_objeto;
    }

    public void setCd_objeto(long cd_objeto) {
        this.cd_objeto = cd_objeto;
    }

    public String getContexto() {
        return contexto;
    }

    public void setContexto(String contexto) {
        this.contexto = contexto;
    }

    public String getNm_objeto() {
        return nm_objeto;
    }

    public void setNm_objeto(String nm_objeto) {
        this.nm_objeto = nm_objeto;
    }

    public String getProblema() {
        return problema;
    }

    public void setProblema(String problema) {
        this.problema = problema;
    }

    public long getSimilaridade() {
        return similaridade;
    }

    public void setSimilaridade(long similaridade) {
        this.similaridade = similaridade;
    }

    public String getSolucao() {
        return solucao;
    }

    public void setSolucao(String solucao) {
        this.solucao = solucao;
    }

    public String getTp_estrutura() {
        return tp_estrutura;
    }

    public void setTp_estrutura(String tp_estrutura) {
        this.tp_estrutura = tp_estrutura;
    }
    

}
