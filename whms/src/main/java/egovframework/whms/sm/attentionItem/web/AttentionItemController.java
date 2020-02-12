package egovframework.whms.sm.attentionItem.web;

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
import egovframework.whms.sm.attentionItem.service.AttentionItemService;
import egovframework.whms.sm.attentionItem.service.AttentionItemVO;

@Controller
public class AttentionItemController {

	@Resource(name = "attentionItemService")
	private AttentionItemService attentionItemService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/sm/attentionItem.do")
	public String basicMedInfo( @ModelAttribute("searchVO") AttentionItemVO attentionItemVO
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
			attentionItemVO.setSearchCondition("USR_ID");
			attentionItemVO.setSearchKeyword(paramId);
		}

		if(attentionItemVO.getSearchKeyword() != null && !"".equals(attentionItemVO.getSearchKeyword())) {
			model.addAttribute("detailVO", attentionItemService.selectAttentionItem(attentionItemVO));
		}

		return "egovframework/whms/sm/attentionItem/attentionItem";
	}

}