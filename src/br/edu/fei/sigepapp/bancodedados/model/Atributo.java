/*
 * @(#)AtributoDAO.java 0.01 21/02/09
 *
 * Este c�digo � parte integrante do projeto de formatura,
 * do curso de ci�ncias da computa��o, do Centro Universit�rio da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modifica��es no C�digo                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descri��o                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 01/02/09    | Cria��o e elabora��o inicial         |
 * | Guilherme   | 07/03/09    | Mudanca do modelo: nao existe mais   |
 * |             |             | o atributo DS_TAMANHO na tabela.     |
 * |------------------------------------------------------------------|
 *
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class Atributo {

    private long cd_atributo_obj;
    private String nm_atributo_obj;
    private String ds_atributo_obj;
    private long cd_tipo;
    private String fl_atrib_relac;



    public   Atributo() {
    setCd_atributo_obj(0);
        setNm_atributo_obj(null);
        setDs_atributo_obj(null);
        setCd_tipo(0);
        setFl_atrib_relac(null);
    }
    ;

    public Atributo(long cd_atributo_obj, String nm_atributo_obj, String ds_atributo_obj, long cd_tipo, String fl_atrib_relac) {

        setCd_atributo_obj(cd_atributo_obj);
        setNm_atributo_obj(nm_atributo_obj);
        setDs_atributo_obj(ds_atributo_obj);
        setCd_tipo(cd_tipo);
        setFl_atrib_relac(fl_atrib_relac);
        
    }

    public long getCd_atributo_obj() {
        return cd_atributo_obj;
    }

    public void setCd_atributo_obj(long cd_atributo_obj) {
        this.cd_atributo_obj = cd_atributo_obj;
    }

    public long getCd_tipo() {
        return cd_tipo;
    }

    public void setCd_tipo(long cd_tipo) {
        this.cd_tipo = cd_tipo;
    }

    public String getDs_atributo_obj() {
        return ds_atributo_obj;
    }

    public void setDs_atributo_obj(String ds_atributo_obj) {
        this.ds_atributo_obj = ds_atributo_obj;
    }

    public String getFl_atrib_relac() {
        return fl_atrib_relac;
    }

    public void setFl_atrib_relac(String fl_atrib_relac) {
        
        if (fl_atrib_relac==null || fl_atrib_relac.equalsIgnoreCase("S") || fl_atrib_relac.equalsIgnoreCase("N")) {
            this.fl_atrib_relac = fl_atrib_relac;
        }else{
            throw new IllegalArgumentException("Flag de tipo do atributo inv�lido: Esperado 'S' ou 'N'");
        }
    }

    public String getNm_atributo_obj() {
        return nm_atributo_obj;
    }

    public void setNm_atributo_obj(String nm_atributo_obj) {
        this.nm_atributo_obj = nm_atributo_obj;
    }
}
