/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author Andrey
 * @version 0.01 Mai 12, 2009
 */
public class Persona extends Objeto {

    public Persona() {
    }

    public Persona(long cd_persona, String url_foto) {

        setCd_Persona(cd_persona);
        setUrl_Foto(url_foto);

    }
    private long cd_Persona;
    private String url_Foto;

    public void setCd_Persona(long cd_Persona) {
        this.cd_Persona = cd_Persona;
    }

    public void setUrl_Foto(String url_foto) {
        this.url_Foto = url_foto;
    }

    public long getCd_Persona() {
        return this.cd_Persona;
    }

    public String getUrl_Foto() {
        return this.url_Foto;
    }
}
