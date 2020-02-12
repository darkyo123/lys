package egovframework.whms.hi.pressureMeasureInfo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureInfoVO;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureMeasureInfoService;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureMeasureInfoVO;

@Service("pressureMeasureInfoService")
public class PressureMeasureInfoServiceImpl extends EgovAbstractServiceImpl implements PressureMeasureInfoService {

	@Resource(name="pressureMeasureInfoDAO")
	private PressureMeasureInfoDAO pressureMeasureInfoDAO;

	public PressureMeasureInfoVO selectPressureMeasureInfo(PressureMeasureInfoVO pressureMeasureInfo) throws Exception {

		PressureMeasureInfoVO detailVO = pressureMeasureInfoDAO.selectPressureMeasureInfo(pressureMeasureInfo);

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

			PressureInfoVO vo = new PressureInfoVO();
			vo.setUseGrpCd(detailVO.getUseGrpCd());
			vo.setUsrId(detailVO.getUsrId());
			List<PressureInfoVO> pressureList = pressureMeasureInfoDAO.selectPressureInfoList(vo);
			List<PressureInfoVO> list = pressureMeasureInfoDAO.selectMonthListNew(vo);
			if(pressureList != null && pressureList.size() > 0) {
				for(int i=0; i<pressureList.size(); i++) {
					PressureInfoVO pressure = pressureList.get(i);
					String decHigh = pressure.getHypctCt() == null ? "" : util.decryptAES128(masterKey, pressure.getHypctCt()) == null ? "" : util.decryptAES128(masterKey, pressure.getHypctCt());
					String decLow = pressure.getHyprxCt() == null ? "" : util.decryptAES128(masterKey, pressure.getHyprxCt()) == null ? "" : util.decryptAES128(masterKey, pressure.getHyprxCt());
					String decPlc = pressure.getPlsCt() == null ? "" : util.decryptAES128(masterKey, pressure.getPlsCt()) == null ? "" : util.decryptAES128(masterKey, pressure.getPlsCt());
					pressure.setHypctCt(decHigh);
					pressure.setHyprxCt(decLow);
					pressure.setPlsCt(decPlc);
				}
			}
			detailVO.setDetailList(pressureList);
			//detailVO.setMonthList(pressureMeasureInfoDAO.selectMonthList(vo));
			if(list != null) {
				for(PressureInfoVO innerVO : list) {
					String countVal = innerVO.getCountVal();
					if(!"0".contentEquals(countVal)) {
						String yearVal = innerVO.getYearVal();
						String monthVal = innerVO.getMonthVal();
						String data = yearVal + monthVal;
						int high = 0;
						int low = 0;
						if(pressureList != null && pressureList.size() > 0) {
							for(int i=0; i<pressureList.size(); i++) {
								PressureInfoVO pressure = pressureList.get(i);
								String chkYear = pressure.getChkYear();
								String chkMonth = pressure.getChkMonth();
								String chkData = chkYear + chkMonth;
								String decHigh = pressure.getHypctCt();
								String decLow = pressure.getHyprxCt();
								int highVal = "".contentEquals(decHigh) ? 0 : Integer.parseInt(decHigh);
								int lowVal = "".contentEquals(decHigh) ? 0 : Integer.parseInt(decLow);
								if(data.contentEquals(chkData)) {
									high += highVal;
									low += lowVal;
								}
							}
						}
						double avgHypctCt = high / Integer.parseInt(countVal);
						double avgHyprxCt = low / Integer.parseInt(countVal);
						innerVO.setAvgHypctCt(Double.toString(avgHypctCt));
						innerVO.setAvgHyprxCt(Double.toString(avgHyprxCt));
					}
				}
			}
			detailVO.setMonthList(list);
		}

		return detailVO;

	}

	public List<PressureInfoVO> selectMonthList() throws Exception {
		PressureInfoVO vo = new PressureInfoVO();
		return pressureMeasureInfoDAO.selectMonthList(vo);
	}

	// 기존 혈압 정보 암호화
	public void pressureMeasureConvert() throws Exception {
		List<PressureInfoVO> list = pressureMeasureInfoDAO.selectPressureInfoListFull();
		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				PressureInfoVO vo = list.get(i);
				String originHigh = vo.getHypctCt();
				String originLow = vo.getHyprxCt();
				String originPulse = vo.getPlsCt();

				CryptoUtil util = new CryptoUtil();
				String healthId = vo.getUsrId();
				String masterKey = util.encryptSHA256(healthId);

				String encHigh = null;
				String encLow = null;
				String encPulse = null;

				try {
					if(isInteger(originHigh)) {
						encHigh = util.encryptAES128(masterKey, originHigh) == null ? "" : util.encryptAES128(masterKey, originHigh);
						encLow = util.encryptAES128(masterKey, originLow) == null ? "" : util.encryptAES128(masterKey, originLow);
						encPulse = util.encryptAES128(masterKey, originPulse) == null ? "" : util.encryptAES128(masterKey, originPulse);
					}
	
					if(encHigh != null) {
						vo.setHypctCt(encHigh);
						vo.setHyprxCt(encLow);
						vo.setPlsCt(encPulse);
						vo.setLoginId("whmsadmin");
						pressureMeasureInfoDAO.doUpdatePressure(vo);
					} 
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	public boolean isInteger(String s) throws Exception {
		try {
			Integer.parseInt(s);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public void basicMedInfoConvert() throws Exception {
		List<PressureInfoVO> list = pressureMeasureInfoDAO.selectUserPressureFull();
		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				PressureInfoVO vo = list.get(i);
				String originHigh = vo.getHypctCt();
				String originLow = vo.getHyprxCt();
				String originPulse = vo.getPlsCt();

				CryptoUtil util = new CryptoUtil();
				String healthId = vo.getUsrId();
				String masterKey = util.encryptSHA256(healthId);

				String encHigh = null;
				String encLow = null;
				String encPulse = null;

				try {
					if(isInteger(originHigh)) {
						encHigh = util.encryptAES128(masterKey, originHigh) == null ? "" : util.encryptAES128(masterKey, originHigh);
						encLow = util.encryptAES128(masterKey, originLow) == null ? "" : util.encryptAES128(masterKey, originLow);
						encPulse = util.encryptAES128(masterKey, originPulse) == null ? "" : util.encryptAES128(masterKey, originPulse);
					}
	
					if(encHigh != null) {
						vo.setHypctCt(encHigh);
						vo.setHyprxCt(encLow);
						vo.setPlsCt(encPulse);
						vo.setLoginId("whmsadmin");
						pressureMeasureInfoDAO.doUpdateUserPressure(vo);
					} 
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}
