/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.edu.fei.sigepapp.bancodedados.model;

public class Persona {

    public Persona() {
    }

    public Persona(long cd_persona, String nm_persona, String url_foto) {

        setCd_Persona(cd_persona);
        setNm_Persona(nm_persona);
        setUrl_Foto(url_foto);
        
    }
    private long cd_Persona;
    private String nm_Persona;
    private String url_Foto;
    
                               
    public void setCd_Persona(long cd_Persona) {
        this.cd_Persona = cd_Persona;
    }

    public void setNm_Persona(String nm_persona) {
        this.nm_Persona = nm_persona;
    }

    public void setUrl_Foto(String url_foto) {
        this.url_Foto = url_foto;
    }
    
    public long getCd_Persona(){
        return this.cd_Persona;
    }
    
    public String getNm_Persona(){
        return this.nm_Persona;
    }
    public String getUrl_Foto(){
        return this.url_Foto;
    }
   
}
