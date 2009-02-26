package br.edu.fei.sigepapp.bancodedados.model;

import java.sql.Date;

public class Usuario {
	
	private long cd_user;
	private String nm_prim_nome;
	private String nm_ult_nome;
	private Date dt_nasc;
	private double nr_nota;
	private Date dt_cadastro;
	private String ds_area_interesse;
	private String nm_msn;
	private String nm_skype;
	
	public long getCd_user() {
		return cd_user;
	}
	public void setCd_user(long cd_user) {
		this.cd_user = cd_user;
	}
	public String getNm_prim_nome() {
		return nm_prim_nome;
	}
	public void setNm_prim_nome(String nm_prim_nome) {
		this.nm_prim_nome = nm_prim_nome;
	}
	public String getNm_ult_nome() {
		return nm_ult_nome;
	}
	public void setNm_ult_nome(String nm_ult_nome) {
		this.nm_ult_nome = nm_ult_nome;
	}
	public Date getDt_nasc() {
		return dt_nasc;
	}
	public void setDt_nasc(Date dt_nasc) {
		this.dt_nasc = dt_nasc;
	}
	public double getNr_nota() {
		return nr_nota;
	}
	public void setNr_nota(double nr_nota) {
		this.nr_nota = nr_nota;
	}
	public Date getDt_cadastro() {
		return dt_cadastro;
	}
	public void setDt_cadastro(Date dt_cadastro) {
		this.dt_cadastro = dt_cadastro;
	}
	public String getDs_area_interesse() {
		return ds_area_interesse;
	}
	public void setDs_area_interesse(String ds_area_interesse) {
		this.ds_area_interesse = ds_area_interesse;
	}
	public String getNm_msn() {
		return nm_msn;
	}
	public void setNm_msn(String nm_msn) {
		this.nm_msn = nm_msn;
	}
	public String getNm_skype() {
		return nm_skype;
	}
	public void setNm_skype(String nm_skype) {
		this.nm_skype = nm_skype;
	}

}
