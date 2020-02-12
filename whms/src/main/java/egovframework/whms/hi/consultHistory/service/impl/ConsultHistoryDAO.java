package egovframework.whms.hi.consultHistory.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.consultHistory.service.ConsultHistoryVO;

@Repository("consultHistoryDAO")
public class ConsultHistoryDAO extends EgovComAbstractDAO {

	public ConsultHistoryVO selectConsultHistory(ConsultHistoryVO consultHistoryVO) throws Exception {
		return (ConsultHistoryVO) selectOne("consultHistoryDAO.selectConsultHistory", consultHistoryVO);
	}

}
