package egovframework.whms.sys.sysInfo.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.whms.sys.sysInfo.service.SysInfoService;
import egovframework.whms.sys.sysInfo.service.SysInfoVO;

@Service("sysInfoService")
public class SysInfoServiceImpl extends EgovAbstractServiceImpl implements SysInfoService {

	@Resource(name="sysInfoDAO")
	private SysInfoDAO sysInfoDAO;

}
