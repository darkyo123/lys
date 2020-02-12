package egovframework.whms.sm.userReport.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.sm.userReport.service.UserReportVO;

@Repository("userReportDAO")
public class UserReportDAO extends EgovComAbstractDAO {

	public List<UserReportVO> selectDataList(UserReportVO userReportVO) throws Exception {
		return selectList("userReportDAO.selectDataList" ,userReportVO);
	}
	
}
