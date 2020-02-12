package egovframework.whms.sm.userReport.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.ulg.service.EgovUserLogService;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.sm.userReport.service.UserReportService;
import egovframework.whms.sm.userReport.service.UserReportVO;

@Controller
public class UserReportController {

	@Resource(name = "userReportService")
	private UserReportService userReportService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="EgovUserLogService")
	private EgovUserLogService userLogService;

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/sm/userReport.do")
	public String basicMedInfo( @ModelAttribute("searchVO") UserReportVO userReportVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "egovframework/com/uat/uia/EgovLoginUsr";
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

		return "egovframework/whms/sm/userReport/userReport";
	}

	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/sm/userReportAjax.do")
	public ModelAndView userReportAjax(@ModelAttribute("searchVO") UserReportVO userReportVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");
		try {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userReportVO.setLoginAuthorCd(user.getAuthorCd());
			userReportVO.setLoginAuthorType(user.getAuthorType());
			List<UserReportVO> dataList = userReportService.selectDataList(userReportVO);
			modelAndView.addObject("dataList", dataList);
			userLogService.logInsertUserLog(user.getId(), "userReport", "R", "");
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("dataList", null);
		}
		return modelAndView;
	}
	
}