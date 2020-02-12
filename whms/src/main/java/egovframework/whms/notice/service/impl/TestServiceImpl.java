package egovframework.whms.notice.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.notice.service.TestService;
import egovframework.whms.notice.service.TestVO;

@Service("testService")
public class TestServiceImpl extends EgovAbstractServiceImpl implements TestService {

	@Resource(name="testDAO")
	private TestDAO testDAO;

	public List<TestVO> selectTestList(TestVO testVO) throws Exception {
		return testDAO.selectTestList(testVO);
	}

	public void doRegistTest(TestVO testVO) throws Exception {
		testDAO.doRegistTest(testVO);
	}

	public TestVO selectTestDetail(TestVO testVO) throws Exception {
		return testDAO.selectTestDetail(testVO);
	}

	public void doUpdateTest(TestVO testVO) throws Exception {
		testDAO.doUpdateTest(testVO);
	}

	public void doDeleteTest(TestVO testVO) throws Exception {
		testDAO.doDeleteTest(testVO);
	}
	
	public void doSaveTest(TestVO testVO) throws Exception {
		String flag = testVO.getFlag();
		if(flag != null) {
			if("I".equals(flag)) {
				testDAO.doRegistTest(testVO);
			} else {
				testDAO.doUpdateTest(testVO);
			}
		}
	}
}
