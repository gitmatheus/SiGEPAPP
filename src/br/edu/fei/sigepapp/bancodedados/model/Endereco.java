package br.edu.fei.sigepapp.bancodedados.model;

public class Endereco {
	
	private long cd_user;
	private long nr_cep;
	private long nr_numero;
	private String ds_complemento;
	private String tp_endereco;
	
	public long getCd_user() {
		return cd_user;
	}
	public void setCd_user(long cd_user) {
		this.cd_user = cd_user;
	}
	public long getNr_cep() {
		return nr_cep;
	}
	public void setNr_cep(long nr_cep) {
		this.nr_cep = nr_cep;
	}
	public long getNr_numero() {
		return nr_numero;
	}
	public void setNr_numero(long nr_numero) {
		this.nr_numero = nr_numero;
	}
	public String getDs_complemento() {
		return ds_complemento;
	}
	public void setDs_complemento(String ds_complemento) {
		this.ds_complemento = ds_complemento;
	}
	public String getTp_endereco() {
		return tp_endereco;
	}
	public void setTp_endereco(String tp_endereco) {
		this.tp_endereco = tp_endereco;
	}

}
