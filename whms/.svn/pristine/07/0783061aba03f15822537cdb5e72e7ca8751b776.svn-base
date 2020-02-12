package egovframework.whms.sm.userReport.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.sm.userReport.service.UserReportService;
import egovframework.whms.sm.userReport.service.UserReportVO;

@Service("userReportService")
public class UserReportServiceImpl extends EgovAbstractServiceImpl implements UserReportService {

	@Resource(name="userReportDAO")
	private UserReportDAO userReportDAO;

	public List<UserReportVO> selectDataList(UserReportVO userReportVO) throws Exception {
		List<UserReportVO> list = userReportDAO.selectDataList(userReportVO);
		CryptoUtil util = new CryptoUtil();
		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				UserReportVO vo = list.get(i);
				String healthId = vo.getUsrId();
				String masterKey = util.encryptSHA256(healthId);
				//String decryptData1 = "";
				String decryptData2 = "";
				String decryptData3 = "";
				//decryptData1 = vo.getUsrNm() == null ? "" : util.decryptAES128(masterKey, vo.getUsrNm()) == null ? "" : util.decryptAES128(masterKey, vo.getUsrNm());
				decryptData2 = vo.getConnTelno() == null ? "" : util.decryptAES128(masterKey, vo.getConnTelno()) == null ? "" : util.decryptAES128(masterKey, vo.getConnTelno());
				decryptData3 = vo.getBirDt() == null ? "" : util.decryptAES128(masterKey, vo.getBirDt()) == null ? "" : util.decryptAES128(masterKey, vo.getBirDt());
				if(!"".equals(decryptData2) && decryptData2 != null) {
					if(decryptData2.length() == 10) {
						decryptData2 = decryptData2.substring(0,3) + "-" + decryptData2.substring(3,6) + "-" + decryptData2.substring(6, 10);
					}
					if(decryptData2.length() == 11) {
						decryptData2 = decryptData2.substring(0,3) + "-" + decryptData2.substring(3,7) + "-" + decryptData2.substring(7, 11);
					}
				}
				if(!"".equals(decryptData3) && decryptData3 != null) {
					if(decryptData3.length() == 8) {
						decryptData3 = decryptData3.substring(0,4) + "-" + decryptData3.substring(4,6) + "-" + decryptData3.substring(6, 8);
					}
				}
				//vo.setUsrNm(decryptData1);
				vo.setConnTelno(decryptData2);
				vo.setBirDt(decryptData3);
			}
		}
		return list;
	}

}
