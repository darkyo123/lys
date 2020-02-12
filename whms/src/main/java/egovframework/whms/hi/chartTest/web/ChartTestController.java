package egovframework.whms.hi.chartTest.web;

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
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.hi.chartTest.service.ChartTestService;
import egovframework.whms.hi.chartTest.service.ChartTestVO;

@Controller
public class ChartTestController {

	@Resource(name = "chartTestService")
	private ChartTestService chartTestService;

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
	@RequestMapping(value="/whms/hi/pressureMeasureInfo.do")
	public String basicMedInfo( @ModelAttribute("searchVO") ChartTestVO chartTestVO
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
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if(list_menulist == null) {
			MenuManageVO menuManageVO = new MenuManageVO();
			menuManageVO.setTmpId(user.getId());
			list_menulist = menuManageService.selectMainMenuLeft(menuManageVO);
		}
		model.addAttribute("list_menulist", list_menulist);

		String paramId = EgovStringUtil.isNullToString(request.getParameter("paramId"));

		if(!"".equals(paramId)) {
			chartTestVO.setSearchCondition("USR_ID");
			chartTestVO.setSearchKeyword(paramId);
		}

		model.addAttribute("monthList", "");

		model.addAttribute("detailVO", chartTestService.selectChartTest());
		userLogService.logInsertUserLog(user.getId(), "chartTest", "R", "");

		return "egovframework/whms/hi/chartTest/chartTest";
	}

}