package br.edu.fei.sigepapp.bancodedados.model;

public class Telefone {

	private long cd_user;
	private long nr_ddi;
	private long nr_ddd;
	private long nr_telefone;
	private String tp_telefone;
	
	public long getCd_user() {
		return cd_user;
	}
	public void setCd_user(long cd_user) {
		this.cd_user = cd_user;
	}
	public long getNr_ddi() {
		return nr_ddi;
	}
	public void setNr_ddi(long nr_ddi) {
		this.nr_ddi = nr_ddi;
	}
	public long getNr_ddd() {
		return nr_ddd;
	}
	public void setNr_ddd(long nr_ddd) {
		this.nr_ddd = nr_ddd;
	}
	public long getNr_telefone() {
		return nr_telefone;
	}
	public void setNr_telefone(long nr_telefone) {
		this.nr_telefone = nr_telefone;
	}
	public String getTp_telefone() {
		return tp_telefone;
	}
	public void setTp_telefone(String tp_telefone) {
		this.tp_telefone = tp_telefone;
	}

}
