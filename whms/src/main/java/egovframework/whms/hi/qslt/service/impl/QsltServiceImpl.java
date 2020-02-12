package egovframework.whms.hi.qslt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.qslt.service.QsltService;
import egovframework.whms.hi.qslt.service.QsltVO;

@Service("qsltService")
public class QsltServiceImpl extends EgovAbstractServiceImpl implements QsltService {

	@Resource(name="qsltDAO")
	private QsltDAO qsltDAO;

	public List<QsltVO> selectQsltList(QsltVO qsltVO) throws Exception {
		List<QsltVO> list = qsltDAO.selectQsltList(qsltVO);
		/*CryptoUtil util = new CryptoUtil();
		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				QsltVO vo = list.get(i);
				String usrId = vo.getUsrId();
				String masterKey = util.encryptSHA256(usrId);

				String decryptData1 = "";

				try {
					decryptData1 = vo.getUsrNm() == null ? "" : util.decryptAES128(masterKey, vo.getUsrNm()) == null ? "" : util.decryptAES128(masterKey, vo.getUsrNm());
				} catch (Exception e) {
					decryptData1 = "";
				}

				vo.setUsrNm(decryptData1);

			}
		}*/
		return list;
	}

	public List<QsltVO> selectQsltEtcList(QsltVO qsltVO) throws Exception {
		List<QsltVO> list = qsltDAO.selectQsltEtcList(qsltVO);
		return list;
	}

	public void doRegistQslt(QsltVO qsltVO) throws Exception {
		/*CryptoUtil util = new CryptoUtil();
		String usrId = qsltVO.getUsrId();
		String masterKey = util.encryptSHA256(usrId);

		String decryptData1 = qsltVO.getUsrNm() == null ? "" : util.encryptAES128(masterKey, qsltVO.getUsrNm()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getUsrNm());
		qsltVO.setUsrNm( decryptData1 );*/

		qsltDAO.doRegistQslt(qsltVO);
	}

	public QsltVO selectQsltInfo(QsltVO qsltVO) throws Exception {
		QsltVO vo = qsltDAO.selectQsltInfo(qsltVO);
		/*if(vo != null) {
			CryptoUtil util = new CryptoUtil();
	
			String usrId = vo.getUsrId();
			String masterKey = util.encryptSHA256(usrId);
	
			String decryptData1 = "";
	
			try {
				String usrNm = vo.getUsrNm();
				decryptData1 = usrNm == null ? "" : util.decryptAES128(masterKey, usrNm) == null ? "" : util.decryptAES128(masterKey, usrNm);
			} catch (Exception e) {
				decryptData1 = "";
			}
	
			vo.setUsrNm(decryptData1);
		}*/
		return vo;
	}

	public QsltVO selectQsltDetail(QsltVO qsltVO) throws Exception {
		return qsltDAO.selectQsltDetail(qsltVO);
	}

	public String selectQsltDetailByTmpId(QsltVO qsltVO) throws Exception {
		return qsltDAO.selectQsltDetailByTmpId(qsltVO);
	}

	public String selectNewUsrId() throws Exception {
		return qsltDAO.selectNewUsrId();
	}

	public void doUpdateQslt(QsltVO qsltVO) throws Exception {
		/*CryptoUtil util = new CryptoUtil();
		String usrId = qsltVO.getUsrId();
		String masterKey = util.encryptSHA256(usrId);

		String usrNm = qsltVO.getUsrNm();
		String decryptData1 = usrNm == null ? "" : util.encryptAES128(masterKey, usrNm);
		qsltVO.setUsrNm( decryptData1 );*/

		qsltDAO.doUpdateQslt(qsltVO);
	}

	public void doDeleteQslt(QsltVO qsltVO) throws Exception {
		qsltDAO.doDeleteQslt(qsltVO);
	}

	public void doSaveQslt(QsltVO qsltVO) throws Exception {
		String UserId = qsltVO.getUsrId();
		if(UserId == null || "".equals(UserId) ) {
			qsltDAO.doRegistQslt(qsltVO);
		} else {
			qsltDAO.doUpdateQslt(qsltVO);
		}
	}

	@Override
	public void doUpdateQsltYnValues(QsltVO qsltVO) throws Exception {
		qsltDAO.doUpdateQsltYnValues(qsltVO);
	}

	@Override
	public void doUpdateQsltYnEtcValues(QsltVO qsltVO) throws Exception {
		qsltDAO.doUpdateQsltYnEtcValues(qsltVO);
	}
}
