package egovframework.whms.hi.healthMedInfo.web;

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
import egovframework.com.sym.log.ulg.service.EgovUserLogService;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.hi.healthMedInfo.service.HealthMedInfoService;
import egovframework.whms.hi.healthMedInfo.service.HealthMedInfoVO;

@Controller
public class HealthMedInfoController {

	@Resource(name = "healthMedInfoService")
	private HealthMedInfoService healthMedInfoService;

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
	@RequestMapping(value="/whms/hi/healthMedInfo.do")
	public String summary( @ModelAttribute("searchVO") HealthMedInfoVO healthMedInfoVO
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

		if(healthMedInfoVO.getSearchKeyword() != null && !"".equals(healthMedInfoVO.getSearchKeyword())) {

			healthMedInfoVO.setLoginAuthorCd(user.getAuthorCd());
			healthMedInfoVO.setLoginAuthorType(user.getAuthorType());

			model.addAttribute("detailVO", healthMedInfoService.selectHealthMedInfo(healthMedInfoVO));
			userLogService.logInsertUserLog(user.getId(), "healthMedInfo", "R", "");
		}

		return "egovframework/whms/hi/healthMedInfo/healthMedInfo";
	}

	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/hi/healthMedInfoDataAjax.do")
	public ModelAndView healthMedInfoDataAjax(@ModelAttribute("searchVO") HealthMedInfoVO healthMedInfoVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			healthMedInfoVO.setLoginAuthorCd(user.getAuthorCd());
			healthMedInfoVO.setLoginAuthorType(user.getAuthorType());

			List<HealthMedInfoVO> dataList = healthMedInfoService.selectDataList(healthMedInfoVO);
			modelAndView.addObject("dataList", dataList);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("dataList", null);
		}

		return modelAndView;
	}

	/** 추가 데이터 컬럼 Update (Ajax) */
	@RequestMapping(value = "/whms/hi/updateAdditionalHealthMedInfoDataAjax.do")
	public ModelAndView updateAdditionalHealthMedInfoDataAjax(@ModelAttribute("searchVO") HealthMedInfoVO healthMedInfoVO, HttpServletRequest request) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			modelAndView.addObject("result", false);
			return modelAndView;
		}
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		String makeDt = healthMedInfoVO.getMakeDt();
		if("".equals(makeDt)) {
			modelAndView.addObject("result", false);
			return modelAndView;
		}

		try {
			healthMedInfoVO.setLoginId(user.getId());
			healthMedInfoVO.setLoginAuthorCd(user.getAuthorCd());
			healthMedInfoVO.setLoginAuthorType(user.getAuthorType());
			healthMedInfoService.updateAdditionalData(healthMedInfoVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

}