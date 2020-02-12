package egovframework.whms.hi.chartTest.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.hi.chartTest.service.ChartTestService;
import egovframework.whms.hi.chartTest.service.ChartTestVO;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureInfoVO;

@Service("chartTestService")
public class ChartTestServiceImpl extends EgovAbstractServiceImpl implements ChartTestService {

	@Resource(name="chartTestDAO")
	private ChartTestDAO chartTestDAO;

	public ChartTestVO selectChartTest() throws Exception {

		ChartTestVO detailVO = new ChartTestVO();
		List<ChartTestVO> dataList = new ArrayList<ChartTestVO>();
		
		List<ChartTestVO> chartTestList = chartTestDAO.selectChartTest();
		System.out.println("chartTestList+"+chartTestList.size());
		if(chartTestList != null && chartTestList.size() > 0) {
			ChartTestVO chartTestData = new ChartTestVO();
			for(int i=0; i<chartTestList.size(); i++) {
				ChartTestVO chartTest = chartTestList.get(i);
				if("21".equals(chartTestList.get(i).getHighDgrCd())) {
					chartTestData.setCnt1(chartTest.getCnt());
					chartTestData.setUsrAgeList(chartTest.getUsrAge());
				}else if("22".equals(chartTestList.get(i).getHighDgrCd())) {
					chartTestData.setCnt2(chartTest.getCnt());
				}else if("23".equals(chartTestList.get(i).getHighDgrCd())) {
					chartTestData.setCnt3(chartTest.getCnt());
				}else if("24".equals(chartTestList.get(i).getHighDgrCd())) {
					chartTestData.setCnt4(chartTest.getCnt());
				}else if(chartTestList.get(i).getHighDgrCd()==null || "".equals(chartTestList.get(i).getHighDgrCd())) {
					chartTestData.setCnt5(chartTest.getCnt());
				}
				if(i%5==0) {
					dataList.add(chartTestData);
					chartTestData = new ChartTestVO();
				}
			}
		}
		System.out.println("dataList+"+dataList.size());
		detailVO.setDetailList(dataList);

		return detailVO;

	}
}
