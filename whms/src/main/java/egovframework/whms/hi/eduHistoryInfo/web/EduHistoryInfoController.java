package egovframework.whms.hi.eduHistoryInfo.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.bi.userManage.service.UserManageVO;
import egovframework.whms.hi.eduHistoryInfo.service.EduHistoryInfoService;
import egovframework.whms.hi.eduHistoryInfo.service.EduHistoryInfoVO;

@Controller
public class EduHistoryInfoController {

	@Resource(name = "eduHistoryInfoService")
	private EduHistoryInfoService eduHistoryInfoService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/hi/eduHistoryInfo.do")
	public String summary( @ModelAttribute("searchVO") EduHistoryInfoVO eduHistoryInfoVO
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

		return "egovframework/whms/hi/eduHistoryInfo/eduHistoryInfo";
	}

	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/hi/eduHistoryInfoDataAjax.do")
	public ModelAndView eduHistoryInfoDataAjax(@ModelAttribute("searchVO") EduHistoryInfoVO eduHistoryInfoVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			eduHistoryInfoVO.setLoginAuthorCd(user.getAuthorCd());
			eduHistoryInfoVO.setLoginAuthorType(user.getAuthorType());

			List<EduHistoryInfoVO> dataList = eduHistoryInfoService.selectDataList(eduHistoryInfoVO);
			modelAndView.addObject("dataList", dataList);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("dataList", null);
		}

		return modelAndView;
	}

}