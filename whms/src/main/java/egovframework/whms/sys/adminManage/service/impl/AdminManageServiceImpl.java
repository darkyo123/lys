package egovframework.whms.sys.adminManage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.sys.adminManage.service.AdminManageService;
import egovframework.whms.sys.adminManage.service.AdminManageVO;

@Service("adminManageService")
public class AdminManageServiceImpl extends EgovAbstractServiceImpl implements AdminManageService {

	@Resource(name="adminManageDAO")
	private AdminManageDAO adminManageDAO;

	public List<AdminManageVO> selectDataList(AdminManageVO adminManageVO) throws Exception {
		return adminManageDAO.selectDataList(adminManageVO);
	}

	public void doDelete(AdminManageVO adminManageVO) throws Exception {
		String testIdx = adminManageVO.getTestIdx();
		if(testIdx != null) {
			String[] idxs = testIdx.split(",");
			if(idxs.length == 1) {
				adminManageDAO.doDeleteAuth(adminManageVO);
				adminManageDAO.doDelete(adminManageVO);
			} else {
				for(int i=0; i<idxs.length; i++) {
					adminManageVO.setTestIdx(idxs[i]);
					adminManageDAO.doDeleteAuth(adminManageVO);
					adminManageDAO.doDelete(adminManageVO);					
				}
			}
		}
	}

	public String doSave(AdminManageVO adminManageVO) throws Exception {
		String result = "N, 오류가 발생하였습니다.";
		String flag = adminManageVO.getFlag();
		if(flag != null) {
			if("I".equals(flag)) {
				try {
					String chkResult = adminManageDAO.checkAdminInfo(adminManageVO);
					if("0".equals(chkResult)) {
						String pass = EgovFileScrty.encryptPassword(adminManageVO.getUsrPwd(), EgovStringUtil.isNullToString(adminManageVO.getUserId()));//KISA 보안약점 조치 (2018-10-29, 윤창원)
						adminManageVO.setUsrPwd(pass);
						adminManageDAO.doRegist(adminManageVO);
						adminManageDAO.doRegistAuth(adminManageVO);
						result = "Y";
		    		} else {
		    			result = "N, 기 등록된 ID입니다.";
		    		}
				} catch (Exception e) {
					e.printStackTrace();
					result = "N, 데이터 등록 중 오류가 발생하였습니다.";
				}
			} else {
				try {
					adminManageDAO.doUpdate(adminManageVO);
					adminManageDAO.doUpdateAuth(adminManageVO);
					result = "Y";
				} catch (Exception e) {
					e.printStackTrace();
					result = "N, 데이터 등록 중 오류가 발생하였습니다.";
				}
			}
		}
		return result;
	}

	@Override
	public void doUpdateLock(AdminManageVO adminManageVO) throws Exception {
		String testIdx = adminManageVO.getTestIdx();
		if(testIdx != null) {
			String[] idxs = testIdx.split(",");
			if(idxs.length == 1) {
				adminManageDAO.doUpdateLock(adminManageVO);
			} else {
				for(int i=0; i<idxs.length; i++) {
					adminManageVO.setTestIdx(idxs[i]);
					adminManageDAO.doUpdateLock(adminManageVO);			
				}
			}
		}
	}
}
