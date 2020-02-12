package egovframework.whms.bi.userManage.web;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.com.utl.fcc.service.EgovDateUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.bi.userManage.service.UserManageService;
import egovframework.whms.bi.userManage.service.UserManageVO;
import egovframework.whms.hi.qslt.service.QsltService;

@Controller
public class UserManageController {

	@Resource(name = "usrManageService")
	private UserManageService userManageService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	@Resource(name = "qsltService")
	private QsltService qsltService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name="EgovUserLogService")
	private EgovUserLogService userLogService;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(UserManageController.class);

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/bi/userManageList.do")
	public String userManageList( @ModelAttribute("searchVO") UserManageVO userManageVO
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

		model.addAttribute("useGrpCdList", userManageService.selectUseGrpCdList(userManageVO));

		userLogService.logInsertUserLog(user.getId(), "userManageList", "R", "");

		String parentYn = (String)request.getParameter("parentYn");
		if (parentYn!=null) model.addAttribute("parentYn", parentYn);

		return "egovframework/whms/bi/userManage/userManageList";
	}

	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/bi/userManageDataAjax.do")
	public ModelAndView userManageDataAjax(@ModelAttribute("searchVO") UserManageVO userManageVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userManageVO.setLoginAuthorCd(user.getAuthorCd());
			userManageVO.setLoginAuthorType(user.getAuthorType());

			String searchBegCd = EgovStringUtil.isNullToString(userManageVO.getSearchBegCd());
			String searchName = EgovStringUtil.isNullToString(userManageVO.getSearchName());
			String searchStartDt = EgovStringUtil.isNullToString(userManageVO.getSearchStartDt());
			String searchEndDt = EgovStringUtil.isNullToString(userManageVO.getSearchEndDt());
			String searchHighDgrCd = EgovStringUtil.isNullToString(userManageVO.getSearchHighDgrCd());

			if( "".equals(searchBegCd) && "".equals(searchName) && "".equals(searchStartDt) && "".equals(searchEndDt) && "".equals(searchHighDgrCd) ) {
				userManageVO.setSearchPrevent("Y");
			} else {
				userManageVO.setSearchPrevent("N");
			}

			List<UserManageVO> dataList = userManageService.selectDataList(userManageVO);
			modelAndView.addObject("dataList", dataList);

		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("dataList", null);
		}

		return modelAndView;
	}

	/** 데이터 단건 Load (Ajax) */
	@RequestMapping(value = "/whms/bi/userManageSingleDataAjax.do")
	public ModelAndView userManageSingleDataAjax(@ModelAttribute("searchVO") UserManageVO userManageVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {

			LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			userManageVO.setLoginAuthorCd(user.getAuthorCd());
			userManageVO.setLoginAuthorType(user.getAuthorType());

			UserManageVO data = userManageService.selectData(userManageVO);
			modelAndView.addObject("data", data);

		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("data", null);
		}

		return modelAndView;
	}

	/** 입력 & 수정 (Ajax) */
	@RequestMapping(value = "/whms/bi/userManageSaveAjax.do")
	public ModelAndView testSaveAjax(@ModelAttribute("searchVO") UserManageVO userManageVO) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {

			String usrId = userManageVO.getUsrId();

			if("I".equals(userManageVO.getFlag())) {
				usrId = qsltService.selectNewUsrId();
				userManageVO.setUsrId(usrId);
			}

			if(userManageVO.getBirDt() == null || "".equals(userManageVO.getBirDt())) userManageVO.setBirDt(null);
			if(userManageVO.getEntryDt() == null || "".equals(userManageVO.getEntryDt())) userManageVO.setEntryDt(null);

			CryptoUtil util = new CryptoUtil();
			String usrNm = EgovStringUtil.isNullToString(userManageVO.getUsrNm());
    		String connTelno = EgovStringUtil.isNullToString(userManageVO.getConnTelno());
    		if(!"".equals(connTelno)) connTelno = connTelno.replaceAll("-", "");
    		String birDt = EgovStringUtil.isNullToString(userManageVO.getBirDt());
    		if(!"".equals(birDt)) birDt = birDt.replaceAll("-", "");
    		String masterKey = util.encryptSHA256(usrId);	// 대칭키 (내부)
    		//String encVal1 = usrNm.equals("") ? "" : util.encryptAES128(masterKey, usrNm) == null ? "" : util.encryptAES128(masterKey, usrNm);
    		String encVal2 = connTelno.equals("") ? "" : util.encryptAES128(masterKey, connTelno) == null ? "" : util.encryptAES128(masterKey, connTelno);
    		String encVal3 = birDt.equals("") ? "" : util.encryptAES128(masterKey, birDt) == null ? "" : util.encryptAES128(masterKey, birDt);
    		userManageVO.setUsrNm(usrNm);
    		//userManageVO.setUsrNm(encVal1);
    		userManageVO.setConnTelno(encVal2);
    		userManageVO.setBirDt(encVal3);

    		userManageVO.setUsrAge(""); // NOT NULL 오류 회피용
    		userManageVO.setBldtyCd(""); // NOT NULL 오류 회피용
    		userManageVO.setUseYn("Y"); // NOT NULL 오류 회피용

			userManageService.doSave(userManageVO);
			if("I".equals(userManageVO.getFlag())) {
				userLogService.logInsertUserLog(user.getId(), "userManageList", "I", userManageVO.getUsrId());
			} else {
				userLogService.logInsertUserLog(user.getId(), "userManageList", "U", userManageVO.getUsrId());
			}
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	/** 삭제 (Ajax) */
	@RequestMapping(value = "/whms/bi/userManageDeleteAjax.do")
	public ModelAndView userManageDeleteAjax(@ModelAttribute("searchVO") UserManageVO userManageVO) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			userLogService.logInsertUserLog(user.getId(), "userManageList", "D", userManageVO.getUsrId());
			userManageService.doDelete(userManageVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	private String genRequestDateString( ) throws Exception {
		Date today = new Date();
		SimpleDateFormat datetime = new SimpleDateFormat("yyyyMMdd hh:mm:ss"); 
		String RequestDTM = datetime.format(today);
		return RequestDTM;
	}

	/** 보건 정보 정책연계  */
	@RequestMapping(value = "/whms/INFRQF001.do")
	public ModelAndView INFRQF001( HttpServletRequest request ) throws Exception {

		UserManageVO userManageVO = new UserManageVO();
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");
		String RequestDTM = this.genRequestDateString();

		String checkId = EgovStringUtil.isNullToString(request.getParameter("InterFaceID"));

		if("INFRQF001".equals(checkId)) {
	    	String usrId = EgovStringUtil.isNullToString(request.getParameter("HealthID"));
	    	LOGGER.debug("User ID : {}", usrId);
	
			try {
				userManageVO.setUsrId(usrId);
				UserManageVO usrData = userManageService.selectData(userManageVO);
	
				if(usrData != null) {
					String dbUsrId = EgovStringUtil.isNullToString(usrData.getUsrId());
					LOGGER.debug("dbUsrId : {}", dbUsrId);
					if("".equals(dbUsrId)) {
						modelAndView.addObject("HealthID", usrId);
						modelAndView.addObject("PlanCD", "");
						modelAndView.addObject("CauseNM", "");
						/*String contentRMK = "[오류] 사용자를 찾지 못했습니다.";
						byte[] encByte = Base64.encodeBase64(contentRMK.getBytes());
						LOGGER.debug("contentRmk encode : " + new String(encByte));*/
						modelAndView.addObject("ContentRMK", "[오류] 사용자를 찾지 못했습니다.");
					} else {
						modelAndView.addObject("HealthID", dbUsrId);
						String dbHighDgrCd = EgovStringUtil.isNullToString(usrData.getHighDgrCd());
						modelAndView.addObject("PlanCD", dbHighDgrCd); // 정책코드. 21,22,23,24
						String causeNM = EgovStringUtil.isNullToString(usrData.getCauseNM()); // 원인
						String contentRMK = EgovStringUtil.isNullToString(usrData.getContentRMK()); // 문자내용
						String lstChkDt = EgovStringUtil.isNullToString(usrData.getLstChkDt()); // 최종측정일자
						if(!"21".equals(dbHighDgrCd)) {
							switch(dbHighDgrCd) {
								case "22" :
									if("".equals(lstChkDt)) {
										contentRMK = "혈압 측정이 필요합니다.";
									} else {
										if(EgovDateUtil.checkWriteableDate(lstChkDt, 7)) {
											contentRMK = "혈압 측정일이 도래되었습니다. 혈압을 측정해주시기 바랍니다.";
										}
									}
									break;
								case "23" :
									if("".equals(lstChkDt)) {
										contentRMK = "혈압 측정이 필요합니다.";
									} else {
										if(EgovDateUtil.checkWriteableDate(lstChkDt, 14)) {
											contentRMK = "혈압 측정일이 도래되었습니다. 혈압을 측정해주시기 바랍니다.";
										}
									}
									break;
								case "24" :
									if("".equals(lstChkDt)) {
										contentRMK = "혈압 측정이 필요합니다.";
									} else {
										if(EgovDateUtil.checkWriteableDate(lstChkDt, 180)) {
											contentRMK = "혈압 측정일이 도래되었습니다. 혈압을 측정해주시기 바랍니다.";
										}
									}
									break;
								default :
									break;
							}
						}
						/*byte[] encByte1 = Base64.encodeBase64(causeNM.getBytes());
						byte[] encByte2 = Base64.encodeBase64(contentRMK.getBytes());
						LOGGER.debug("causeNM encode : " + new String(encByte1));
						LOGGER.debug("contentRmk encode : " + new String(encByte2));*/
						modelAndView.addObject("CauseNM", causeNM); // 원인. 고위험군
						modelAndView.addObject("ContentRMK", contentRMK); // 문자내용
					}
				} else {
					modelAndView.addObject("HealthID", usrId);
					modelAndView.addObject("PlanCD", "");
					modelAndView.addObject("CauseNM", "");
					/*String contentRMK = "[오류] 사용자를 찾지 못했습니다.";
					byte[] encByte = Base64.encodeBase64(contentRMK.getBytes());
					LOGGER.debug("contentRmk encode : " + new String(encByte));*/
					modelAndView.addObject("ContentRMK", "[오류] 사용자를 찾지 못했습니다.");				
				}
			} catch (Exception e) {
				LOGGER.debug("selectData Error");
				e.printStackTrace();
				modelAndView.addObject("HealthID", usrId);
				modelAndView.addObject("PlanCD", "");
				modelAndView.addObject("CauseNM", "");
				/*String contentRMK = "[오류] 사용자를 찾지 못했습니다.";
				byte[] encByte = Base64.encodeBase64(contentRMK.getBytes());
				LOGGER.debug("contentRmk encode : " + new String(encByte));*/
				modelAndView.addObject("ContentRMK", "[오류] 사용자를 찾지 못했습니다.");
			}

			// json 응답 내보내는 부분
			modelAndView.addObject("InterFaceID", "INFRQW001");
			modelAndView.addObject("RequestDTM", RequestDTM);
		} else {
			LOGGER.debug("INFRQF001 InterfaceID Error");
    		modelAndView.addObject("InterFaceID", "INFRQW001");
			modelAndView.addObject("RequestDTM", RequestDTM);
			modelAndView.addObject("HealthID", "");
			modelAndView.addObject("PlanCD", "");
			modelAndView.addObject("CauseNM", "");
			modelAndView.addObject("ContentRMK", "");
			/*String contentRMK = "[오류] InterfaceID가 상이합니다.";
			byte[] encByte = Base64.encodeBase64(contentRMK.getBytes());
			LOGGER.debug("contentRmk encode : " + new String(encByte));*/
			modelAndView.addObject("errorMsg", "[오류] InterfaceID가 상이합니다.");
		}

		return modelAndView;
	}

}