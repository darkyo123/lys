package egovframework.whms.sm.measureItem.service;

import java.util.List;

public class MeasureItemVO {

	private String searchCondition;
	private String searchKeyword;

	private String useGrpCd;
	private String usrNm;
	private String usrId;
	private String sexSecd;
	private String birDt;
	private String connTelno;
	private String sysRgsDt;
	private String sysRgsDtFull;

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getUsrNm() {
		return usrNm;
	}
	public void setUsrNm(String usrNm) {
		this.usrNm = usrNm;
	}
	public String getUsrId() {
		return usrId;
	}
	public void setUsrId(String usrId) {
		this.usrId = usrId;
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
	public String getSysRgsDt() {
		return sysRgsDt;
	}
	public void setSysRgsDt(String sysRgsDt) {
		this.sysRgsDt = sysRgsDt;
	}
	public String getUseGrpCd() {
		return useGrpCd;
	}
	public void setUseGrpCd(String useGrpCd) {
		this.useGrpCd = useGrpCd;
	}
	public String getSysRgsDtFull() {
		return sysRgsDtFull;
	}
	public void setSysRgsDtFull(String sysRgsDtFull) {
		this.sysRgsDtFull = sysRgsDtFull;
	}

}
