package egovframework.whms.sys.adminManage.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.sys.adminManage.service.AdminManageVO;

@Repository("adminManageDAO")
public class AdminManageDAO extends EgovComAbstractDAO {
	public List<AdminManageVO> selectDataList(AdminManageVO adminManageVO) throws Exception {
        return selectList("adminManageDAO.selectDataList", adminManageVO);
    }

	public void doRegist(AdminManageVO adminManageVO) throws Exception {
		insert("adminManageDAO.doRegist", adminManageVO);
	}

	public void doRegistAuth(AdminManageVO adminManageVO) throws Exception {
		insert("adminManageDAO.doRegistAuth", adminManageVO);
	}

	public void doUpdate(AdminManageVO adminManageVO) throws Exception {
		update("adminManageDAO.doUpdate", adminManageVO);
	}

	public void doDelete(AdminManageVO adminManageVO) throws Exception {
		delete("adminManageDAO.doDelete", adminManageVO);
	}

	public void doDeleteAuth(AdminManageVO adminManageVO) throws Exception {
		delete("adminManageDAO.doDeleteAuth", adminManageVO);
	}

	public void doUpdateAuth(AdminManageVO adminManageVO) throws Exception {
		update("adminManageDAO.doUpdateAuth", adminManageVO);
	}

	public String checkAdminInfo(AdminManageVO adminManageVO) throws Exception {
		return selectOne("adminManageDAO.checkAdminInfo", adminManageVO);
	}

	public void doUpdateLock(AdminManageVO adminManageVO) throws Exception {
		update("adminManageDAO.doUpdateLock", adminManageVO);
	}

}
