package egovframework.whms.hi.healthAnaysisInfo.service.impl;

import java.util.Calendar;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.healthAnaysisInfo.service.HealthAnaysisInfoService;
import egovframework.whms.hi.healthAnaysisInfo.service.HealthAnaysisInfoVO;

@Service("healthAnaysisInfoService")
public class HealthAnaysisInfoServiceImpl extends EgovAbstractServiceImpl implements HealthAnaysisInfoService {

	@Resource(name="healthAnaysisInfoDAO")
	private HealthAnaysisInfoDAO healthAnaysisInfoDAO;

	public HealthAnaysisInfoVO selectData(HealthAnaysisInfoVO healthAnaysisInfoVO) throws Exception {
		HealthAnaysisInfoVO data = healthAnaysisInfoDAO.selectData(healthAnaysisInfoVO);

		if(data != null) {
			CryptoUtil util = new CryptoUtil();
	
			String healthId = data.getUsrId();
			String masterKey = util.encryptSHA256(healthId);
	
			String decryptData1 = "";
			try {
				decryptData1 = data.getBirDt() == null ? "" : util.decryptAES128(masterKey, data.getBirDt());
			} catch (Exception e) {
				decryptData1 = "";
			}

			data.setUsrAge("");
			if(! "".equals(decryptData1)) {
	
		        Calendar current = Calendar.getInstance();
		        int currentYear  = current.get(Calendar.YEAR);
		        int currentMonth = current.get(Calendar.MONTH) + 1;
		        int currentDay   = current.get(Calendar.DAY_OF_MONTH);
		        
		        int usrBirYear  = Integer.parseInt(decryptData1.substring(0,4));
		        int usrBirMonth = Integer.parseInt(decryptData1.substring(4,6)); 
		        int usrBirDay   = Integer.parseInt(decryptData1.substring(6,8)); 
		        int age = currentYear - usrBirYear;
		        if (usrBirMonth * 100 + usrBirDay > currentMonth * 100 + currentDay) 
		        	age--;
		        
		        data.setUsrAge(age+"");
			}

			if(!"".equals(decryptData1)) {
				if(decryptData1.length() == 8) {
					decryptData1 = decryptData1.substring(0,4) + "-" + decryptData1.substring(4,6) + "-" + decryptData1.substring(6, 8);
				}
			}

			data.setBirDt(decryptData1);

			try {
				decryptData1 = data.getConnTelNo() == null ? "" : util.decryptAES128(masterKey, data.getConnTelNo());
			} catch (Exception e) {
				decryptData1 = "";
			}

			if(!"".equals(decryptData1)) {
				if(decryptData1.length() == 10) {
					decryptData1 = decryptData1.substring(0,3) + "-" + decryptData1.substring(3,6) + "-" + decryptData1.substring(6, 10);
				}
				if(decryptData1.length() == 11) {
					decryptData1 = decryptData1.substring(0,3) + "-" + decryptData1.substring(3,7) + "-" + decryptData1.substring(7, 11);
				}
			}

			data.setConnTelNo(decryptData1);

			String usrHet = data.getUsrHet();
			String usrWet = data.getUsrWet();

			double het = usrHet == null ? 0 : Double.parseDouble(usrHet);
			double wet = usrWet == null ? 0 : Double.parseDouble(usrWet);
			double hetCal = het / 100;

			double bmi = hetCal == 0 ? 0 : ((int)(wet / (hetCal * hetCal)*100))*0.01;
			data.setBmi(Double.toString(bmi));

			String decHigh = data.getHypctCt() == null ? "" : util.decryptAES128(masterKey, data.getHypctCt()) == null ? "" : util.decryptAES128(masterKey, data.getHypctCt());
			String decLow = data.getHyprxCt() == null ? "" : util.decryptAES128(masterKey, data.getHyprxCt()) == null ? "" : util.decryptAES128(masterKey, data.getHyprxCt());
			data.setHypctCt(decHigh);
			data.setHyprxCt(decLow);

			String decFahs = data.getFahsYn() == null ? "" : util.decryptAES128(masterKey, data.getFahsYn()) == null ? "" : util.decryptAES128(masterKey, data.getFahsYn()).substring(0,1);
			String decHavdis = data.getHavdisYn() == null ? "" : util.decryptAES128(masterKey, data.getHavdisYn()) == null ? "" : util.decryptAES128(masterKey, data.getHavdisYn()).substring(0,1);
			data.setFahsYn(decFahs);
			data.setHavdisYn(decHavdis);

		}

		return data;
	}

}