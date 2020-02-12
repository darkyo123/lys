package egovframework.whms.sys.adminManage.web;

import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
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
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.bi.userManage.service.UserManageService;
import egovframework.whms.bi.userManage.service.UserManageVO;
import egovframework.whms.sys.adminManage.service.AdminManageService;
import egovframework.whms.sys.adminManage.service.AdminManageVO;

@Controller
public class AdminManageController {

	@Resource(name = "adminManageService")
	private AdminManageService adminManageService;

	@Resource(name = "usrManageService")
	private UserManageService userManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(AdminManageController.class);

	/** 목록 및 페이징 */
	@RequestMapping(value = "/whms/sys/adminManageList.do")
	public String adminManageList(@ModelAttribute("searchVO") AdminManageVO adminManageVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {

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

		/** 권한 List */
		UserManageVO userManageVO = new UserManageVO();
		model.addAttribute("useGrpCdList", userManageService.selectUseGrpCdList(userManageVO));

		return "egovframework/whms/sys/adminManage/adminManageList";
	}

	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/sys/adminManageDataAjax.do")
	public ModelAndView userManageDataAjax(@ModelAttribute("searchVO") AdminManageVO adminManageVO) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");

		try {
			List<AdminManageVO> dataList = adminManageService.selectDataList(adminManageVO);
			modelAndView.addObject("dataList", dataList);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("dataList", null);
		}

		return modelAndView;
	}

	/** 입력 & 수정 (Ajax) */
	@RequestMapping(value = "/whms/sys/adminManageSaveAjax.do")
	public ModelAndView testSaveAjax(@ModelAttribute("searchVO") AdminManageVO adminManageVO) throws Exception {

		//LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");

		try {
			//adminManageVO.setFrstRegisterId(user.getId());
			//adminManageVO.setLastUpdusrId(user.getId());
			/*
			 * if(userManageVO.getDate() == null || "".equals(userManageVO.getDate())) {
			 * userManageVO.setDate(null); } else {
			 * userManageVO.setDate(userManageVO.getDate().replaceAll("-", "")); }
			 */

			String usrPwd = adminManageVO.getUsrPwd();

			try {
		    	byte[] devPwd = Base64.decodeBase64(usrPwd);
				if(devPwd != null) {
					LOGGER.debug("password decript success");
					adminManageVO.setUsrPwd(new String(devPwd));
				}
			} catch (Exception e) {
				e.printStackTrace();
				adminManageVO.setUsrPwd("");
				LOGGER.debug("password decript failed");
			}

			String result = adminManageService.doSave(adminManageVO);
			if("Y".equals(result)) {
				modelAndView.addObject("result", true);				
			} else {
				String[] split = result.split(",");
				modelAndView.addObject("result", false);
				if(split != null && split.length == 2) {
					modelAndView.addObject("errorMsg", split[1]);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	/** 삭제 (Ajax) */
	@RequestMapping(value = "/whms/sys/adminManageDeleteAjax.do")
	public ModelAndView userManageDeleteAjax(@ModelAttribute("searchVO") AdminManageVO adminManageVO) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");

		try {
			adminManageService.doDelete(adminManageVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	/** 잠금해제 (Ajax) */
	@RequestMapping(value = "/whms/sys/adminManageUpdateLockAjax.do")
	public ModelAndView adminManageUpdateLockAjax(@ModelAttribute("searchVO") AdminManageVO adminManageVO) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");

		try {
			adminManageService.doUpdateLock(adminManageVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}
}