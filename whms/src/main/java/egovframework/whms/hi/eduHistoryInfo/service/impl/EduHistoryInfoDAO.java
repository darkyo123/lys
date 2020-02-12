package egovframework.whms.hi.eduHistoryInfo.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.eduHistoryInfo.service.EduHistoryInfoVO;

@Repository("eduHistoryInfoDAO")
public class EduHistoryInfoDAO extends EgovComAbstractDAO {

	public List<EduHistoryInfoVO> selectDataList(EduHistoryInfoVO eduHistoryInfoVO) throws Exception {
		return selectList("eduHistoryInfoDAO.selectDataList", eduHistoryInfoVO);
	}

}