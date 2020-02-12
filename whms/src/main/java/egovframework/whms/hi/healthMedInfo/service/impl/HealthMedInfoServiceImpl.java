package egovframework.whms.hi.healthMedInfo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.healthMedInfo.service.HealthMedInfoService;
import egovframework.whms.hi.healthMedInfo.service.HealthMedInfoVO;

@Service("healthMedInfoService")
public class HealthMedInfoServiceImpl extends EgovAbstractServiceImpl implements HealthMedInfoService {

	@Resource(name="healthMedInfoDAO")
	private HealthMedInfoDAO healthMedInfoDAO;

	public HealthMedInfoVO selectHealthMedInfo(HealthMedInfoVO healthMedInfoVO) throws Exception {

		HealthMedInfoVO detailVO = healthMedInfoDAO.selectHealthMedInfo(healthMedInfoVO);

		if(detailVO != null) {
			CryptoUtil util = new CryptoUtil();
			String healthId = detailVO.getUsrId();
			String masterKey = util.encryptSHA256(healthId);
	
			//String decryptData1 = detailVO.getUsrNm() == null ? "" : util.decryptAES128(masterKey, detailVO.getUsrNm()) == null ? "" : util.decryptAES128(masterKey, detailVO.getUsrNm());
			String decryptData2 = detailVO.getConnTelno() == null ? "" : util.decryptAES128(masterKey, detailVO.getConnTelno()) == null ? "" : util.decryptAES128(masterKey, detailVO.getConnTelno());
			String decryptData3 = detailVO.getBirDt() == null ? "" : util.decryptAES128(masterKey, detailVO.getBirDt()) == null ? "" : util.decryptAES128(masterKey, detailVO.getBirDt());
	
			if(!"".equals(decryptData2)) {
				if(decryptData2.length() == 10) {
					decryptData2 = decryptData2.substring(0,3) + "-" + decryptData2.substring(3,6) + "-" + decryptData2.substring(6, 10);
				}
				if(decryptData2.length() == 11) {
					decryptData2 = decryptData2.substring(0,3) + "-" + decryptData2.substring(3,7) + "-" + decryptData2.substring(7, 11);
				}
			}
	
			if(!"".equals(decryptData3)) {
				if(decryptData3.length() == 8) {
					decryptData3 = decryptData3.substring(0,4) + "-" + decryptData3.substring(4,6) + "-" + decryptData3.substring(6, 8);
				}
			}
	
			//detailVO.setUsrNm(decryptData1);
			detailVO.setConnTelno(decryptData2);
			detailVO.setBirDt(decryptData3);

		}

		return detailVO;
	}

	public List<HealthMedInfoVO> selectDataList(HealthMedInfoVO healthMedInfoVO) throws Exception {

		List<HealthMedInfoVO> list = healthMedInfoDAO.selectDataList(healthMedInfoVO);

		/*CryptoUtil util = new CryptoUtil();

		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				HealthMedInfoVO vo = list.get(i);
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

	public void updateAdditionalData(HealthMedInfoVO healthMedInfoVO) throws Exception {
		healthMedInfoDAO.updateAdditionalData(healthMedInfoVO);
	}

}