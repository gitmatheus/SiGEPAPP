package br.edu.fei.sigepapp.bancodedados.model;

public class Login {
	
	private long cd_user;
	private String nm_login;
	private String pw_senha;

	public long getCd_user() {
		return cd_user;
	}
	public void setCd_user(long cd_user) {
		this.cd_user = cd_user;
	}
	public String getNm_login() {
		return nm_login;
	}
	public void setNm_login(String nm_login) {
		this.nm_login = nm_login;
	}
	public String getPw_senha() {
		return pw_senha;
	}
	public void setPw_senha(String pw_senha) {
		this.pw_senha = pw_senha;
	}

}
