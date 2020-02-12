package egovframework.whms.hi.chartTest.service;

import java.util.List;

public class ChartTestVO {

	private String searchCondition;
	private String searchKeyword;

	private String usrAge;
	private String highDgrCd;
	private String cnt;
	private String cnt1;
	private String cnt2;
	private String cnt3;
	private String cnt4;
	private String cnt5;

	private String loginAuthorType;
	private String loginAuthorCd;

	private List<ChartTestVO> detailList;
	private String usrAgeList;

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
	public List<ChartTestVO> getDetailList() {
		return detailList;
	}
	public void setDetailList(List<ChartTestVO> detailList) {
		this.detailList = detailList;
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
	public String getUsrAge() {
		return usrAge;
	}
	public void setUsrAge(String usrAge) {
		this.usrAge = usrAge;
	}
	public String getHighDgrCd() {
		return highDgrCd;
	}
	public void setHighDgrCd(String highDgrCd) {
		this.highDgrCd = highDgrCd;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getCnt1() {
		return cnt1;
	}
	public void setCnt1(String cnt1) {
		this.cnt1 = cnt1;
	}
	public String getCnt2() {
		return cnt2;
	}
	public void setCnt2(String cnt2) {
		this.cnt2 = cnt2;
	}
	public String getCnt3() {
		return cnt3;
	}
	public void setCnt3(String cnt3) {
		this.cnt3 = cnt3;
	}
	public String getCnt4() {
		return cnt4;
	}
	public void setCnt4(String cnt4) {
		this.cnt4 = cnt4;
	}
	public String getCnt5() {
		return cnt5;
	}
	public void setCnt5(String cnt5) {
		this.cnt5 = cnt5;
	}
	public String getUsrAgeList() {
		return usrAgeList;
	}
	public void setUsrAgeList(String usrAgeList) {
		this.usrAgeList = usrAgeList;
	}
}
