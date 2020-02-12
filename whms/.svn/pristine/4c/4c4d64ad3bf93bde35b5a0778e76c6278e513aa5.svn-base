package egovframework.whms.bi.userDetailManage.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.bi.userDetailManage.service.UserDetailManageVO;

@Repository("userDetailManageDAO")
public class UserDetailManageDAO extends EgovComAbstractDAO {

	public UserDetailManageVO selectUserDetailManage(UserDetailManageVO userDetailManageVO) throws Exception {
		return (UserDetailManageVO) selectOne("userDetailManageDAO.selectUserDetailManage", userDetailManageVO);
	}

	public List<UserDetailManageVO> selectDetailList(UserDetailManageVO userDetailManageVO) throws Exception {
		return selectList("userDetailManageDAO.selectDetailList", userDetailManageVO);
	}

	public String getHighDgrNm(UserDetailManageVO userDetailManageVO) throws Exception {
		return (String) selectOne("userDetailManageDAO.getHighDgrNm", userDetailManageVO);
	}

	public String selectDetailListCnt(UserDetailManageVO userDetailManageVO) throws Exception {
		return (String) selectOne("userDetailManageDAO.selectDetailListCnt", userDetailManageVO);
	}

	public UserDetailManageVO selectDetailQslt(UserDetailManageVO userDetailManageVO) throws Exception {
		return (UserDetailManageVO) selectOne("userDetailManageDAO.selectDetailQslt", userDetailManageVO);
	}

	public void doUpdateHighDgrCd(UserDetailManageVO userDetailManageVO) throws Exception {
		update("userDetailManageDAO.doUpdateHighDgrCd", userDetailManageVO);
	}

	public void doUpdatePressureInfo(UserDetailManageVO userDetailManageVO) throws Exception {
		update("userDetailManageDAO.doUpdatePressureInfo", userDetailManageVO);
	}

	public List<UserDetailManageVO> selectDcviwList(UserDetailManageVO userDetailManageVO) throws Exception {
		return selectList("userDetailManageDAO.selectDcviwList", userDetailManageVO);
	}

	public String checkDcviwDesc(UserDetailManageVO userDetailManageVO) throws Exception {
		return (String) selectOne("userDetailManageDAO.checkDcviwDesc", userDetailManageVO);
	}

	public void doRegistDcviwDesc(UserDetailManageVO userDetailManageVO) throws Exception {
		insert("userDetailManageDAO.doRegistDcviwDesc", userDetailManageVO);
	}

	public void doUpdateDcviwDesc(UserDetailManageVO userDetailManageVO) throws Exception {
		update("userDetailManageDAO.doUpdateDcviwDesc", userDetailManageVO);
	}

}