package egovframework.whms.hi.eduHistoryInfo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.eduHistoryInfo.service.EduHistoryInfoService;
import egovframework.whms.hi.eduHistoryInfo.service.EduHistoryInfoVO;

@Service("eduHistoryInfoService")
public class EduHistoryInfoServiceImpl extends EgovAbstractServiceImpl implements EduHistoryInfoService {

	@Resource(name="eduHistoryInfoDAO")
	private EduHistoryInfoDAO eduHistoryInfoDAO;

	public List<EduHistoryInfoVO> selectDataList(EduHistoryInfoVO eduHistoryInfoVO) throws Exception {
		List<EduHistoryInfoVO> list = eduHistoryInfoDAO.selectDataList(eduHistoryInfoVO);

		/*CryptoUtil util = new CryptoUtil();

		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				EduHistoryInfoVO vo = list.get(i);
				String healthId = vo.getUsrId();
				String masterKey = util.encryptSHA256(healthId);

				String decryptData1 = "";

				try {
					decryptData1 = vo.getUsrNm() == null ? "" : util.decryptAES128(masterKey, vo.getUsrNm());
				} catch (Exception e) {
					decryptData1 = "";
				}

				vo.setUsrNm(decryptData1);

			}
		}*/

		return list;
	}

}