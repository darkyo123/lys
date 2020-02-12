package egovframework.whms.hi.qslt.service;

import java.util.List;

public interface QsltService {
	public List<QsltVO> selectQsltList(QsltVO qsltVO) throws Exception;
	public List<QsltVO> selectQsltEtcList(QsltVO qsltVO) throws Exception;
	public void doRegistQslt(QsltVO qsltVO) throws Exception;
	public QsltVO selectQsltInfo(QsltVO qsltVO) throws Exception;
	public QsltVO selectQsltDetail(QsltVO qsltVO) throws Exception;
	public String selectQsltDetailByTmpId(QsltVO qsltVO) throws Exception;
	public String selectNewUsrId() throws Exception;
	public void doUpdateQslt(QsltVO qsltVO) throws Exception;
	public void doDeleteQslt(QsltVO qsltVO) throws Exception;
	public void doSaveQslt(QsltVO qsltVO) throws Exception;
	public void doUpdateQsltYnValues(QsltVO qsltVO) throws Exception;
	public void doUpdateQsltYnEtcValues(QsltVO qsltVO) throws Exception;
}
