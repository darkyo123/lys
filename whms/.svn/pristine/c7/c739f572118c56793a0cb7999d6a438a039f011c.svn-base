package egovframework.whms.hi.summary.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.summary.service.SummaryVO;

@Repository("summaryDAO")
public class SummaryDAO extends EgovComAbstractDAO {

	public SummaryVO selectSummaryInfo(SummaryVO summaryVO) throws Exception {
		return (SummaryVO) selectOne("summaryDAO.selectSummaryInfo", summaryVO);
	}

	public SummaryVO selectPressureInfo(SummaryVO summaryVO) throws Exception {
		return (SummaryVO) selectOne("summaryDAO.selectPressureInfo", summaryVO);
	}

	public SummaryVO selectBrdevlInfo(SummaryVO summaryVO) throws Exception {
		return (SummaryVO) selectOne("summaryDAO.selectBrdevlInfo", summaryVO);
	}

	public List<SummaryVO> selectUserList(SummaryVO summaryVO) throws Exception {
		return selectList("summaryDAO.selectUserList", summaryVO);
	}

}
