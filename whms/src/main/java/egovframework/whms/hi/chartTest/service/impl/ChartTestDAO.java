package egovframework.whms.hi.chartTest.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.chartTest.service.ChartTestVO;

@Repository("chartTestDAO")
public class ChartTestDAO extends EgovComAbstractDAO {

	public List<ChartTestVO> selectChartTest() throws Exception {
		return selectList("chartTestDAO.selectChartTest");
	}

}
