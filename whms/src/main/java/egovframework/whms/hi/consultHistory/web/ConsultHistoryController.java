package egovframework.whms.hi.consultHistory.web;

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

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.ulg.service.EgovUserLogService;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.bi.userDetailManage.service.UserDetailManageVO;
import egovframework.whms.hi.consultHistory.service.ConsultHistoryService;
import egovframework.whms.hi.consultHistory.service.ConsultHistoryVO;

@Controller
public class ConsultHistoryController {

	@Resource(name = "consultHistoryService")
	private ConsultHistoryService consultHistoryService;

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
	private static final Logger LOGGER = LoggerFactory.getLogger(ConsultHistoryController.class);

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/hi/consultHistory.do")
	public String consultHistory( @ModelAttribute("searchVO") UserDetailManageVO userDetailManageVO
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
			userDetailManageVO.setSearchCondition("USR_ID");
			userDetailManageVO.setSearchKeyword(paramId);
			userDetailManageVO.setParamGrpCd(paramGrpCd);
		}

		if(userDetailManageVO.getSearchKeyword() != null && !"".equals(userDetailManageVO.getSearchKeyword())) {

			userDetailManageVO.setLoginAuthorCd(user.getAuthorCd());
			userDetailManageVO.setLoginAuthorType(user.getAuthorType());

			int currPageNo = userDetailManageVO.getCurrPageNo();
			int pageUnit = userDetailManageVO.getPageUnit();
			if(currPageNo != 0) {
				userDetailManageVO.setPageIndex( (currPageNo-1) * pageUnit );
			}

			UserDetailManageVO detailVO = consultHistoryService.selectConsultHistory(userDetailManageVO);
			int totCnt = 0;

			if(detailVO != null) {
				totCnt = detailVO.getTotCnt() == null || "".contentEquals(detailVO.getTotCnt()) ? 0 : Integer.parseInt(detailVO.getTotCnt());

				int firstPageNoOnPageList = ((currPageNo - 1) / pageUnit) * pageUnit + 1;
				int lastPageNoOnPageList = firstPageNoOnPageList + pageUnit - 1;
				int totalPageCount = ((totCnt - 1) / pageUnit) + 1;
				if (lastPageNoOnPageList > totalPageCount) {
					lastPageNoOnPageList = totalPageCount;
				}
	
				detailVO.setFirstPageNo(firstPageNoOnPageList);
				detailVO.setLastPageNo(lastPageNoOnPageList);
			}

			model.addAttribute("detailVO", detailVO);

			userLogService.logInsertUserLog(user.getId(), "ConsultHistory", "R","");
		}

		return "egovframework/whms/hi/consultHistory/consultHistory";
	}

}