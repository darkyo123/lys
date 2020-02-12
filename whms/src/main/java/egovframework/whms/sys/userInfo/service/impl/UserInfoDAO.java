package egovframework.whms.sys.userInfo.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.whms.sys.userInfo.service.UserInfoVO;

@Repository("userInfoDAO")
public class UserInfoDAO extends EgovComAbstractDAO {

	public List<UserInfoVO> selectDataList(UserInfoVO searchVO) throws Exception {
        return selectList("userInfoDAO.selectDataList", searchVO);
    }

	public List<UserInfoVO> selectPwdList(UserInfoVO searchVO) throws Exception {
        return selectList("userInfoDAO.selectPwdList", searchVO);
    }

	public EgovMap checkPwd(UserInfoVO searchVO) throws Exception {
        return selectOne("userInfoDAO.checkPwd", searchVO);
    }

	public void updatePwd(UserInfoVO searchVO) throws Exception {
        update("userInfoDAO.updatePwd", searchVO);
    }

	public void insertPwdHist(UserInfoVO searchVO) throws Exception {
        insert("userInfoDAO.insertPwdHist", searchVO);
    }

	public void updatePwdNew(UserInfoVO searchVO) throws Exception {
        update("userInfoDAO.updatePwdNew", searchVO);
    }	

}
