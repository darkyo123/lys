package egovframework.whms.hi.basicMedInfo.service.impl;

import java.util.Date;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.basicMedInfo.service.BasicMedInfoService;
import egovframework.whms.hi.basicMedInfo.service.BasicMedInfoVO;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureInfoVO;
import egovframework.whms.hi.pressureMeasureInfo.service.impl.PressureMeasureInfoDAO;

@Service("basicMedInfoService")
public class BasicMedInfoServiceImpl extends EgovAbstractServiceImpl implements BasicMedInfoService {

	@Resource(name="basicMedInfoDAO")
	private BasicMedInfoDAO basicMedInfoDAO;

	@Resource(name="pressureMeasureInfoDAO")
	private PressureMeasureInfoDAO pressureMeasureInfoDAO;

	public BasicMedInfoVO selectBasicMedInfo(BasicMedInfoVO basicMedInfoVO) throws Exception {
		BasicMedInfoVO detailVO = basicMedInfoDAO.selectBasicMedInfo(basicMedInfoVO);
		/*if(detailVO != null) {		// 가족력 계산
			int fahs1Yn = "Y".equals(EgovStringUtil.isNullToString(detailVO.getFahs1Yn())) ? 1 : 0;
			int fahs2Yn = "Y".equals(EgovStringUtil.isNullToString(detailVO.getFahs2Yn())) ? 1 : 0;
			int fahs3Yn = "Y".equals(EgovStringUtil.isNullToString(detailVO.getFahs3Yn())) ? 1 : 0;
			int fahs4Yn = "Y".equals(EgovStringUtil.isNullToString(detailVO.getFahs4Yn())) ? 1 : 0;
			int fahs5Yn = "Y".equals(EgovStringUtil.isNullToString(detailVO.getFahs5Yn())) ? 1 : 0;
			int fahs6Yn = "Y".equals(EgovStringUtil.isNullToString(detailVO.getFahs6Yn())) ? 1 : 0;
			int result = fahs1Yn + fahs2Yn + fahs3Yn + fahs4Yn + fahs5Yn + fahs6Yn;
			detailVO.setFahsCalcVal(result == 0 ? "N" : "Y");
		}*/
		if(detailVO != null) {
			CryptoUtil util = new CryptoUtil();
			String healthId = detailVO.getUsrId();
			String masterKey = util.encryptSHA256(healthId);
	
			//String decryptData1 = util.decryptAES128(masterKey, detailVO.getUsrNm()) == null ? "" : util.decryptAES128(masterKey, detailVO.getUsrNm());
			String decryptData2 = util.decryptAES128(masterKey, detailVO.getConnTelno()) == null ? "" : util.decryptAES128(masterKey, detailVO.getConnTelno());
			String decryptData3 = util.decryptAES128(masterKey, detailVO.getBirDt()) == null ? "" : util.decryptAES128(masterKey, detailVO.getBirDt());

			String decryptData4 = util.decryptAES128(masterKey, detailVO.getHypctCt()) == null ? "" : util.decryptAES128(masterKey, detailVO.getHypctCt());
			String decryptData5 = util.decryptAES128(masterKey, detailVO.getHyprxCt()) == null ? "" : util.decryptAES128(masterKey, detailVO.getHyprxCt());
			String decryptData6 = util.decryptAES128(masterKey, detailVO.getPlsCt()) == null ? "" : util.decryptAES128(masterKey, detailVO.getPlsCt());

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
			detailVO.setHypctCt(decryptData4);
			detailVO.setHyprxCt(decryptData5);
			detailVO.setPlsCt(decryptData6);
		}
		return detailVO;
	}

	public String doSave(BasicMedInfoVO basicMedInfoVO) throws Exception {
		String result = "N";
		try {
			CryptoUtil util = new CryptoUtil();
			String healthId = basicMedInfoVO.getUsrId();
			String masterKey = util.encryptSHA256(healthId);

			//String decryptData1 = util.encryptAES128(masterKey, basicMedInfoVO.getUsrNm()) == null ? "" : util.encryptAES128(masterKey, basicMedInfoVO.getUsrNm());
			String decryptData2 = util.encryptAES128(masterKey, basicMedInfoVO.getConnTelno()) == null ? "" : util.encryptAES128(masterKey, basicMedInfoVO.getConnTelno());
			String decryptData3 = util.encryptAES128(masterKey, basicMedInfoVO.getBirDt()) == null ? "" : util.encryptAES128(masterKey, basicMedInfoVO.getBirDt());

			//basicMedInfoVO.setUsrNm(decryptData1);
			basicMedInfoVO.setUsrNm(basicMedInfoVO.getUsrNm());
			basicMedInfoVO.setConnTelno(decryptData2);
			basicMedInfoVO.setBirDt(decryptData3);

			basicMedInfoVO.setUsrHet(basicMedInfoVO.getUsrHet() == null || "".equals(basicMedInfoVO.getUsrHet()) ? "0" : basicMedInfoVO.getUsrHet());
			basicMedInfoVO.setUsrWet(basicMedInfoVO.getUsrWet() == null || "".equals(basicMedInfoVO.getUsrWet()) ? "0" : basicMedInfoVO.getUsrWet());
			basicMedInfoVO.setBmiCt(basicMedInfoVO.getBmiCt() == null || "".equals(basicMedInfoVO.getBmiCt()) ? "0" : basicMedInfoVO.getBmiCt());

			String lstChkDt = EgovStringUtil.isNullToString(basicMedInfoVO.getLstChkDt());

			String highVal = basicMedInfoVO.getHypctCt();
			String lowVal = basicMedInfoVO.getHyprxCt();
			String pulseVal = basicMedInfoVO.getPlsCt();

			BasicMedInfoVO detailVO = basicMedInfoDAO.selectBasicMedInfo(basicMedInfoVO);

			if("".equals(lstChkDt)) {			// 최종측정일이 없을 경우 원본 값 저장
				basicMedInfoVO.setHypctCt(detailVO.getHypctCt());
				basicMedInfoVO.setHyprxCt(detailVO.getHyprxCt());
				basicMedInfoVO.setPlsCt(detailVO.getPlsCt());
				basicMedInfoVO.setLstChkDt(detailVO.getLstChkDt());
			} else {					// 최종 측정일이 있을 경우 새 값
				PressureInfoVO pressureVO = new PressureInfoVO();
				pressureVO.setLoginId(basicMedInfoVO.getUpdId());
				pressureVO.setUseGrpCd(basicMedInfoVO.getUseGrpCd());
				pressureVO.setUsrId(basicMedInfoVO.getUsrId());
				pressureVO.setChkDtm(lstChkDt);
				String chkResult = pressureMeasureInfoDAO.pressureInfoCheck(pressureVO);

	    		String encVal_high = util.encryptAES128(masterKey, highVal) == null ? "" : util.encryptAES128(masterKey, highVal);
	    		String encVal_low = util.encryptAES128(masterKey, lowVal) == null ? "" : util.encryptAES128(masterKey, lowVal);
	    		String encVal_pulse = util.encryptAES128(masterKey, pulseVal) == null ? "" : util.encryptAES128(masterKey, pulseVal);

				pressureVO.setHypctCt(encVal_high);
				pressureVO.setHyprxCt(encVal_low);
				pressureVO.setPlsCt(encVal_pulse);

				if("0".equals(chkResult)) {			// 최종 데이터가 없으면
					pressureMeasureInfoDAO.doRegistPressure(pressureVO);
				} else {											// 최종 데이터가 있으면
					pressureMeasureInfoDAO.doUpdatePressure(pressureVO);
				}

				String preDate = detailVO.getLstChkDt();
				com.ibm.icu.text.SimpleDateFormat format = new com.ibm.icu.text.SimpleDateFormat("yyyy-MM-dd");
				if(preDate == null) {
					;
				} else {
					Date preVal = format.parse(preDate);
					Date currVal = format.parse(lstChkDt);
	
					long calcDate = currVal.getTime() - preVal.getTime();
					if(calcDate >= 0) {
						basicMedInfoVO.setHypctCt(encVal_high);
						basicMedInfoVO.setHyprxCt(encVal_low);
						basicMedInfoVO.setPlsCt(encVal_pulse);
						basicMedInfoVO.setLstChkDt(lstChkDt);
					} else {
						basicMedInfoVO.setHypctCt(highVal);
						basicMedInfoVO.setHyprxCt(lowVal);
						basicMedInfoVO.setPlsCt(pulseVal);
						basicMedInfoVO.setLstChkDt(preDate);
					}
				}
			}

			if(basicMedInfoVO.getHypctCt() != null) {
				if(Double.valueOf(highVal) >= 160
					|| Double.valueOf(lowVal) >= 100 ) {
					basicMedInfoVO.setHighDgrCd("21");
				} else if(Double.valueOf(highVal) >= 150
						|| Double.valueOf(lowVal) >= 95 ) {
					basicMedInfoVO.setHighDgrCd("22");
				} else if(Double.valueOf(highVal) >= 140
						|| Double.valueOf(lowVal) >= 90 ) {
					basicMedInfoVO.setHighDgrCd("23");
				} else if(Double.valueOf(highVal) < 140
						|| Double.valueOf(lowVal) < 90 ) {
					basicMedInfoVO.setHighDgrCd("24");
				}
			}

			if("Y".equals(basicMedInfoVO.getHavdisYn())) {
				basicMedInfoVO.setHavdis1Yn("N");
				basicMedInfoVO.setHavdis2Yn("N");
				basicMedInfoVO.setHavdis3Yn("N");
				basicMedInfoVO.setHavdis4Yn("N");
				basicMedInfoVO.setHavdis5Yn("N");
				basicMedInfoVO.setHavdis6Yn("N");
				basicMedInfoVO.setHavdis7Yn("N");
				basicMedInfoVO.setHavdis8Yn("N");
			}

			if("Y".equals(basicMedInfoVO.getHavdis8Yn()) || "Y".equals(basicMedInfoVO.getHavdis4Yn()) || "Y".equals(basicMedInfoVO.getHavdis5Yn())) {
				basicMedInfoVO.setHighDgrCd("21");
			}

			basicMedInfoDAO.doSaveUser(basicMedInfoVO);
			basicMedInfoDAO.doSaveHlth(basicMedInfoVO);

			result = "Y";
		} catch (Exception e) {
			e.printStackTrace();
			result = "N";
		}
		return result;
	}

}
