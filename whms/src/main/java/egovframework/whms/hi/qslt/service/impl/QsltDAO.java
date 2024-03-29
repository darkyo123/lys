package egovframework.whms.hi.qslt.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.qslt.service.QsltVO;

@Repository("qsltDAO")
public class QsltDAO extends EgovComAbstractDAO {

	public List<QsltVO> selectQsltList(QsltVO qsltVO) throws Exception {
        return selectList("qsltDAO.selectQsltList", qsltVO);
    }

	public List<QsltVO> selectQsltEtcList(QsltVO qsltVO) throws Exception {
        return selectList("qsltDAO.selectQsltEtcList", qsltVO);
    }

	public void doRegistQslt(QsltVO qsltVO) throws Exception {
		insert("qsltDAO.doRegistQslt", qsltVO);
	}

	public QsltVO selectQsltInfo(QsltVO qsltVO) throws Exception {
		return (QsltVO) selectOne("qsltDAO.selectQsltInfo", qsltVO);
	}

	public QsltVO selectQsltDetail(QsltVO qsltVO) throws Exception {
		return (QsltVO) selectOne("qsltDAO.selectQsltDetail", qsltVO);
	}

	public String selectQsltDetailByTmpId(QsltVO qsltVO) throws Exception {
		return (String) selectOne("qsltDAO.selectQsltDetailByTmpId", qsltVO);
	}

	public String selectNewUsrId() throws Exception {
		return (String) selectOne("qsltDAO.selectNewUsrId");
	}

	public void doUpdateQslt(QsltVO qsltVO) throws Exception {
		update("qsltDAO.doUpdateQslt", qsltVO);
	}

	public void doDeleteQslt(QsltVO qsltVO) throws Exception {
		delete("qsltDAO.doDeleteQslt", qsltVO);
	}

	public void doUpdateQsltYnValues(QsltVO qsltVO) throws Exception {
		update("qsltDAO.doUpdateQsltYnValues", qsltVO);
	}

	public void doUpdateQsltYnEtcValues(QsltVO qsltVO) throws Exception {
		update("qsltDAO.doUpdateQsltYnEtcValues", qsltVO);
	}
}
