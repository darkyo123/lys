package egovframework.whms.hi.qslt.service;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.uss.umt.service.UserDefaultVO;

public class QsltVO extends UserDefaultVO {

	private String UseGrpCd;
	private String UsrId;
	private String MakeDt;
	private String EmpTmpId;
	private String UsrNm;
	private String UsrAge;
	private String BirDt;
	private String SexSecd;
	private String JobCareerYear;
	private String JobCareerMonth;
	private String BldtyCd;
	private Double UsrHet;
	private Double UsrWet;
	private String FahsYn;
	private String Fahs1Yn;
	private String Fahs2Yn;
	private String Fahs3Yn;
	private String Fahs4Yn;
	private String Fahs5Yn;
	private String Fahs6Yn;
	private String FahsEtc;
	private String SmkYn;
	private String DysmkCt;
	private String AlcYn;
	private String WekAlcCt;
	private String AdrkCt;
	private String HavdisYn;
	private String Havdis1Yn;
	private String Havdis2Yn;
	private String Havdis3Yn;
	private String Havdis4Yn;
	private String Havdis5Yn;
	private String Havdis6Yn;
	private String Havdis7Yn;
	private String Havdis8Yn;
	private String HavdisEtc;
	private String HavdisEtc1Yn;
	private String HavdisEtc2Yn;
	private String HavdisEtc3Yn;
	private String HavdisEtc4Yn;
	private String HavdisEtc5Yn;
	private String HavdisEtc6Yn;
	private String HavdisEtc7Yn;
	private String HavdisEtc8Yn;
	private String HavdisEtc9Yn;
	private String MoaciYn;
	private String Moaci1Yn;
	private String Moaci2Yn;
	private String Moaci3Yn;
	private String Moaci4Yn;
	private String Moaci5Yn;
	private String Moaci6Yn;
	private String Moaci7Yn;
	private String WkpnYn;
	private String Wkpn1Yn;
	private String Wkpn2Yn;
	private String Wkpn3Yn;
	private String Wkpn4Yn;
	private String Wkpn5Yn;
	private String Wkpn6Yn;
	private String Wkpn7Yn;
	private String IntsymYn;
	private String Repsym1Yn;
	private String Repsym2Yn;
	private String Repsym3Yn;
	private String Repsym4Yn;
	private String Repsym5Yn;
	private String Cirsym1Yn;
	private String Cirsym2Yn;
	private String Cirsym3Yn;
	private String Cirsym4Yn;
	private String Cirsym5Yn;
	private String Cirsym6Yn;
	private String Cirsym7Yn;
	private String InddistYn;
	private String Inddist1Yn;
	private String Inddist2Yn;
	private String Inddist3Yn;
	private String Inddist4Yn;
	private String Inddist5Yn;
	private String Inddist6Yn;
	private String InddistEtc;
	private String InfrecYn;
	private String UseYn;
	private String SysRgsDt;
	private String RgsId;
	private String SysUpdDt;
	private String UpdId;
	private String highDgrCd;
	private String dcviwYn;
	private String targetDt;

	private String loginAuthorType;
	private String loginAuthorCd;

	public String getUseGrpCd() {
		return UseGrpCd;
	}
	public void setUseGrpCd(String useGrpCd) {
		UseGrpCd = useGrpCd;
	}
	public String getUsrId() {
		return UsrId;
	}
	public void setUsrId(String usrId) {
		UsrId = usrId;
	}
	public String getMakeDt() {
		return MakeDt;
	}
	public void setMakeDt(String makeDt) {
		MakeDt = makeDt;
	}
	public String getEmpTmpId() {
		return EmpTmpId;
	}
	public void setEmpTmpId(String empTmpId) {
		EmpTmpId = empTmpId;
	}
	public String getUsrNm() {
		return UsrNm;
	}
	public void setUsrNm(String usrNm) {
		UsrNm = usrNm;
	}
	public String getUsrAge() {
		return UsrAge;
	}
	public void setUsrAge(String usrAge) {
		UsrAge = usrAge;
	}
	public String getBirDt() {
		return BirDt;
	}
	public void setBirDt(String birDt) {
		BirDt = birDt;
	}
	public String getSexSecd() {
		return SexSecd;
	}
	public void setSexSecd(String sexSecd) {
		SexSecd = sexSecd;
	}
	public String getJobCareerYear() {
		return JobCareerYear;
	}
	public void setJobCareerYear(String jonCareerYear) {
		JobCareerYear = jonCareerYear;
	}
	public String getJobCareerMonth() {
		return JobCareerMonth;
	}
	public void setJobCareerMonth(String jonCareerMonth) {
		JobCareerMonth = jonCareerMonth;
	}
	public String getBldtyCd() {
		return BldtyCd;
	}
	public void setBldtyCd(String bldtyCd) {
		BldtyCd = bldtyCd;
	}
	public Double getUsrHet() {
		return UsrHet;
	}
	public void setUsrHet(Double usrHet) {
		UsrHet = usrHet;
	}
	public Double getUsrWet() {
		return UsrWet;
	}
	public void setUsrWet(Double usrWet) {
		UsrWet = usrWet;
	}
	public String getFahsYn() {
		return FahsYn;
	}
	public void setFahsYn(String fahsYn) {
		FahsYn = fahsYn;
	}
	public String getFahs1Yn() {
		return Fahs1Yn;
	}
	public void setFahs1Yn(String fahs1Yn) {
		Fahs1Yn = fahs1Yn;
	}
	public String getFahs2Yn() {
		return Fahs2Yn;
	}
	public void setFahs2Yn(String fahs2Yn) {
		Fahs2Yn = fahs2Yn;
	}
	public String getFahs3Yn() {
		return Fahs3Yn;
	}
	public void setFahs3Yn(String fahs3Yn) {
		Fahs3Yn = fahs3Yn;
	}
	public String getFahs4Yn() {
		return Fahs4Yn;
	}
	public void setFahs4Yn(String fahs4Yn) {
		Fahs4Yn = fahs4Yn;
	}
	public String getFahs5Yn() {
		return Fahs5Yn;
	}
	public void setFahs5Yn(String fahs5Yn) {
		Fahs5Yn = fahs5Yn;
	}
	public String getFahs6Yn() {
		return Fahs6Yn;
	}
	public void setFahs6Yn(String fahs6Yn) {
		Fahs6Yn = fahs6Yn;
	}
	public String getFahsEtc() {
		return FahsEtc;
	}
	public void setFahsEtc(String fahsEtc) {
		FahsEtc = fahsEtc;
	}
	public String getSmkYn() {
		return SmkYn;
	}
	public void setSmkYn(String smkYn) {
		SmkYn = smkYn;
	}
	public String getAlcYn() {
		return AlcYn;
	}
	public void setAlcYn(String alcYn) {
		AlcYn = alcYn;
	}
	public String getHavdisYn() {
		return HavdisYn;
	}
	public void setHavdisYn(String havdisYn) {
		HavdisYn = havdisYn;
	}
	public String getHavdis1Yn() {
		return Havdis1Yn;
	}
	public void setHavdis1Yn(String havdis1Yn) {
		Havdis1Yn = havdis1Yn;
	}
	public String getHavdis2Yn() {
		return Havdis2Yn;
	}
	public void setHavdis2Yn(String havdis2Yn) {
		Havdis2Yn = havdis2Yn;
	}
	public String getHavdis3Yn() {
		return Havdis3Yn;
	}
	public void setHavdis3Yn(String havdis3Yn) {
		Havdis3Yn = havdis3Yn;
	}
	public String getHavdis4Yn() {
		return Havdis4Yn;
	}
	public void setHavdis4Yn(String havdis4Yn) {
		Havdis4Yn = havdis4Yn;
	}
	public String getHavdis5Yn() {
		return Havdis5Yn;
	}
	public void setHavdis5Yn(String havdis5Yn) {
		Havdis5Yn = havdis5Yn;
	}
	public String getHavdis6Yn() {
		return Havdis6Yn;
	}
	public void setHavdis6Yn(String havdis6Yn) {
		Havdis6Yn = havdis6Yn;
	}
	public String getHavdis7Yn() {
		return Havdis7Yn;
	}
	public void setHavdis7Yn(String havdis7Yn) {
		Havdis7Yn = havdis7Yn;
	}
	public String getHavdisEtc() {
		return HavdisEtc;
	}
	public void setHavdisEtc(String havdisEtc) {
		HavdisEtc = havdisEtc;
	}
	public String getHavdisEtc1Yn() {
		return HavdisEtc1Yn;
	}
	public void setHavdisEtc1Yn(String havdisEtc1Yn) {
		HavdisEtc1Yn = havdisEtc1Yn;
	}
	public String getHavdisEtc2Yn() {
		return HavdisEtc2Yn;
	}
	public void setHavdisEtc2Yn(String havdisEtc2Yn) {
		HavdisEtc2Yn = havdisEtc2Yn;
	}
	public String getHavdisEtc3Yn() {
		return HavdisEtc3Yn;
	}
	public void setHavdisEtc3Yn(String havdisEtc3Yn) {
		HavdisEtc3Yn = havdisEtc3Yn;
	}
	public String getHavdisEtc4Yn() {
		return HavdisEtc4Yn;
	}
	public void setHavdisEtc4Yn(String havdisEtc4Yn) {
		HavdisEtc4Yn = havdisEtc4Yn;
	}
	public String getHavdisEtc5Yn() {
		return HavdisEtc5Yn;
	}
	public void setHavdisEtc5Yn(String havdisEtc5Yn) {
		HavdisEtc5Yn = havdisEtc5Yn;
	}
	public String getHavdisEtc6Yn() {
		return HavdisEtc6Yn;
	}
	public void setHavdisEtc6Yn(String havdisEtc6Yn) {
		HavdisEtc6Yn = havdisEtc6Yn;
	}
	public String getHavdisEtc7Yn() {
		return HavdisEtc7Yn;
	}
	public void setHavdisEtc7Yn(String havdisEtc7Yn) {
		HavdisEtc7Yn = havdisEtc7Yn;
	}
	public String getHavdisEtc8Yn() {
		return HavdisEtc8Yn;
	}
	public void setHavdisEtc8Yn(String havdisEtc8Yn) {
		HavdisEtc8Yn = havdisEtc8Yn;
	}
	public String getHavdisEtc9Yn() {
		return HavdisEtc9Yn;
	}
	public void setHavdisEtc9Yn(String havdisEtc9Yn) {
		HavdisEtc9Yn = havdisEtc9Yn;
	}
	public String getMoaciYn() {
		return MoaciYn;
	}
	public void setMoaciYn(String moaciYn) {
		MoaciYn = moaciYn;
	}
	public String getMoaci1Yn() {
		return Moaci1Yn;
	}
	public void setMoaci1Yn(String moaci1Yn) {
		Moaci1Yn = moaci1Yn;
	}
	public String getMoaci2Yn() {
		return Moaci2Yn;
	}
	public void setMoaci2Yn(String moaci2Yn) {
		Moaci2Yn = moaci2Yn;
	}
	public String getMoaci3Yn() {
		return Moaci3Yn;
	}
	public void setMoaci3Yn(String moaci3Yn) {
		Moaci3Yn = moaci3Yn;
	}
	public String getMoaci4Yn() {
		return Moaci4Yn;
	}
	public void setMoaci4Yn(String moaci4Yn) {
		Moaci4Yn = moaci4Yn;
	}
	public String getMoaci5Yn() {
		return Moaci5Yn;
	}
	public void setMoaci5Yn(String moaci5Yn) {
		Moaci5Yn = moaci5Yn;
	}
	public String getMoaci6Yn() {
		return Moaci6Yn;
	}
	public void setMoaci6Yn(String moaci6Yn) {
		Moaci6Yn = moaci6Yn;
	}
	public String getMoaci7Yn() {
		return Moaci7Yn;
	}
	public void setMoaci7Yn(String moaci7Yn) {
		Moaci7Yn = moaci7Yn;
	}
	public String getWkpnYn() {
		return WkpnYn;
	}
	public void setWkpnYn(String wkpnYn) {
		WkpnYn = wkpnYn;
	}
	public String getWkpn1Yn() {
		return Wkpn1Yn;
	}
	public void setWkpn1Yn(String wkpn1Yn) {
		Wkpn1Yn = wkpn1Yn;
	}
	public String getWkpn2Yn() {
		return Wkpn2Yn;
	}
	public void setWkpn2Yn(String wkpn2Yn) {
		Wkpn2Yn = wkpn2Yn;
	}
	public String getWkpn3Yn() {
		return Wkpn3Yn;
	}
	public void setWkpn3Yn(String wkpn3Yn) {
		Wkpn3Yn = wkpn3Yn;
	}
	public String getWkpn4Yn() {
		return Wkpn4Yn;
	}
	public void setWkpn4Yn(String wkpn4Yn) {
		Wkpn4Yn = wkpn4Yn;
	}
	public String getWkpn5Yn() {
		return Wkpn5Yn;
	}
	public void setWkpn5Yn(String wkpn5Yn) {
		Wkpn5Yn = wkpn5Yn;
	}
	public String getWkpn6Yn() {
		return Wkpn6Yn;
	}
	public void setWkpn6Yn(String wkpn6Yn) {
		Wkpn6Yn = wkpn6Yn;
	}
	public String getWkpn7Yn() {
		return Wkpn7Yn;
	}
	public void setWkpn7Yn(String wkpn7Yn) {
		Wkpn7Yn = wkpn7Yn;
	}
	public String getIntsymYn() {
		return IntsymYn;
	}
	public void setIntsymYn(String intsymYn) {
		IntsymYn = intsymYn;
	}
	public String getRepsym1Yn() {
		return Repsym1Yn;
	}
	public void setRepsym1Yn(String repsym1Yn) {
		Repsym1Yn = repsym1Yn;
	}
	public String getRepsym2Yn() {
		return Repsym2Yn;
	}
	public void setRepsym2Yn(String repsym2Yn) {
		Repsym2Yn = repsym2Yn;
	}
	public String getRepsym3Yn() {
		return Repsym3Yn;
	}
	public void setRepsym3Yn(String repsym3Yn) {
		Repsym3Yn = repsym3Yn;
	}
	public String getRepsym4Yn() {
		return Repsym4Yn;
	}
	public void setRepsym4Yn(String repsym4Yn) {
		Repsym4Yn = repsym4Yn;
	}
	public String getRepsym5Yn() {
		return Repsym5Yn;
	}
	public void setRepsym5Yn(String repsym5Yn) {
		Repsym5Yn = repsym5Yn;
	}
	public String getCirsym1Yn() {
		return Cirsym1Yn;
	}
	public void setCirsym1Yn(String cirsym1Yn) {
		Cirsym1Yn = cirsym1Yn;
	}
	public String getCirsym2Yn() {
		return Cirsym2Yn;
	}
	public void setCirsym2Yn(String cirsym2Yn) {
		Cirsym2Yn = cirsym2Yn;
	}
	public String getCirsym3Yn() {
		return Cirsym3Yn;
	}
	public void setCirsym3Yn(String cirsym3Yn) {
		Cirsym3Yn = cirsym3Yn;
	}
	public String getCirsym4Yn() {
		return Cirsym4Yn;
	}
	public void setCirsym4Yn(String cirsym4Yn) {
		Cirsym4Yn = cirsym4Yn;
	}
	public String getCirsym5Yn() {
		return Cirsym5Yn;
	}
	public void setCirsym5Yn(String cirsym5Yn) {
		Cirsym5Yn = cirsym5Yn;
	}
	public String getCirsym6Yn() {
		return Cirsym6Yn;
	}
	public void setCirsym6Yn(String cirsym6Yn) {
		Cirsym6Yn = cirsym6Yn;
	}
	public String getCirsym7Yn() {
		return Cirsym7Yn;
	}
	public void setCirsym7Yn(String cirsym7Yn) {
		Cirsym7Yn = cirsym7Yn;
	}
	public String getInddistYn() {
		return InddistYn;
	}
	public void setInddistYn(String inddistYn) {
		InddistYn = inddistYn;
	}
	public String getInddist1Yn() {
		return Inddist1Yn;
	}
	public void setInddist1Yn(String inddist1Yn) {
		Inddist1Yn = inddist1Yn;
	}
	public String getInddist2Yn() {
		return Inddist2Yn;
	}
	public void setInddist2Yn(String inddist2Yn) {
		Inddist2Yn = inddist2Yn;
	}
	public String getInddist3Yn() {
		return Inddist3Yn;
	}
	public void setInddist3Yn(String inddist3Yn) {
		Inddist3Yn = inddist3Yn;
	}
	public String getInddist4Yn() {
		return Inddist4Yn;
	}
	public void setInddist4Yn(String inddist4Yn) {
		Inddist4Yn = inddist4Yn;
	}
	public String getInddist5Yn() {
		return Inddist5Yn;
	}
	public void setInddist5Yn(String inddist5Yn) {
		Inddist5Yn = inddist5Yn;
	}
	public String getInddist6Yn() {
		return Inddist6Yn;
	}
	public void setInddist6Yn(String inddist6Yn) {
		Inddist6Yn = inddist6Yn;
	}
	public String getInddistEtc() {
		return InddistEtc;
	}
	public void setInddistEtc(String inddistEtc) {
		InddistEtc = inddistEtc;
	}
	public String getInfrecYn() {
		return InfrecYn;
	}
	public void setInfrecYn(String infrecYn) {
		InfrecYn = infrecYn;
	}
	public String getUseYn() {
		return UseYn;
	}
	public void setUseYn(String useYn) {
		UseYn = useYn;
	}
	public String getSysRgsDt() {
		return SysRgsDt;
	}
	public void setSysRgsDt(String sysRgsDt) {
		SysRgsDt = sysRgsDt;
	}
	public String getRgsId() {
		return RgsId;
	}
	public void setRgsId(String rgsId) {
		RgsId = rgsId;
	}
	public String getSysUpdDt() {
		return SysUpdDt;
	}
	public void setSysUpdDt(String sysUpdDt) {
		SysUpdDt = sysUpdDt;
	}
	public String getUpdId() {
		return UpdId;
	}
	public void setUpdId(String updId) {
		UpdId = updId;
	}
	public String getDysmkCt() {
		return DysmkCt;
	}
	public void setDysmkCt(String dysmkCt) {
		DysmkCt = dysmkCt;
	}
	public String getWekAlcCt() {
		return WekAlcCt;
	}
	public void setWekAlcCt(String wekAlcCt) {
		WekAlcCt = wekAlcCt;
	}
	public String getAdrkCt() {
		return AdrkCt;
	}
	public void setAdrkCt(String adrkCt) {
		AdrkCt = adrkCt;
	}
	public String getHighDgrCd() {
		return highDgrCd;
	}
	public void setHighDgrCd(String highDgrCd) {
		this.highDgrCd = highDgrCd;
	}
	public String getHavdis8Yn() {
		return Havdis8Yn;
	}
	public void setHavdis8Yn(String havdis8Yn) {
		Havdis8Yn = havdis8Yn;
	}
	public String getDcviwYn() {
		return dcviwYn;
	}
	public void setDcviwYn(String dcviwYn) {
		this.dcviwYn = dcviwYn;
	}
	public String getLoginAuthorType() {
		return loginAuthorType;
	}
	public void setLoginAuthorType(String loginAuthorType) {
		this.loginAuthorType = loginAuthorType;
	}
	public String getLoginAuthorCd() {
		return loginAuthorCd;
	}
	public void setLoginAuthorCd(String loginAuthorCd) {
		this.loginAuthorCd = loginAuthorCd;
	}
	public String getTargetDt() {
		return targetDt;
	}
	public void setTargetDt(String targetDt) {
		this.targetDt = targetDt;
	}

}