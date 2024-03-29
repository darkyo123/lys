package egovframework.whms.hi.basicMedInfo.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.hi.basicMedInfo.service.BasicMedInfoService;
import egovframework.whms.hi.basicMedInfo.service.BasicMedInfoVO;

@Controller
public class BasicMedInfoController {

	@Resource(name = "basicMedInfoService")
	private BasicMedInfoService basicMedInfoService;

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

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(BasicMedInfoController.class);

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/hi/basicMedInfo.do")
	public String basicMedInfo( @ModelAttribute("searchVO") BasicMedInfoVO basicMedInfoVO
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

		String paramGrpCd = EgovStringUtil.isNullToString(request.getParameter("paramGrpCd"));
		String paramId = EgovStringUtil.isNullToString(request.getParameter("paramId"));

		if(!"".equals(paramId)) {
			basicMedInfoVO.setSearchCondition("USR_ID");
			basicMedInfoVO.setSearchKeyword(paramId);
			basicMedInfoVO.setParamGrpCd(paramGrpCd);
		}

		if(basicMedInfoVO.getSearchKeyword() != null && !"".equals(basicMedInfoVO.getSearchKeyword())) {

			basicMedInfoVO.setLoginAuthorCd(user.getAuthorCd());
			basicMedInfoVO.setLoginAuthorType(user.getAuthorType());

			model.addAttribute("detailVO", basicMedInfoService.selectBasicMedInfo(basicMedInfoVO));
			userLogService.logInsertUserLog(user.getId(), "basicMedInfo", "R","");
		}

		return "egovframework/whms/hi/basicMedInfo/basicMedInfo";
	}

	/** 등록 로직 - ajax */
	@RequestMapping(value="/whms/hi/basicMedInfoRegistAjax.do")
	public ModelAndView basicMedInfoRegistAjax( @ModelAttribute("searchVO") BasicMedInfoVO basicMedInfoVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		LOGGER.debug("basicMedInfoRegistAjax start ");

    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		// user id
		String UsrId = EgovStringUtil.isNullToString(request.getParameter("usrId"));
		if(EgovStringUtil.isEmpty(UsrId)) {
			modelAndView.addObject("success", false);
			modelAndView.addObject("error_msg", "사용자아이디가 없습니다.");
			return modelAndView;
		}

//			가족력
		String FahsYn = EgovStringUtil.isNullToString(request.getParameter("fahsYn"));
		basicMedInfoVO.setFahsYn(EgovStringUtil.isEmpty(FahsYn) ? "N" : FahsYn);
		String Fahs1Yn = EgovStringUtil.isNullToString(request.getParameter("fahs1Yn"));
		basicMedInfoVO.setFahs1Yn(EgovStringUtil.isEmpty(Fahs1Yn) ? "N" : Fahs1Yn);
		String Fahs2Yn = EgovStringUtil.isNullToString(request.getParameter("fahs2Yn"));
		basicMedInfoVO.setFahs2Yn(EgovStringUtil.isEmpty(Fahs2Yn) ? "N" : Fahs2Yn);
		String Fahs3Yn = EgovStringUtil.isNullToString(request.getParameter("fahs3Yn"));
		basicMedInfoVO.setFahs3Yn(EgovStringUtil.isEmpty(Fahs3Yn) ? "N" : Fahs3Yn);
		String Fahs4Yn = EgovStringUtil.isNullToString(request.getParameter("fahs4Yn"));
		basicMedInfoVO.setFahs4Yn(EgovStringUtil.isEmpty(Fahs4Yn) ? "N" : Fahs4Yn);
		String Fahs5Yn = EgovStringUtil.isNullToString(request.getParameter("fahs5Yn"));
		basicMedInfoVO.setFahs5Yn(EgovStringUtil.isEmpty(Fahs5Yn) ? "N" : Fahs5Yn);
		String Fahs6Yn = EgovStringUtil.isNullToString(request.getParameter("fahs6Yn"));
		basicMedInfoVO.setFahs6Yn(EgovStringUtil.isEmpty(Fahs6Yn) ? "N" : Fahs6Yn);

//			건강검진 실시여부
		String mecku1Yn = EgovStringUtil.isNullToString(request.getParameter("mecku1Yn"));
		basicMedInfoVO.setMecku1Yn(EgovStringUtil.isEmpty(mecku1Yn) ? "0" : mecku1Yn);
		String mecku2Yn = EgovStringUtil.isNullToString(request.getParameter("mecku2Yn"));
		basicMedInfoVO.setMecku2Yn(EgovStringUtil.isEmpty(mecku2Yn) ? "0" : mecku2Yn);
		String mecku3Yn = EgovStringUtil.isNullToString(request.getParameter("mecku3Yn"));
		basicMedInfoVO.setMecku3Yn(EgovStringUtil.isEmpty(mecku3Yn) ? "0" : mecku3Yn);
		String mecku4Yn = EgovStringUtil.isNullToString(request.getParameter("mecku4Yn"));
		basicMedInfoVO.setMecku4Yn(EgovStringUtil.isEmpty(mecku4Yn) ? "0" : mecku4Yn);
		String mecku5Yn = EgovStringUtil.isNullToString(request.getParameter("mecku5Yn"));
		basicMedInfoVO.setMecku5Yn(EgovStringUtil.isEmpty(mecku5Yn) ? "0" : mecku5Yn);
		String mecku6Yn = EgovStringUtil.isNullToString(request.getParameter("mecku6Yn"));
		basicMedInfoVO.setMecku6Yn(EgovStringUtil.isEmpty(mecku6Yn) ? "0" : mecku6Yn);

		// 질병 여부
		String havdisYn = EgovStringUtil.isNullToString(request.getParameter("havdisYn"));
		basicMedInfoVO.setHavdisYn(EgovStringUtil.isEmpty(havdisYn) ? "N" : havdisYn);
		if("N".equals(havdisYn)) {
			String havdis1Yn = EgovStringUtil.isNullToString(request.getParameter("havdis1Yn"));
			basicMedInfoVO.setHavdis1Yn(EgovStringUtil.isEmpty(havdis1Yn) ? "N" : havdis1Yn);
			String havdis2Yn = EgovStringUtil.isNullToString(request.getParameter("havdis2Yn"));
			basicMedInfoVO.setHavdis2Yn(EgovStringUtil.isEmpty(havdis2Yn) ? "N" : havdis2Yn);
			String havdis3Yn = EgovStringUtil.isNullToString(request.getParameter("havdis3Yn"));
			basicMedInfoVO.setHavdis3Yn(EgovStringUtil.isEmpty(havdis3Yn) ? "N" : havdis3Yn);
			String havdis4Yn = EgovStringUtil.isNullToString(request.getParameter("havdis4Yn"));
			basicMedInfoVO.setHavdis4Yn(EgovStringUtil.isEmpty(havdis4Yn) ? "N" : havdis4Yn);
			String havdis5Yn = EgovStringUtil.isNullToString(request.getParameter("havdis5Yn"));
			basicMedInfoVO.setHavdis5Yn(EgovStringUtil.isEmpty(havdis5Yn) ? "N" : havdis5Yn);
			String havdis6Yn = EgovStringUtil.isNullToString(request.getParameter("havdis6Yn"));
			basicMedInfoVO.setHavdis6Yn(EgovStringUtil.isEmpty(havdis6Yn) ? "N" : havdis6Yn);
			String havdis7Yn = EgovStringUtil.isNullToString(request.getParameter("havdis7Yn"));
			basicMedInfoVO.setHavdis7Yn(EgovStringUtil.isEmpty(havdis7Yn) ? "N" : havdis7Yn);
			String havdis8Yn = EgovStringUtil.isNullToString(request.getParameter("havdis8Yn"));
			basicMedInfoVO.setHavdis8Yn(EgovStringUtil.isEmpty(havdis8Yn) ? "N" : havdis8Yn);
		} else {
			basicMedInfoVO.setHavdis1Yn("N");
			basicMedInfoVO.setHavdis2Yn("N");
			basicMedInfoVO.setHavdis3Yn("N");
			basicMedInfoVO.setHavdis4Yn("N");
			basicMedInfoVO.setHavdis5Yn("N");
			basicMedInfoVO.setHavdis6Yn("N");
			basicMedInfoVO.setHavdis7Yn("N");
			basicMedInfoVO.setHavdis8Yn("N");
			basicMedInfoVO.setHavdisEtc(null);
		}

		// 연락처 replace
		basicMedInfoVO.setConnTelno(basicMedInfoVO.getConnTelno().replaceAll("-", ""));

		// 생년월일 replace
		basicMedInfoVO.setBirDt(basicMedInfoVO.getBirDt().replaceAll("-", ""));

		// 작성자 본인UsrId로 입력.
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		basicMedInfoVO.setUpdId(user.getId());

    	String result = basicMedInfoService.doSave(basicMedInfoVO);

    	if("N".equals(result)) {
    		modelAndView.addObject("success", false);
			modelAndView.addObject("error_msg", "데이터 저장 중 오류가 발생하였습니다");
			return modelAndView;
    	}

		modelAndView.addObject("success", true);
		modelAndView.addObject("error_msg", "");

		userLogService.logInsertUserLog(user.getId(), "basicMedInfo", "U", UsrId);

		return modelAndView;
	}

}