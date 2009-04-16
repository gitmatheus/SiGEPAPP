/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

public class Pattern {

    public Pattern() {
    }

    public Pattern(long cd_pattern       , 
                   String nm_objeto      ,
                   long cd_estrutura     ,
                   String ds_objeto      ,
                   long cd_user_criador  ,
                   String ds_pat_problema, 
                   String ds_pat_solucao ) {

        setCd_Pattern(cd_pattern);
        setDs_Pat_problema(ds_pat_problema);
        setDs_Pat_solucao(ds_pat_solucao);
        setCd_Estrutura(cd_estrutura);
        setCd_User_Criador(cd_user_criador);
        setDs_Objeto(ds_objeto);
        setNm_Objeto(nm_objeto);
    }

    private long cd_Estrutura;
    private long cd_Pattern;
    private long cd_User_criador;
    private String ds_Pat_problema;
    private String ds_Pat_solucao;
    private String nm_Objeto;
    private String ds_Objeto;    
    
    public void setCd_Pattern(long cd_pattern) {
        this.cd_Pattern = cd_pattern;
    }
    
    public void setCd_Estrutura(long cd_estrutura){
        this.cd_Estrutura = cd_estrutura;
    }
     
    public void setCd_User_Criador(long cd_user_criador){
        this.cd_User_criador = cd_user_criador;
    }
    
    public void setDs_Pat_problema(String ds_pat_problema) {
        this.ds_Pat_problema = ds_pat_problema;
    }

    public void setDs_Pat_solucao(String ds_pat_solucao) {
        this.ds_Pat_solucao = ds_pat_solucao;
    }
    
    public void setNm_Objeto(String nm_objeto){
        this.nm_Objeto = nm_objeto;
    }
    
    public void setDs_Objeto(String ds_objeto){
        this.ds_Objeto = ds_objeto;
    }
    
    public long getCd_pattern(){
        return this.cd_Pattern;
    }
    
    public String getDs_pat_problema(){
        return this.ds_Pat_problema;
    }
    public String getDs_pat_solucao(){
        return this.ds_Pat_solucao;
    }
    
    public long getCd_Estrutura(){
        return this.cd_Estrutura;
    }
    
    public long getCd_User_criador(){
        return this.cd_User_criador;
    }
    
    public String getNm_Objeto(){
        return this.nm_Objeto;
    }
    
    public String getDs_Objeto(){
        return this.ds_Objeto;
    }
    
}
