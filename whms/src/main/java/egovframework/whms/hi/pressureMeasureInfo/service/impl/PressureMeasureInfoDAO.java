package egovframework.whms.hi.pressureMeasureInfo.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureInfoVO;
import egovframework.whms.hi.pressureMeasureInfo.service.PressureMeasureInfoVO;

@Repository("pressureMeasureInfoDAO")
public class PressureMeasureInfoDAO extends EgovComAbstractDAO {

	public PressureMeasureInfoVO selectPressureMeasureInfo(PressureMeasureInfoVO pressureMeasureInfoVO) throws Exception {
		return (PressureMeasureInfoVO) selectOne("pressureMeasureInfoDAO.selectPressureMeasureInfo", pressureMeasureInfoVO);
	}

	public List<PressureInfoVO> selectPressureInfoList(PressureInfoVO vo) throws Exception {
		return selectList("pressureMeasureInfoDAO.selectPressureInfoList", vo);
	}

	public List<PressureInfoVO> selectMonthList(PressureInfoVO vo) throws Exception {
		return selectList("pressureMeasureInfoDAO.selectMonthList", vo);
	}

	public List<PressureInfoVO> selectMonthListNew(PressureInfoVO vo) throws Exception {
		return selectList("pressureMeasureInfoDAO.selectMonthListNew", vo);
	}

	public List<PressureInfoVO> selectPressureInfoListFull() throws Exception {
		return selectList("pressureMeasureInfoDAO.selectPressureInfoListFull", null);
	}

	public List<PressureInfoVO> selectUserPressureFull() throws Exception {
		return selectList("pressureMeasureInfoDAO.selectUserPressureFull", null);
	}

	public String pressureInfoCheck(PressureInfoVO vo) throws Exception {
		return selectOne("pressureMeasureInfoDAO.pressureInfoCheck", vo);
	}

	public void doRegistPressure(PressureInfoVO vo) throws Exception {
		insert("pressureMeasureInfoDAO.doRegistPressure", vo);
	}

	public void doUpdatePressure(PressureInfoVO vo) throws Exception {
		update("pressureMeasureInfoDAO.doUpdatePressure", vo);
	}

	public void doUpdateUserPressure(PressureInfoVO vo) throws Exception {
		update("pressureMeasureInfoDAO.doUpdateUserPressure", vo);
	}
}
