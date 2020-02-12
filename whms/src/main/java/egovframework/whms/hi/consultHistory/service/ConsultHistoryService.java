package egovframework.whms.hi.consultHistory.service;

import egovframework.whms.bi.userDetailManage.service.UserDetailManageVO;

public interface ConsultHistoryService {
	public UserDetailManageVO selectConsultHistory(UserDetailManageVO userDetailManageVO) throws Exception;
}