/*
 * @(#)AtributoDAO.java 0.01 23/05/09
 *
 * Este código é parte integrante do projeto de formatura,
 * do curso de ciências da computação, do Centro Universitário da FEI
 * Orientado pelo Prof Plinio T. Aquino Jr.
 *
 * Copyright (c) 2009 Equipe SiGePAPP
 * |------------------------------------------------------------------|
 * |                   Modificações no Código                         |
 * |------------------------------------------------------------------|
 * |   Autor     |   Data      |   Descrição                          |
 * |------------------------------------------------------------------|
 * | Guilherme   | 23/05/09    | Criação e elaboração inicial         |
 * |------------------------------------------------------------------|
 *
 */
package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class RelacObjetos_View extends RelacObjetos {

    String nome_relacionando;
    String ds_relacionando;
    String nm_estrut_relacionando;
    String tp_estrit_relacionando;
    String nm_atributo_obj;

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final RelacObjetos_View other = (RelacObjetos_View) obj;
        if ((this.nm_atributo_obj == null) ? (other.nm_atributo_obj != null) : !this.nm_atributo_obj.equals(other.nm_atributo_obj)) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        return hash;
    }

    public RelacObjetos_View(long cd_relac, long cd_obj_relacionado, long cd_obj_relacionando, long cd_atributo_obj, String vl_relac, String nome_relacionando, String ds_relacionando, String nm_estrut_relacionando, String tp_estrit_relacionando, String nm_atributo_obj) {
        super(cd_relac, cd_obj_relacionado, cd_obj_relacionando, cd_atributo_obj, vl_relac);
        this.nome_relacionando = nome_relacionando;
        this.ds_relacionando = ds_relacionando;
        this.nm_estrut_relacionando = nm_estrut_relacionando;
        this.tp_estrit_relacionando = tp_estrit_relacionando;
        this.nm_atributo_obj=nm_atributo_obj;
    }



    public RelacObjetos_View() {
        super();
    }

    public String getDs_relacionando() {
        return ds_relacionando;
    }

    public void setDs_relacionando(String ds_relacionando) {
        this.ds_relacionando = ds_relacionando;
    }

    public String getNm_estrut_relacionando() {
        return nm_estrut_relacionando;
    }

    public void setNm_estrut_relacionando(String nm_estrut_relacionando) {
        this.nm_estrut_relacionando = nm_estrut_relacionando;
    }

    public String getNome_relacionando() {
        return nome_relacionando;
    }

    public void setNome_relacionando(String nome_relacionando) {
        this.nome_relacionando = nome_relacionando;
    }

    public String getTp_estrit_relacionando() {
        return tp_estrit_relacionando;
    }

    public void setTp_estrit_relacionando(String tp_estrit_relacionando) {
        this.tp_estrit_relacionando = tp_estrit_relacionando;
    }

    public String getNm_atributo_obj() {
        return nm_atributo_obj;
    }

    public void setNm_atributo_obj(String nm_atributo_obj) {
        this.nm_atributo_obj = nm_atributo_obj;
    }

}
