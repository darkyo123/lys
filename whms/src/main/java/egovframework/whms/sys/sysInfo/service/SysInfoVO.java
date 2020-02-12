package egovframework.whms.sys.sysInfo.service;

import egovframework.com.uss.umt.service.UserDefaultVO;

public class SysInfoVO extends UserDefaultVO {

	private String userNm;
	private String userId;
	private String authorCd;
	private String authorNm;
	private String registDe;
	private String bigo;
	private String password;

	private String flag;
	private String testIdx;

	public String getUserNm() {
		return userNm;
	}
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAuthorNm() {
		return authorNm;
	}
	public void setAuthorNm(String authorNm) {
		this.authorNm = authorNm;
	}
	public String getRegistDe() {
		return registDe;
	}
	public void setRegistDe(String registDe) {
		this.registDe = registDe;
	}
	public String getBigo() {
		return bigo;
	}
	public void setBigo(String bigo) {
		this.bigo = bigo;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getTestIdx() {
		return testIdx;
	}
	public void setTestIdx(String testIdx) {
		this.testIdx = testIdx;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAuthorCd() {
		return authorCd;
	}
	public void setAuthorCd(String authorCd) {
		this.authorCd = authorCd;
	}

}
