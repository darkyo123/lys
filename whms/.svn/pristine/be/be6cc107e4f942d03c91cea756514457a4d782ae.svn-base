package egovframework.whms.batch.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.batch.service.BatchService;

/**
 * 배치 작업을 위한 Service 구현체 <br>
 * 19.09.04 <br>
 * @author 오세광 과장
 */
@Service("batchService")
public class BatchServiceImpl extends EgovAbstractServiceImpl implements BatchService {

	@Resource(name="batchDAO")
    private BatchDAO batchDAO;

	public void initLockCount() throws Exception {
		batchDAO.initLockCount();
	}

}
