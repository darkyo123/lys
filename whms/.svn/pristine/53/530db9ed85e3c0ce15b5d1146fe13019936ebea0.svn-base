package egovframework.whms.sm.measureItem.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.sm.measureItem.service.MeasureItemService;
import egovframework.whms.sm.measureItem.service.MeasureItemVO;

@Controller
public class MeasureItemController {

	@Resource(name = "measureItemService")
	private MeasureItemService measureItemService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/sm/measureItem.do")
	public String basicMedInfo( @ModelAttribute("searchVO") MeasureItemVO measureItemVO
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

		String paramId = EgovStringUtil.isNullToString(request.getParameter("paramId"));

		if(!"".equals(paramId)) {
			measureItemVO.setSearchCondition("USR_ID");
			measureItemVO.setSearchKeyword(paramId);
		}

		if(measureItemVO.getSearchKeyword() != null && !"".equals(measureItemVO.getSearchKeyword())) {
			model.addAttribute("detailVO", measureItemService.selectMeasureItem(measureItemVO));
		}

		return "egovframework/whms/sm/measureItem/measureItem";
	}

}