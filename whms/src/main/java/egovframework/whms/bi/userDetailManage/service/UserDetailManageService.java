package egovframework.whms.bi.userDetailManage.service;

public interface UserDetailManageService {
	public UserDetailManageVO selectUserDetailManage(UserDetailManageVO userDetailManageVO) throws Exception;
	public void doRegistPressureInfo(UserDetailManageVO userDetailManageVO) throws Exception;
	public void doUpdageHighDgrCd(UserDetailManageVO userDetailManageVO) throws Exception;
	public void doRegistDcviwDesc(UserDetailManageVO userDetailManageVO) throws Exception;
}