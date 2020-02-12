package egovframework.whms.hi.healthAnaysisInfo.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.whms.hi.healthAnaysisInfo.service.HealthAnaysisInfoVO;

@Repository("healthAnaysisInfoDAO")
public class HealthAnaysisInfoDAO extends EgovComAbstractDAO {

	public HealthAnaysisInfoVO selectData(HealthAnaysisInfoVO healthAnaysisInfoVO) throws Exception {
		return (HealthAnaysisInfoVO) selectOne("healthAnaysisInfoDAO.selectData", healthAnaysisInfoVO);
	}

}