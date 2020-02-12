package egovframework.whms.hi.basicMedInfo.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.basicMedInfo.service.BasicMedInfoVO;

@Repository("basicMedInfoDAO")
public class BasicMedInfoDAO extends EgovComAbstractDAO {

	public BasicMedInfoVO selectBasicMedInfo(BasicMedInfoVO basicMedInfoVO) throws Exception {
		return (BasicMedInfoVO) selectOne("basicMedInfoDAO.selectBasicMedInfo", basicMedInfoVO);
	}

	public void doSaveUser(BasicMedInfoVO basicMedInfoVO) throws Exception {
		update("basicMedInfoDAO.doSaveUser", basicMedInfoVO);
	}

	public void doSaveHlth(BasicMedInfoVO basicMedInfoVO) throws Exception {
		update("basicMedInfoDAO.doSaveHlth", basicMedInfoVO);
	}

}
