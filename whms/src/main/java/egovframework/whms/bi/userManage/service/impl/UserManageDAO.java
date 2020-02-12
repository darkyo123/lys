package egovframework.whms.bi.userManage.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.bi.userManage.service.UserManageVO;

@Repository("usrManageDAO")
public class UserManageDAO extends EgovComAbstractDAO {
	public List<UserManageVO> selectDataList(UserManageVO userManageVO) throws Exception {
        return selectList("userManageDAO.selectDataList", userManageVO);
    }

	public List<UserManageVO> selectUseGrpCdList(UserManageVO userManageVO) throws Exception {
		return selectList("userManageDAO.selectUseGrpCdList", userManageVO);
	}

	public UserManageVO selectData(UserManageVO userManageVO) throws Exception {
        return selectOne("userManageDAO.selectData", userManageVO);
    }

	public void doRegist(UserManageVO userManageVO) throws Exception {
		insert("userManageDAO.doRegist", userManageVO);
	}

	public void doUpdate(UserManageVO userManageVO) throws Exception {
		update("userManageDAO.doUpdate", userManageVO);
	}

	public void doDelete(UserManageVO userManageVO) throws Exception {
		delete("userManageDAO.doDelete", userManageVO);
	}

	public void doUpdateHighDgrCd(UserManageVO userManageVO) throws Exception {
		update("userManageDAO.doUpdateHighDgrCd", userManageVO);
	}

	public void doUpdatePopup(UserManageVO userManageVO) throws Exception {
		update("userManageDAO.doUpdatePopup", userManageVO);
	}

}
