/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

public class AntiPattern {

    public AntiPattern() {
    }

    public AntiPattern(long cd_AntiPattern, String ds_Sintomas, String ds_Recomendacoes, String ds_Consequencias, String ds_Barreiras) {

        setCd_AntiPattern(cd_AntiPattern);
        setDs_Barreiras(ds_Barreiras);
        setDs_Consequencias(ds_Consequencias);
        setDs_Recomendacoes(ds_Recomendacoes);
        setDs_Sintomas(ds_Sintomas);
        
    }

    private long cd_AntiPattern;
    private String ds_Sintomas;
    private String ds_Recomendacoes;
    private String ds_Consequencias;
    private String ds_Barreiras;
    
    public void setCd_AntiPattern(long cd_AntiPattern) {
        this.cd_AntiPattern = cd_AntiPattern;
    }

    public void setDs_Sintomas(String ds_sintomas) {
        this.ds_Sintomas = ds_sintomas;
    }

    public void setDs_Recomendacoes(String ds_recomendacoes) {
        this.ds_Recomendacoes = ds_recomendacoes;
    }
    
    public void setDs_Consequencias(String ds_consequencias) {
        this.ds_Consequencias = ds_consequencias;
    }

    public void setDs_Barreiras(String ds_barreiras) {
        this.ds_Barreiras = ds_barreiras;
    }
    
    public long getCd_AntiPattern(){
        return this.cd_AntiPattern;
    }
    
    public String getDs_Barreiras(){
        return this.ds_Barreiras ;
    }
    public String getDs_Consequencias(){
        return this.ds_Consequencias ;
    }
    public String getDs_Recomendacoes(){
        return this.ds_Recomendacoes ;
    }
    public String getDs_Sintomas(){
        return this.ds_Sintomas ;
    }
}
