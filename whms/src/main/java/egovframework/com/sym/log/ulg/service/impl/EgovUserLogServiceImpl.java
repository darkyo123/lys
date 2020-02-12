package egovframework.com.sym.log.ulg.service.impl;

import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.terracotta.agent.repkg.de.schlichtherle.io.File;

import egovframework.com.sym.log.ulg.service.EgovUserLogService;
import egovframework.com.sym.log.ulg.service.UserLog;
import egovframework.com.utl.sim.service.EgovFileTool;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @Class Name : EgovUserLogServiceImpl.java
 * @Description : 사용로그 관리를 위한 서비스 구현 클래스
 * @Modification Information
 *
 *    수정일         수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.   이삼섭        최초생성
 *    2011. 7. 01.   이기하        패키지 분리(sym.log -> sym.log.ulg)
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Service("EgovUserLogService")
public class EgovUserLogServiceImpl extends EgovAbstractServiceImpl implements
	EgovUserLogService {

	@Resource(name="userLogDAO")
	private UserLogDAO userLogDAO;

	/**
	 * 사용자 로그정보를 생성한다.
	 *
	 * @param
	 */
	@Override
	public void logInsertUserLog(String userId, String menuNo, String accessType, String modifyId) throws Exception {
		String userLogPath = "D:\\userLog";
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd", java.util.Locale.KOREA);
		SimpleDateFormat dateFormatTime = new SimpleDateFormat("yyyyMMdd HH:mm:ss", java.util.Locale.KOREA);
		String nowDate = dateFormat.format(new java.util.Date());
		String newTime = dateFormatTime.format(new java.util.Date());
		String newFileNm = userLogPath.concat(File.separator).concat("whms_userlog_").concat(nowDate).concat(".txt");
		if(EgovFileTool.getExistDirectory(userLogPath)) {
			if(!"".equals(EgovFileTool.getFileName(newFileNm))) {
				try {
					FileWriter fileWriter = new FileWriter(newFileNm, true);
					String saveStr = "\n";
					saveStr = saveStr.concat("[").concat(newTime).concat("] ");
					saveStr = saveStr.concat(userId).concat("\t").concat(menuNo).concat("\t").concat(accessType).concat("\t").concat(modifyId);
					fileWriter.write(saveStr);
					fileWriter.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				EgovFileTool.createNewFile(newFileNm);
				try {
					FileWriter fileWriter = new FileWriter(newFileNm, true);
					String saveStr = "";
					saveStr = saveStr.concat("[").concat(newTime).concat("] ");
					saveStr = saveStr.concat(userId).concat("\t").concat(menuNo).concat("\t").concat(accessType).concat("\t").concat(modifyId);
					fileWriter.write(saveStr);
					fileWriter.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else {
			EgovFileTool.createNewDirectory(userLogPath);
			EgovFileTool.createNewFile(newFileNm);
			try {
				FileWriter fileWriter = new FileWriter(newFileNm, true);
				String saveStr = "";
				saveStr = saveStr.concat("[").concat(newTime).concat("] ");
				saveStr = saveStr.concat(userId).concat("\t").concat(menuNo).concat("\t").concat(accessType).concat("\t").concat(modifyId);
				fileWriter.write(saveStr);
				fileWriter.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//userLogDAO.logInsertUserLog();
	}

	/**
	 * 사용자 로그정보 상제정보를 조회한다.
	 *
	 * @param userLog
	 * @return userLog
	 * @throws Exception
	 */
	@Override
	public UserLog selectUserLog(UserLog userLog) throws Exception{

		return userLogDAO.selectUserLog(userLog);
	}

	/**
	 * 사용자 로그정보 목록을 조회한다.
	 *
	 * @param UserLog
	 */
	@Override
	public Map<?, ?> selectUserLogInf(UserLog userLog) throws Exception {
		List<?> _result = userLogDAO.selectUserLogInf(userLog);
		int _cnt = userLogDAO.selectUserLogInfCnt(userLog);

		Map<String, Object> _map = new HashMap<String, Object>();
		_map.put("resultList", _result);
		_map.put("resultCnt", Integer.toString(_cnt));

		return _map;
	}

}
