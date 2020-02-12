package egovframework.whms.notice.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.notice.service.TestVO;

@Repository("testDAO")
public class TestDAO extends EgovComAbstractDAO {

	public List<TestVO> selectTestList(TestVO testVO) throws Exception {
        return selectList("testDAO.selectTestList", testVO);
    }

	public void doRegistTest(TestVO testVO) throws Exception {
		insert("testDAO.doRegistTest", testVO);
	}

	public TestVO selectTestDetail(TestVO testVO) throws Exception {
		return (TestVO) selectOne("testDAO.selectTestDetail", testVO);
	}

	public void doUpdateTest(TestVO testVO) throws Exception {
		update("testDAO.doUpdateTest", testVO);
	}

	public void doDeleteTest(TestVO testVO) throws Exception {
		delete("testDAO.doDeleteTest", testVO);
	}
}
