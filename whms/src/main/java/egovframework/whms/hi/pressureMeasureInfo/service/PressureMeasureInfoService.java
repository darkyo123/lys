package egovframework.whms.hi.pressureMeasureInfo.service;

import java.util.List;

public interface PressureMeasureInfoService {
	public PressureMeasureInfoVO selectPressureMeasureInfo(PressureMeasureInfoVO pressureMeasureInfo) throws Exception;
	public List<PressureInfoVO> selectMonthList() throws Exception;
	public void pressureMeasureConvert() throws Exception;
	public void basicMedInfoConvert() throws Exception;
}