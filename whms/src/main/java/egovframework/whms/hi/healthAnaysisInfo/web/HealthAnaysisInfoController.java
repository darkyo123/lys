package egovframework.whms.hi.healthAnaysisInfo.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.ulg.service.EgovUserLogService;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.hi.healthAnaysisInfo.service.HealthAnaysisInfoService;
import egovframework.whms.hi.healthAnaysisInfo.service.HealthAnaysisInfoVO;

@Controller
public class HealthAnaysisInfoController {

	@Resource(name = "healthAnaysisInfoService")
	private HealthAnaysisInfoService healthAnaysisInfoService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="EgovUserLogService")
	private EgovUserLogService userLogService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/hi/healthAnaysisInfo.do")
	public String summary( @ModelAttribute("searchVO") HealthAnaysisInfoVO healthAnaysisInfoVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			String message = URLEncoder.encode(egovMessageSource.getMessage("fail.common.login"),"UTF-8");
			return "redirect:/uat/uia/egovLoginUsr.do?message=" + message + "&parentYn=N";
		}

		/** Left Menu List */
		List<?> list_menulist = (List<?>) request.getAttribute("menuList");
		if(list_menulist == null) {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			MenuManageVO menuManageVO = new MenuManageVO();
			menuManageVO.setTmpId(user.getId());
			list_menulist = menuManageService.selectMainMenuLeft(menuManageVO);
		}
		model.addAttribute("list_menulist", list_menulist);
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		if(healthAnaysisInfoVO.getSearchKeyword() != null && !"".equals(healthAnaysisInfoVO.getSearchKeyword())) {

			healthAnaysisInfoVO.setLoginAuthorCd(user.getAuthorCd());
			healthAnaysisInfoVO.setLoginAuthorType(user.getAuthorType());

			HealthAnaysisInfoVO detailVO = healthAnaysisInfoService.selectData(healthAnaysisInfoVO);
			model.addAttribute("detailVO", detailVO);
			userLogService.logInsertUserLog(user.getId(), "healthAnalysisInfo", "R", "");
		}

		return "egovframework/whms/hi/healthAnaysisInfo/healthAnaysisInfo";
	}

}