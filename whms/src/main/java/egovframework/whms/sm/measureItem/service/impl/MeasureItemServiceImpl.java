package egovframework.whms.sm.measureItem.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.sm.measureItem.service.MeasureItemService;
import egovframework.whms.sm.measureItem.service.MeasureItemVO;

@Service("measureItemService")
public class MeasureItemServiceImpl extends EgovAbstractServiceImpl implements MeasureItemService {

	@Resource(name="measureItemDAO")
	private MeasureItemDAO measureItemDAO;

	public MeasureItemVO selectMeasureItem(MeasureItemVO measureItem) throws Exception {

		MeasureItemVO detailVO = measureItemDAO.selectMeasureItem(measureItem);

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

//			vo.setUseGrpCd(detailVO.getUseGrpCd());
//			vo.setUsrId(detailVO.getUsrId());
//			detailVO.setDetailList(measureItemDAO.selectPressureInfoList(vo));
//			detailVO.setMonthList(measureItemDAO.selectMonthList(vo));
		}

		return detailVO;

	}

}
