package egovframework.whms.sys.hubManage.service;

import java.util.List;

public interface HubManageService {
	public List<HubManageVO> selectDataList(HubManageVO hubManageVO) throws Exception;
	public String doSave(HubManageVO hubManageVO) throws Exception;
}
