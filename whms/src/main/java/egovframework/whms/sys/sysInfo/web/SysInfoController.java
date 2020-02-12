package egovframework.whms.sys.sysInfo.web;

import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.sys.sysInfo.service.SysInfoService;
import egovframework.whms.sys.sysInfo.service.SysInfoVO;

@Controller
public class SysInfoController {

	@Resource(name = "sysInfoService")
	private SysInfoService sysInfoService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** 목록 및 페이징 */
	@RequestMapping(value = "/whms/sys/sysInfoList.do")
	public String SysInfoList(@ModelAttribute("searchVO") SysInfoVO sysInfoVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			String message = URLEncoder.encode(egovMessageSource.getMessage("fail.common.login"),"UTF-8");
			return "redirect:/uat/uia/egovLoginUsr.do?message=" + message + "&parentYn=N";
		}

		/** Left Menu List */
		model.addAttribute("list_menulist", request.getAttribute("menuList"));

		return "egovframework/whms/sys/sysInfo/sysInfoList";
	}

}