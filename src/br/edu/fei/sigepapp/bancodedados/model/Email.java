package br.edu.fei.sigepapp.bancodedados.model;

public class Email {
	
	private long cd_user;
	private String nm_email;
	private String tp_email;

	public long getCd_user() {
		return cd_user;
	}
	public void setCd_user(long cd_user) {
		this.cd_user = cd_user;
	}
	public String getNm_email() {
		return nm_email;
	}
	public void setNm_email(String nm_email) {
		this.nm_email = nm_email;
	}
	public String getTp_email() {
		return tp_email;
	}
	public void setTp_email(String tp_email) {
		this.tp_email = tp_email;
	}

}
