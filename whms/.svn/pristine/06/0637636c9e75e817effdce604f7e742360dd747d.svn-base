package egovframework.whms.hi.healthMedInfo.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.healthMedInfo.service.HealthMedInfoVO;

@Repository("healthMedInfoDAO")
public class HealthMedInfoDAO extends EgovComAbstractDAO {

	public HealthMedInfoVO selectHealthMedInfo(HealthMedInfoVO healthMedInfoVO) throws Exception {
		return selectOne("healthMedInfoDAO.selectHealthMedInfo", healthMedInfoVO);
	}

	public List<HealthMedInfoVO> selectDataList(HealthMedInfoVO healthMedInfoVO) throws Exception {
		return selectList("healthMedInfoDAO.selectDataList" ,healthMedInfoVO);
	}

	public void updateAdditionalData(HealthMedInfoVO healthMedInfoVO) throws Exception {
		update("healthMedInfoDAO.updateAdditionalData", healthMedInfoVO);
	}

}
