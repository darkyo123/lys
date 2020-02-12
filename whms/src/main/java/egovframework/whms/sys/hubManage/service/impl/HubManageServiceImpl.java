package egovframework.whms.sys.hubManage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.bi.userManage.service.UserManageVO;
import egovframework.whms.sys.hubManage.service.HubManageService;
import egovframework.whms.sys.hubManage.service.HubManageVO;

@Service("hubManageService")
public class HubManageServiceImpl extends EgovAbstractServiceImpl implements HubManageService {

	@Resource(name="hubManageDAO")
	private HubManageDAO hubManageDAO;

	public List<HubManageVO> selectDataList(HubManageVO hubManageVO) throws Exception {

		List<HubManageVO> list = hubManageDAO.selectDataList(hubManageVO);

		CryptoUtil util = new CryptoUtil();

		if(list != null && list.size() > 0) {
			for(int i=0; i<list.size(); i++) {
				HubManageVO vo = list.get(i);
				String healthId = vo.getUsrId();
				String masterKey = util.encryptSHA256(healthId);

				//String decryptData1 = "";
				String decryptData2 = "";
				String decryptData3 = "";

				try {
					//decryptData1 = vo.getUsrNm() == null ? "" : util.decryptAES128(masterKey, vo.getUsrNm());
					decryptData2 = vo.getConnTelno() == null ? "" : util.decryptAES128(masterKey, vo.getConnTelno());
					decryptData3 = vo.getBirDt() == null ? "" : util.decryptAES128(masterKey, vo.getBirDt());
				} catch (Exception e) {
					//decryptData1 = "";
					decryptData2 = "";
					decryptData3 = "";
				}

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

	public String doSave(HubManageVO hubManageVO) throws Exception {
		String result = "N, 오류가 발생하였습니다.";

		try {

			String usrIds = EgovStringUtil.isNullToString(hubManageVO.getUsrIds());

			if(!"".equals(usrIds)) {
				String[] ids = usrIds.split(",");
				if(ids.length == 1) {
					hubManageVO.setTargetId(usrIds);
					hubManageDAO.doUpdate(hubManageVO);
					hubManageDAO.doUpdateQslt(hubManageVO);
					hubManageDAO.doUpdatePressure(hubManageVO);
					hubManageDAO.doUpdateEdu(hubManageVO);
					hubManageDAO.doUpdateMecku(hubManageVO);
					hubManageDAO.doUpdateAccd(hubManageVO);
				} else {
					for(int i=0; i<ids.length; i++) {
						hubManageVO.setTargetId(ids[i]);
						hubManageDAO.doUpdate(hubManageVO);
						hubManageDAO.doUpdateQslt(hubManageVO);
						hubManageDAO.doUpdatePressure(hubManageVO);
						hubManageDAO.doUpdateEdu(hubManageVO);
						hubManageDAO.doUpdateMecku(hubManageVO);
						hubManageDAO.doUpdateAccd(hubManageVO);
					}
				}
			}

			result = "Y";
		} catch (Exception e) {
			e.printStackTrace();
			result = "N, 데이터 수정 중 오류가 발생하였습니다.";
		}
		return result;
	}
}
