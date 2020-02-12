package egovframework.whms.hi.summary.service;

import java.util.List;

public interface SummaryService {
	public SummaryVO selectSummaryInfo(SummaryVO summaryVO) throws Exception;
	public List<SummaryVO> selectUserList(SummaryVO summaryVO) throws Exception;
}