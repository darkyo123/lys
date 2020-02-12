package egovframework.whms.sm.measureItem.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.sm.measureItem.service.MeasureItemVO;

@Repository("measureItemDAO")
public class MeasureItemDAO extends EgovComAbstractDAO {

	public MeasureItemVO selectMeasureItem(MeasureItemVO measureItemVO) throws Exception {
		return (MeasureItemVO) selectOne("measureItemDAO.selectMeasureItem", measureItemVO);
	}

}
