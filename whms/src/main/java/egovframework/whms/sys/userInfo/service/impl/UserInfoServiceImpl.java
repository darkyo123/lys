package egovframework.whms.sys.userInfo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.whms.sys.userInfo.service.UserInfoService;
import egovframework.whms.sys.userInfo.service.UserInfoVO;

@Service("userInfoService")
public class UserInfoServiceImpl extends EgovAbstractServiceImpl implements UserInfoService {

	@Resource(name="userInfoDAO")
	private UserInfoDAO userInfoDAO;

	@Override
	public List<UserInfoVO> selectDataList(UserInfoVO searchVO) throws Exception {
		return userInfoDAO.selectDataList(searchVO);
	}

	@Override
	public String pwdChange(UserInfoVO searchVO) throws Exception {
		String result = null;

		String enpassword = EgovFileScrty.encryptPassword(searchVO.getUserPw(), searchVO.getLoginId());
		searchVO.setUserPw(enpassword);

		EgovMap resultMap = userInfoDAO.checkPwd(searchVO);

		if(resultMap != null) {
			String lstPwdDt = EgovStringUtil.isNullToString(resultMap.get("lstPwdDt"));
			if(!"".contentEquals(lstPwdDt)) {
				if(!EgovDateUtil.checkWriteableDate(lstPwdDt, 1)) {
					result = "N";
				} else {
					enpassword = EgovFileScrty.encryptPassword(searchVO.getUserPwNew(), searchVO.getLoginId());
					searchVO.setUserPwNew(enpassword);
					List<UserInfoVO> pwdList = userInfoDAO.selectPwdList(searchVO);
					if(pwdList != null && pwdList.size() > 0) {
						int cnt = 0;
						for(UserInfoVO vo : pwdList) {
							if(enpassword.contentEquals(vo.getUserPw())) {
								cnt++;
							}
						}
						if(cnt != 0) {
							result = "D";
						} else {
							userInfoDAO.updatePwd(searchVO);
							userInfoDAO.insertPwdHist(searchVO);
							result = "Y";
						}
					} else {
						userInfoDAO.updatePwd(searchVO);
						userInfoDAO.insertPwdHist(searchVO);
						result = "Y";
					}
				}
			} else {
				enpassword = EgovFileScrty.encryptPassword(searchVO.getUserPwNew(), searchVO.getLoginId());
				searchVO.setUserPwNew(enpassword);
				userInfoDAO.updatePwd(searchVO);
				userInfoDAO.insertPwdHist(searchVO);
				result = "Y";
			}
		}

		return result;
	}

	@Override
	public String pwdChangeNew(UserInfoVO searchVO) throws Exception {
		String enpassword = EgovFileScrty.encryptPassword(searchVO.getUserPw(), searchVO.getLoginId());
		searchVO.setUserPwNew(enpassword);
		userInfoDAO.updatePwdNew(searchVO);
		return "Y";
	}

}