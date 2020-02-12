package egovframework.whms.bi.dataUpload.service;

import java.util.List;

import org.json.simple.JSONArray;

public interface DataUploadService {
	public List<DataUploadVO> selectDataList(DataUploadVO dataUploadVO) throws Exception;
	public String dataSave(JSONArray array, String dataType) throws Exception;
}
