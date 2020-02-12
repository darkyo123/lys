package egovframework.whms.bi.dataUpload.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.bi.dataUpload.service.DataUploadVO;
import egovframework.whms.bi.userManage.service.UserManageVO;
import egovframework.whms.hi.eduHistoryInfo.service.EduHistoryInfoVO;
import egovframework.whms.hi.healthMedInfo.service.HealthMedInfoVO;

@Repository("dataUploadDAO")
public class DataUploadDAO extends EgovComAbstractDAO {

	public List<DataUploadVO> selectDataList(DataUploadVO dataUploadVO) throws Exception {
        return selectList("dataUploadDAO.selectDataList", dataUploadVO);
    }

	public int doSaveUser(UserManageVO umv) throws Exception {
		return insert("dataUploadDAO.doSaveUser", umv);
	}

	public int doCheckUser(UserManageVO vo) throws Exception {
		return selectOne("dataUploadDAO.doCheckUser", vo);
	}

	public int doRegistHealthInfo(HealthMedInfoVO vo) throws Exception {
		return insert("dataUploadDAO.doRegistHealthInfo", vo);
	}

	public int doUpdateHealthInfo(HealthMedInfoVO vo) throws Exception {
		return update("dataUploadDAO.doUpdateHealthInfo", vo);
	}

	public int doCheckHealthInfo(HealthMedInfoVO vo) throws Exception {
		return selectOne("dataUploadDAO.doCheckHealthInfo", vo);
	}

	public int doCheckCode(UserManageVO vo) throws Exception {
		return selectOne("dataUploadDAO.doCheckCode", vo);
	}

	public int doRegistEduInfo(EduHistoryInfoVO vo) throws Exception {
		return insert("dataUploadDAO.doRegistEduInfo", vo);
	}

	public int doUpdateEduInfo(EduHistoryInfoVO vo) throws Exception {
		return update("dataUploadDAO.doUpdateEduInfo", vo);
	}

	public int doCheckEduInfo(EduHistoryInfoVO vo) throws Exception {
		return selectOne("dataUploadDAO.doCheckEduInfo", vo);
	}

}
