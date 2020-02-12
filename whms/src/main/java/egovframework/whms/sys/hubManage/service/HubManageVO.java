package egovframework.whms.sys.hubManage.service;

import egovframework.com.uss.umt.service.UserDefaultVO;

public class HubManageVO extends UserDefaultVO {

	private String useGrpNm;
	private String useGrpCd;
	private String usrId;
	private String usrNm;
	private String sexSecd;
	private String birDt;
	private String connTelno;
	private String loginAuthorCd;
	private String loginAuthorType;

	private String usrIds;
	private String targetId;
	private String loginId;

	public String getUseGrpNm() {
		return useGrpNm;
	}
	public void setUseGrpNm(String useGrpNm) {
		this.useGrpNm = useGrpNm;
	}
	public String getUseGrpCd() {
		return useGrpCd;
	}
	public void setUseGrpCd(String useGrpCd) {
		this.useGrpCd = useGrpCd;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
	}
	public String getUsrNm() {
		return usrNm;
	}
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}
	public String getSexSecd() {
		return sexSecd;
	}
	public void setSexSecd(String sexSecd) {
		this.sexSecd = sexSecd;
	}
	public String getBirDt() {
		return birDt;
	}
	public void setBirDt(String birDt) {
		this.birDt = birDt;
	}
	public String getConnTelno() {
		return connTelno;
	}
	public void setConnTelno(String connTelno) {
		this.connTelno = connTelno;
	}
	public String getUsrIds() {
		return usrIds;
	}
	public void setUsrIds(String usrIds) {
		this.usrIds = usrIds;
	}
	public String getTargetId() {
		return targetId;
	}
	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginAuthorCd() {
		return loginAuthorCd;
	}
	public void setLoginAuthorCd(String loginAuthorCd) {
		this.loginAuthorCd = loginAuthorCd;
	}
	public String getLoginAuthorType() {
		return loginAuthorType;
	}
	public void setLoginAuthorType(String loginAuthorType) {
		this.loginAuthorType = loginAuthorType;
	}

}
