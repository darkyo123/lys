package egovframework.whms.batch.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import egovframework.whms.batch.service.BatchService;

/**
 * 배치 작업을 위한 Controller <br>
 * 19.09.04
 * @author 오세광 과장
 */
@Controller
public class BatchController {

	/** Batch Service */
	@Resource(name = "batchService")
	BatchService batchService;

	/**
	 * 사용자 패스워드 실패 횟수 초기화 (매일 12시 1번) <br>
	 * Parameter - null <br>
	 * Return null
	 */
	public void initLockCount() throws Exception {
		try {
			batchService.initLockCount();
		} catch (Exception e) {
			System.out.println("initLockCount batch error");
			e.printStackTrace();
		}
	}

}
