/*
 * @(#)Tipo.java 0.01 21/02/09
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
 * |------------------------------------------------------------------|
 * | Guilherme   | 22/03/09    | Adi��o de checagem para FL_TIPO_EXP  |
 * |------------------------------------------------------------------|
 */

package br.edu.fei.sigepapp.bancodedados.model;

/**
 *
 * @author lopespt
 */
public class Tipo {

    private long cd_tipo;
    private String nm_tipo;
    private String ds_tipo;
    private String fl_exp_reg;

    public Tipo() {
    }

    public Tipo(long cd_tipo, String nm_tipo, String ds_tipo, String fl_exp_reg) {

        setCd_tipo(cd_tipo);
        setNm_tipo(nm_tipo);
        setDs_tipo(ds_tipo);
        setFl_exp_reg(fl_exp_reg);
    }

    public long getCd_tipo() {
        return cd_tipo;
    }

    public void setCd_tipo(long cd_tipo) {
        this.cd_tipo = cd_tipo;
    }

    public String getDs_tipo() {
        return ds_tipo;
    }

    public void setDs_tipo(String ds_tipo) {
        this.ds_tipo = ds_tipo;
    }

    public String getFl_exp_reg() {
        return fl_exp_reg;
    }

    public void setFl_exp_reg(String fl_exp_reg) {
        if (fl_exp_reg == null || fl_exp_reg.toUpperCase().equals("S") || fl_exp_reg.toUpperCase().equals("N")) {
            this.fl_exp_reg = fl_exp_reg;
        } else {
            throw new IllegalArgumentException("Flag de express�o regular do tipo inv�lido: Esperado 'S' ou 'N'");
        }
    }

    public String getNm_tipo() {
        return nm_tipo;
    }

    public void setNm_tipo(String nm_tipo) {
        this.nm_tipo = nm_tipo;
    }
}
