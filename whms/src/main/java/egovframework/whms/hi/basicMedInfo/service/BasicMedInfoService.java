package egovframework.whms.hi.basicMedInfo.service;

public interface BasicMedInfoService {
	public BasicMedInfoVO selectBasicMedInfo(BasicMedInfoVO basicMedInfoVO) throws Exception;
	public String doSave(BasicMedInfoVO basicMedInfoVO) throws Exception;
}