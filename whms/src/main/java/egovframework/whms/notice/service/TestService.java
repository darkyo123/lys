package egovframework.whms.notice.service;

import java.util.List;

public interface TestService {
	public List<TestVO> selectTestList(TestVO testVO) throws Exception;
	public void doRegistTest(TestVO testVO) throws Exception;
	public TestVO selectTestDetail(TestVO testVO) throws Exception;
	public void doUpdateTest(TestVO testVO) throws Exception;
	public void doDeleteTest(TestVO testVO) throws Exception;
	public void doSaveTest(TestVO testVO) throws Exception;
}
