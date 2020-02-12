package egovframework.whms.sm.userReport.service;

import java.util.List;

import egovframework.whms.sm.userReport.service.UserReportVO;

public interface UserReportService {
	public List<UserReportVO> selectDataList(UserReportVO userReportVO) throws Exception;
}