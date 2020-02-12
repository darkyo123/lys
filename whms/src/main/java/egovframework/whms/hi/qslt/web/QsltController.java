package egovframework.whms.hi.qslt.web;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;

//import com.sun.star.util.Date;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.ulg.service.EgovUserLogService;
import egovframework.com.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.com.sym.mnu.mpm.service.MenuManageVO;
import egovframework.com.utl.fcc.service.CryptoUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.whms.bi.userManage.service.UserManageService;
import egovframework.whms.bi.userManage.service.UserManageVO;
import egovframework.whms.hi.qslt.service.QsltService;
import egovframework.whms.hi.qslt.service.QsltVO;

@Controller
public class QsltController {

	@Resource(name = "usrManageService")
	private UserManageService userManageService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;

	@Resource(name = "qsltService")
	private QsltService qsltService;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(QsltController.class);

	/**
	 * 기본사용그룹코드
	 * 사용그룹코드를 여러개 사용할때에 대해 미정의 상태라 고정값 사용.
	 */
	private String defaultUseGrpCd = "01001";

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Resource(name="EgovUserLogService")
	private EgovUserLogService userLogService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/hi/qsltList.do")
	public String qslt( @ModelAttribute("searchVO") QsltVO qsltVO
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

		String paramId = EgovStringUtil.isNullToString(request.getParameter("paramId"));

		if(!"".equals(paramId)) {
			qsltVO.setSearchCondition("USR_ID");
			qsltVO.setSearchKeyword(paramId);
		}

		if(qsltVO.getSearchKeyword() != null && !"".equals(qsltVO.getSearchKeyword())) {

			qsltVO.setLoginAuthorCd(user.getAuthorCd());
			qsltVO.setLoginAuthorType(user.getAuthorType());

			QsltVO detailVO = qsltService.selectQsltInfo(qsltVO);
			detailVO = this.decYnValues(detailVO);
			model.addAttribute("detailVO", detailVO);
			userLogService.logInsertUserLog(user.getId(), "qsltList", "R","");
		}

		model.addAttribute("useGrpCdList", userManageService.selectUseGrpCdList(new UserManageVO()));

		return "egovframework/whms/hi/qslt/qsltList";
	}

	/** 등록 폼 */
	@RequestMapping(value="/whms/hi/qsltRegist.do")
	public String qsltRegist( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		LOGGER.debug("QsltRegist");

		model.addAttribute("UseGrpCd", this.defaultUseGrpCd); // 회원 그룹 코드 - DB 값을 어떤 기준으로 가져올지 명확하지 않음. 우선, 곤지암 코드(01001) 사용함. 
		LOGGER.debug("UseGrpCd");

		// UsrId - 신규 사용자는 문진표 작성 후 DB에 insert 할때 생성. 기존 사용자는 기존 HealthID 사용.
		String UsrId = EgovStringUtil.isNullToString(request.getParameter("HealthID")); // 유저아이디
		// 음.. 없으면 애러 페이지로 보내야 하는데... 어떻게 보내지?
		// 이렇게요 ㅎ
//		if("".equals(UsrId)) {
//			request.setAttribute("errorMsg", "사용자 ID가 없습니다.");
//			return "forward:/whms/errorPage.do";ㄷ
//		}
		model.addAttribute("UsrId", UsrId);
		qsltVO.setUsrId(UsrId);
		LOGGER.debug("UsrId : " + qsltVO.getUsrId());

		String EmpTmpId = EgovStringUtil.isNullToString(request.getParameter("EmpTmpID")); // 고객식별임시번호 FGMS에서 전달해줘야 함.
		model.addAttribute("EmpTmpId", EmpTmpId);
		LOGGER.debug("EmpTmpId : " + EmpTmpId);

		// 이미 등록된 사용자면 update, 아니면 regist
		String ActionMode = "doRegistQslt";
		QsltVO detailVO = qsltService.selectQsltDetail(qsltVO);
		if(detailVO != null) {
			String dbSysUpdDt = EgovStringUtil.isNullToString(detailVO.getSysUpdDt());
			// 기존 dbEmpTmpId 값과 새로 전달 받은 EmpTmpId가 다르면 애러??
//			String dbEmpTmpId = EgovStringUtil.isNullToString(detailVO.getEmpTmpId());
//			if(! dbEmpTmpId.equals(EmpTmpId)) {
//				return "";
//			}
			if(!this.checkWriteableDate(dbSysUpdDt)) {
				// 작성할 수 없는 사용자... 애러표시.
				request.setAttribute("errorMsg", "이미 문진표를 작성하셨습니다.");
				return "forward:/whms/errorPage.do";
			}
			ActionMode = "doUpdateQslt"; // 이미 등록된 사용자중 작성해도 되는 사용자 
		}

		model.addAttribute("ActionMode", ActionMode);

		model.addAttribute("useGrpCdList", userManageService.selectUseGrpCdList(new UserManageVO()));

		LOGGER.debug("QsltRegistEnd");
		return "egovframework/whms/hi/qslt/qsltRegist";
	}

	private QsltVO setYnValues( QsltVO qsltVO, HttpServletRequest request ) throws Exception {

		String highDgrCd = null;
		String dcviwYn = "N";

//		가족력
		String FahsYn = EgovStringUtil.isNullToString(request.getParameter("FahsYn"));
		qsltVO.setFahsYn(EgovStringUtil.isEmpty(FahsYn) ? "N" : FahsYn);
		if("Y".equals(qsltVO.getFahsYn())) {			// 해당 없음의 경우 다른 항목 무시
			qsltVO.setFahs1Yn("N");
			qsltVO.setFahs2Yn("N");
			qsltVO.setFahs3Yn("N");
			qsltVO.setFahs4Yn("N");
			qsltVO.setFahs5Yn("N");
			qsltVO.setFahs6Yn("N");
		} else {
			String Fahs1Yn = EgovStringUtil.isNullToString(request.getParameter("Fahs1Yn"));
			qsltVO.setFahs1Yn(EgovStringUtil.isEmpty(Fahs1Yn) ? "N" : Fahs1Yn);
			String Fahs2Yn = EgovStringUtil.isNullToString(request.getParameter("Fahs2Yn"));
			qsltVO.setFahs2Yn(EgovStringUtil.isEmpty(Fahs2Yn) ? "N" : Fahs2Yn);
			String Fahs3Yn = EgovStringUtil.isNullToString(request.getParameter("Fahs3Yn"));
			qsltVO.setFahs3Yn(EgovStringUtil.isEmpty(Fahs3Yn) ? "N" : Fahs3Yn);
			String Fahs4Yn = EgovStringUtil.isNullToString(request.getParameter("Fahs4Yn"));
			qsltVO.setFahs4Yn(EgovStringUtil.isEmpty(Fahs4Yn) ? "N" : Fahs4Yn);
			String Fahs5Yn = EgovStringUtil.isNullToString(request.getParameter("Fahs5Yn"));
			qsltVO.setFahs5Yn(EgovStringUtil.isEmpty(Fahs5Yn) ? "N" : Fahs5Yn);
			String Fahs6Yn = EgovStringUtil.isNullToString(request.getParameter("Fahs6Yn"));
			qsltVO.setFahs6Yn(EgovStringUtil.isEmpty(Fahs6Yn) ? "N" : Fahs6Yn);
		}

//		보유질병여부
		String HavdisYn = EgovStringUtil.isNullToString(request.getParameter("HavdisYn"));
		qsltVO.setHavdisYn(EgovStringUtil.isEmpty(HavdisYn) ? "N" : HavdisYn);
		if("Y".equals(qsltVO.getHavdisYn())) {			// 해당 없음의 경우 다른 항목 무시
			qsltVO.setHavdis1Yn("N");
			qsltVO.setHavdis2Yn("N");
			qsltVO.setHavdis3Yn("N");
			qsltVO.setHavdis4Yn("N");
			qsltVO.setHavdis5Yn("N");
			qsltVO.setHavdis6Yn("N");
			qsltVO.setHavdis7Yn("N");
			qsltVO.setHavdis8Yn("N");
			qsltVO.setHavdisEtc("");
		} else {
			String Havdis1Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis1Yn"));
			qsltVO.setHavdis1Yn(EgovStringUtil.isEmpty(Havdis1Yn) ? "N" : Havdis1Yn);
			String Havdis2Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis2Yn"));
			qsltVO.setHavdis2Yn(EgovStringUtil.isEmpty(Havdis2Yn) ? "N" : Havdis2Yn);
			String Havdis3Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis3Yn"));
			qsltVO.setHavdis3Yn(EgovStringUtil.isEmpty(Havdis3Yn) ? "N" : Havdis3Yn);
			String Havdis4Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis4Yn"));
			qsltVO.setHavdis4Yn(EgovStringUtil.isEmpty(Havdis4Yn) ? "N" : Havdis4Yn);
			String Havdis5Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis5Yn"));
			qsltVO.setHavdis5Yn(EgovStringUtil.isEmpty(Havdis5Yn) ? "N" : Havdis5Yn);
			String Havdis6Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis6Yn"));
			qsltVO.setHavdis6Yn(EgovStringUtil.isEmpty(Havdis6Yn) ? "N" : Havdis6Yn);
			String Havdis7Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis7Yn"));
			qsltVO.setHavdis7Yn(EgovStringUtil.isEmpty(Havdis7Yn) ? "N" : Havdis7Yn);
			String Havdis8Yn = EgovStringUtil.isNullToString(request.getParameter("Havdis8Yn"));
			qsltVO.setHavdis8Yn(EgovStringUtil.isEmpty(Havdis8Yn) ? "N" : Havdis8Yn);
			String HavdisEtc = EgovStringUtil.isNullToString(request.getParameter("HavdisEtc"));
			qsltVO.setHavdisEtc(EgovStringUtil.isEmpty(HavdisEtc) ? "" : HavdisEtc);
		}

		if("Y".equals(qsltVO.getHavdis8Yn()) || "Y".equals(qsltVO.getHavdis4Yn()) || "Y".equals(qsltVO.getHavdis5Yn())) {
			highDgrCd = "21";
		}

		if("Y".equals(qsltVO.getHavdis1Yn()) || "Y".equals(qsltVO.getHavdis2Yn()) || "Y".equals(qsltVO.getHavdis3Yn()) || "Y".equals(qsltVO.getHavdis4Yn())
			||	"Y".equals(qsltVO.getHavdis5Yn()) || "Y".equals(qsltVO.getHavdis6Yn()) || "Y".equals(qsltVO.getHavdis7Yn()) || "Y".equals(qsltVO.getHavdis8Yn())) {
			dcviwYn = "Y";
		}

//		운동사고여부 - 상해부위
		String MoaciYn = EgovStringUtil.isNullToString(request.getParameter("MoaciYn"));
		if("N".equals(MoaciYn)) {			// 없음이면 하위 항목 무시
			qsltVO.setMoaci1Yn("N");
			qsltVO.setMoaci2Yn("N");
			qsltVO.setMoaci3Yn("N");
			qsltVO.setMoaci4Yn("N");
			qsltVO.setMoaci5Yn("N");
			qsltVO.setMoaci6Yn("N");
			qsltVO.setMoaci7Yn("N");
		} else {
			String Moaci1Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci1Yn"));
			qsltVO.setMoaci1Yn(EgovStringUtil.isEmpty(Moaci1Yn) ? "N" : Moaci1Yn);
			String Moaci2Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci2Yn"));
			qsltVO.setMoaci2Yn(EgovStringUtil.isEmpty(Moaci2Yn) ? "N" : Moaci2Yn);
			String Moaci3Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci3Yn"));
			qsltVO.setMoaci3Yn(EgovStringUtil.isEmpty(Moaci3Yn) ? "N" : Moaci3Yn);
			String Moaci4Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci4Yn"));
			qsltVO.setMoaci4Yn(EgovStringUtil.isEmpty(Moaci4Yn) ? "N" : Moaci4Yn);
			String Moaci5Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci5Yn"));
			qsltVO.setMoaci5Yn(EgovStringUtil.isEmpty(Moaci5Yn) ? "N" : Moaci5Yn);
			String Moaci6Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci6Yn"));
			qsltVO.setMoaci6Yn(EgovStringUtil.isEmpty(Moaci6Yn) ? "N" : Moaci6Yn);
			String Moaci7Yn = EgovStringUtil.isNullToString(request.getParameter("Moaci7Yn"));
			qsltVO.setMoaci7Yn(EgovStringUtil.isEmpty(Moaci7Yn) ? "N" : Moaci7Yn);
		}

		if("Y".equals(qsltVO.getMoaci1Yn()) || "Y".equals(qsltVO.getMoaci2Yn()) || "Y".equals(qsltVO.getMoaci3Yn()) || "Y".equals(qsltVO.getMoaci4Yn())
				||	"Y".equals(qsltVO.getMoaci5Yn()) || "Y".equals(qsltVO.getMoaci6Yn()) || "Y".equals(qsltVO.getMoaci7Yn()) ) {
			dcviwYn = "Y";
		}

//		작업통증여부 - 상해부위
		String WkpnYn = EgovStringUtil.isNullToString(request.getParameter("WkpnYn"));
		if("N".equals(WkpnYn)) {			// 없음이면 하위 항목 무시
			qsltVO.setWkpn1Yn("N");
			qsltVO.setWkpn2Yn("N");
			qsltVO.setWkpn3Yn("N");
			qsltVO.setWkpn4Yn("N");
			qsltVO.setWkpn5Yn("N");
			qsltVO.setWkpn6Yn("N");
			qsltVO.setWkpn7Yn("N");
		} else {
			String Wkpn1Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn1Yn"));
			qsltVO.setWkpn1Yn(EgovStringUtil.isEmpty(Wkpn1Yn) ? "N" : Wkpn1Yn);
			String Wkpn2Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn2Yn"));
			qsltVO.setWkpn2Yn(EgovStringUtil.isEmpty(Wkpn2Yn) ? "N" : Wkpn2Yn);
			String Wkpn3Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn3Yn"));
			qsltVO.setWkpn3Yn(EgovStringUtil.isEmpty(Wkpn3Yn) ? "N" : Wkpn3Yn);
			String Wkpn4Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn4Yn"));
			qsltVO.setWkpn4Yn(EgovStringUtil.isEmpty(Wkpn4Yn) ? "N" : Wkpn4Yn);
			String Wkpn5Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn5Yn"));
			qsltVO.setWkpn5Yn(EgovStringUtil.isEmpty(Wkpn5Yn) ? "N" : Wkpn5Yn);
			String Wkpn6Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn6Yn"));
			qsltVO.setWkpn6Yn(EgovStringUtil.isEmpty(Wkpn6Yn) ? "N" : Wkpn6Yn);
			String Wkpn7Yn = EgovStringUtil.isNullToString(request.getParameter("Wkpn7Yn"));
			qsltVO.setWkpn7Yn(EgovStringUtil.isEmpty(Wkpn7Yn) ? "N" : Wkpn7Yn);
		}

		if("Y".equals(qsltVO.getWkpn1Yn()) || "Y".equals(qsltVO.getWkpn2Yn()) || "Y".equals(qsltVO.getWkpn3Yn()) || "Y".equals(qsltVO.getWkpn4Yn())
				||	"Y".equals(qsltVO.getWkpn5Yn()) || "Y".equals(qsltVO.getWkpn6Yn()) || "Y".equals(qsltVO.getWkpn7Yn()) ) {
			dcviwYn = "Y";
		}

//		호흡기계 증상
		String Repsym1Yn = EgovStringUtil.isNullToString(request.getParameter("Repsym1Yn"));
		qsltVO.setRepsym1Yn(EgovStringUtil.isEmpty(Repsym1Yn) ? "N" : Repsym1Yn);
		String Repsym2Yn = EgovStringUtil.isNullToString(request.getParameter("Repsym2Yn"));
		qsltVO.setRepsym2Yn(EgovStringUtil.isEmpty(Repsym2Yn) ? "N" : Repsym2Yn);
		String Repsym3Yn = EgovStringUtil.isNullToString(request.getParameter("Repsym3Yn"));
		qsltVO.setRepsym3Yn(EgovStringUtil.isEmpty(Repsym3Yn) ? "N" : Repsym3Yn);
		String Repsym4Yn = EgovStringUtil.isNullToString(request.getParameter("Repsym4Yn"));
		qsltVO.setRepsym4Yn(EgovStringUtil.isEmpty(Repsym4Yn) ? "N" : Repsym4Yn);
		String Repsym5Yn = EgovStringUtil.isNullToString(request.getParameter("Repsym5Yn"));
		qsltVO.setRepsym5Yn(EgovStringUtil.isEmpty(Repsym5Yn) ? "N" : Repsym5Yn);

		if("Y".equals(qsltVO.getRepsym1Yn()) || "Y".equals(qsltVO.getRepsym4Yn()) ) {
			highDgrCd = "21";
		}

		if("Y".equals(qsltVO.getRepsym1Yn()) || "Y".equals(qsltVO.getRepsym2Yn()) || "Y".equals(qsltVO.getRepsym3Yn())  || "Y".equals(qsltVO.getRepsym4Yn()) ) {
			dcviwYn = "Y";
		}

//		순환기증상
		String Cirsym1Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym1Yn"));
		qsltVO.setCirsym1Yn(EgovStringUtil.isEmpty(Cirsym1Yn) ? "N" : Cirsym1Yn);
		String Cirsym2Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym2Yn"));
		qsltVO.setCirsym2Yn(EgovStringUtil.isEmpty(Cirsym2Yn) ? "N" : Cirsym2Yn);
		String Cirsym3Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym3Yn"));
		qsltVO.setCirsym3Yn(EgovStringUtil.isEmpty(Cirsym3Yn) ? "N" : Cirsym3Yn);
		String Cirsym4Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym4Yn"));
		qsltVO.setCirsym4Yn(EgovStringUtil.isEmpty(Cirsym4Yn) ? "N" : Cirsym4Yn);
		String Cirsym5Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym5Yn"));
		qsltVO.setCirsym5Yn(EgovStringUtil.isEmpty(Cirsym5Yn) ? "N" : Cirsym5Yn);
		String Cirsym6Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym6Yn"));
		qsltVO.setCirsym6Yn(EgovStringUtil.isEmpty(Cirsym6Yn) ? "N" : Cirsym6Yn);
		String Cirsym7Yn = EgovStringUtil.isNullToString(request.getParameter("Cirsym7Yn"));
		qsltVO.setCirsym7Yn(EgovStringUtil.isEmpty(Cirsym7Yn) ? "N" : Cirsym7Yn);

		if("Y".equals(qsltVO.getCirsym1Yn())) {
			highDgrCd = "21";
		}

		if("Y".equals(qsltVO.getCirsym1Yn()) || "Y".equals(qsltVO.getCirsym2Yn()) || "Y".equals(qsltVO.getCirsym3Yn()) 
				|| "Y".equals(qsltVO.getCirsym4Yn()) ||	"Y".equals(qsltVO.getCirsym5Yn()) ||	"Y".equals(qsltVO.getCirsym6Yn()) ) {
			dcviwYn = "Y";
		}

//		산재
		String InddistYn = EgovStringUtil.isNullToString(request.getParameter("InddistYn"));
		if("N".equals(InddistYn)) {			// 없음이면 하위 항목 무시
			qsltVO.setInddist1Yn("N");
			qsltVO.setInddist2Yn("N");
			qsltVO.setInddist3Yn("N");
			qsltVO.setInddist4Yn("N");
			qsltVO.setInddist5Yn("N");
			qsltVO.setInddist6Yn("N");
			qsltVO.setInddistEtc("");
		} else {
			String Inddist1Yn = EgovStringUtil.isNullToString(request.getParameter("Inddist1Yn"));
			qsltVO.setInddist1Yn(EgovStringUtil.isEmpty(Inddist1Yn) ? "N" : Inddist1Yn);
			String Inddist2Yn = EgovStringUtil.isNullToString(request.getParameter("Inddist2Yn"));
			qsltVO.setInddist2Yn(EgovStringUtil.isEmpty(Inddist2Yn) ? "N" : Inddist2Yn);
			String Inddist3Yn = EgovStringUtil.isNullToString(request.getParameter("Inddist3Yn"));
			qsltVO.setInddist3Yn(EgovStringUtil.isEmpty(Inddist3Yn) ? "N" : Inddist3Yn);
			String Inddist4Yn = EgovStringUtil.isNullToString(request.getParameter("Inddist4Yn"));
			qsltVO.setInddist4Yn(EgovStringUtil.isEmpty(Inddist4Yn) ? "N" : Inddist4Yn);
			String Inddist5Yn = EgovStringUtil.isNullToString(request.getParameter("Inddist5Yn"));
			qsltVO.setInddist5Yn(EgovStringUtil.isEmpty(Inddist5Yn) ? "N" : Inddist5Yn);
			String Inddist6Yn = EgovStringUtil.isNullToString(request.getParameter("Inddist6Yn"));
			qsltVO.setInddist6Yn(EgovStringUtil.isEmpty(Inddist6Yn) ? "N" : Inddist6Yn);
			String InddistEtc = EgovStringUtil.isNullToString(request.getParameter("InddistEtc"));
			qsltVO.setInddistEtc(EgovStringUtil.isEmpty(InddistEtc) ? "" : InddistEtc);
		}

		String InfrecYn = EgovStringUtil.isNullToString(request.getParameter("InfrecYn"));
		qsltVO.setInfrecYn(EgovStringUtil.isEmpty(InfrecYn) ? "N" : InfrecYn);

		qsltVO.setHighDgrCd(highDgrCd);
		qsltVO.setDcviwYn(dcviwYn);

		qsltVO = this.encYnValues(qsltVO);

		return qsltVO;
	}

	private QsltVO encYnValues(QsltVO qsltVO) throws Exception {

		String UsrId = qsltVO.getUsrId();
		String SysUpdDt = qsltVO.getSysUpdDt().replaceAll("-", "").substring(0,8);

		CryptoUtil util = new CryptoUtil();
		String masterKey = util.encryptSHA256(UsrId);	// 대칭키
		qsltVO.setFahsYn(util.encryptAES128(masterKey, qsltVO.getFahsYn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahsYn().concat(SysUpdDt)));
		qsltVO.setFahs1Yn(util.encryptAES128(masterKey, qsltVO.getFahs1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahs1Yn().concat(SysUpdDt)));
		qsltVO.setFahs2Yn(util.encryptAES128(masterKey, qsltVO.getFahs2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahs2Yn().concat(SysUpdDt)));
		qsltVO.setFahs3Yn(util.encryptAES128(masterKey, qsltVO.getFahs3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahs3Yn().concat(SysUpdDt)));
		qsltVO.setFahs4Yn(util.encryptAES128(masterKey, qsltVO.getFahs4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahs4Yn().concat(SysUpdDt)));
		qsltVO.setFahs5Yn(util.encryptAES128(masterKey, qsltVO.getFahs5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahs5Yn().concat(SysUpdDt)));
		qsltVO.setFahs6Yn(util.encryptAES128(masterKey, qsltVO.getFahs6Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahs6Yn().concat(SysUpdDt)));
		qsltVO.setFahsEtc("".equals(qsltVO.getFahsEtc()) ? "" : util.encryptAES128(masterKey, qsltVO.getFahsEtc()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahsEtc()));

		qsltVO.setHavdisYn(util.encryptAES128(masterKey, qsltVO.getHavdisYn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdisYn().concat(SysUpdDt)));
		qsltVO.setHavdis1Yn(util.encryptAES128(masterKey, qsltVO.getHavdis1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis1Yn().concat(SysUpdDt)));
		qsltVO.setHavdis2Yn(util.encryptAES128(masterKey, qsltVO.getHavdis2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis2Yn().concat(SysUpdDt)));
		qsltVO.setHavdis3Yn(util.encryptAES128(masterKey, qsltVO.getHavdis3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis3Yn().concat(SysUpdDt)));
		qsltVO.setHavdis4Yn(util.encryptAES128(masterKey, qsltVO.getHavdis4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis4Yn().concat(SysUpdDt)));
		qsltVO.setHavdis5Yn(util.encryptAES128(masterKey, qsltVO.getHavdis5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis5Yn().concat(SysUpdDt)));
		qsltVO.setHavdis6Yn(util.encryptAES128(masterKey, qsltVO.getHavdis6Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis6Yn().concat(SysUpdDt)));
		qsltVO.setHavdis7Yn(util.encryptAES128(masterKey, qsltVO.getHavdis7Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis7Yn().concat(SysUpdDt)));
		qsltVO.setHavdis8Yn(util.encryptAES128(masterKey, qsltVO.getHavdis8Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdis8Yn().concat(SysUpdDt)));
		qsltVO.setHavdisEtc("".equals(qsltVO.getHavdisEtc()) ? "" : util.encryptAES128(masterKey, qsltVO.getHavdisEtc()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdisEtc()));

		qsltVO.setMoaciYn(util.encryptAES128(masterKey, qsltVO.getMoaciYn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaciYn().concat(SysUpdDt)));
		qsltVO.setMoaci1Yn(util.encryptAES128(masterKey, qsltVO.getMoaci1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci1Yn().concat(SysUpdDt)));
		qsltVO.setMoaci2Yn(util.encryptAES128(masterKey, qsltVO.getMoaci2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci2Yn().concat(SysUpdDt)));
		qsltVO.setMoaci3Yn(util.encryptAES128(masterKey, qsltVO.getMoaci3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci3Yn().concat(SysUpdDt)));
		qsltVO.setMoaci4Yn(util.encryptAES128(masterKey, qsltVO.getMoaci4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci4Yn().concat(SysUpdDt)));
		qsltVO.setMoaci5Yn(util.encryptAES128(masterKey, qsltVO.getMoaci5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci5Yn().concat(SysUpdDt)));
		qsltVO.setMoaci6Yn(util.encryptAES128(masterKey, qsltVO.getMoaci6Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci6Yn().concat(SysUpdDt)));
		qsltVO.setMoaci7Yn(util.encryptAES128(masterKey, qsltVO.getMoaci7Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getMoaci7Yn().concat(SysUpdDt)));

		qsltVO.setWkpnYn(util.encryptAES128(masterKey, qsltVO.getWkpnYn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpnYn().concat(SysUpdDt)));
		qsltVO.setWkpn1Yn(util.encryptAES128(masterKey, qsltVO.getWkpn1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn1Yn().concat(SysUpdDt)));
		qsltVO.setWkpn2Yn(util.encryptAES128(masterKey, qsltVO.getWkpn2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn2Yn().concat(SysUpdDt)));
		qsltVO.setWkpn3Yn(util.encryptAES128(masterKey, qsltVO.getWkpn3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn3Yn().concat(SysUpdDt)));
		qsltVO.setWkpn4Yn(util.encryptAES128(masterKey, qsltVO.getWkpn4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn4Yn().concat(SysUpdDt)));
		qsltVO.setWkpn5Yn(util.encryptAES128(masterKey, qsltVO.getWkpn5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn5Yn().concat(SysUpdDt)));
		qsltVO.setWkpn6Yn(util.encryptAES128(masterKey, qsltVO.getWkpn6Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn6Yn().concat(SysUpdDt)));
		qsltVO.setWkpn7Yn(util.encryptAES128(masterKey, qsltVO.getWkpn7Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getWkpn7Yn().concat(SysUpdDt)));

		qsltVO.setRepsym1Yn(util.encryptAES128(masterKey, qsltVO.getRepsym1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getRepsym1Yn().concat(SysUpdDt)));
		qsltVO.setRepsym2Yn(util.encryptAES128(masterKey, qsltVO.getRepsym2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getRepsym2Yn().concat(SysUpdDt)));
		qsltVO.setRepsym3Yn(util.encryptAES128(masterKey, qsltVO.getRepsym3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getRepsym3Yn().concat(SysUpdDt)));
		qsltVO.setRepsym4Yn(util.encryptAES128(masterKey, qsltVO.getRepsym4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getRepsym4Yn().concat(SysUpdDt)));
		qsltVO.setRepsym5Yn(util.encryptAES128(masterKey, qsltVO.getRepsym5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getRepsym5Yn().concat(SysUpdDt)));

		qsltVO.setCirsym1Yn(util.encryptAES128(masterKey, qsltVO.getCirsym1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym1Yn().concat(SysUpdDt)));
		qsltVO.setCirsym2Yn(util.encryptAES128(masterKey, qsltVO.getCirsym2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym2Yn().concat(SysUpdDt)));
		qsltVO.setCirsym3Yn(util.encryptAES128(masterKey, qsltVO.getCirsym3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym3Yn().concat(SysUpdDt)));
		qsltVO.setCirsym4Yn(util.encryptAES128(masterKey, qsltVO.getCirsym4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym4Yn().concat(SysUpdDt)));
		qsltVO.setCirsym5Yn(util.encryptAES128(masterKey, qsltVO.getCirsym5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym5Yn().concat(SysUpdDt)));
		qsltVO.setCirsym6Yn(util.encryptAES128(masterKey, qsltVO.getCirsym6Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym6Yn().concat(SysUpdDt)));
		qsltVO.setCirsym7Yn(util.encryptAES128(masterKey, qsltVO.getCirsym7Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getCirsym7Yn().concat(SysUpdDt)));

		qsltVO.setInddistYn(util.encryptAES128(masterKey, qsltVO.getInddistYn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddistYn().concat(SysUpdDt)));
		qsltVO.setInddist1Yn(util.encryptAES128(masterKey, qsltVO.getInddist1Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddist1Yn().concat(SysUpdDt)));
		qsltVO.setInddist2Yn(util.encryptAES128(masterKey, qsltVO.getInddist2Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddist2Yn().concat(SysUpdDt)));
		qsltVO.setInddist3Yn(util.encryptAES128(masterKey, qsltVO.getInddist3Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddist3Yn().concat(SysUpdDt)));
		qsltVO.setInddist4Yn(util.encryptAES128(masterKey, qsltVO.getInddist4Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddist4Yn().concat(SysUpdDt)));
		qsltVO.setInddist5Yn(util.encryptAES128(masterKey, qsltVO.getInddist5Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddist5Yn().concat(SysUpdDt)));
		qsltVO.setInddist6Yn(util.encryptAES128(masterKey, qsltVO.getInddist6Yn().concat(SysUpdDt)) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddist6Yn().concat(SysUpdDt)));
		qsltVO.setInddistEtc("".equals(qsltVO.getInddistEtc()) ? "" : util.encryptAES128(masterKey, qsltVO.getInddistEtc()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddistEtc()));

		return qsltVO;
	}

	private QsltVO decYnValues(QsltVO qsltVO) throws Exception {

		String UsrId = qsltVO.getUsrId();

		CryptoUtil util = new CryptoUtil();
		String masterKey = util.encryptSHA256(UsrId);	// 대칭키

		qsltVO.setFahsYn(EgovStringUtil.isEmpty(qsltVO.getFahsYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn()).substring(0,1));
		qsltVO.setFahs1Yn(EgovStringUtil.isEmpty(qsltVO.getFahs1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs1Yn()).substring(0,1));
		qsltVO.setFahs2Yn(EgovStringUtil.isEmpty(qsltVO.getFahs2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs2Yn()).substring(0,1));
		qsltVO.setFahs3Yn(EgovStringUtil.isEmpty(qsltVO.getFahs3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs3Yn()).substring(0,1));
		qsltVO.setFahs4Yn(EgovStringUtil.isEmpty(qsltVO.getFahs4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs4Yn()).substring(0,1));
		qsltVO.setFahs5Yn(EgovStringUtil.isEmpty(qsltVO.getFahs5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs5Yn()).substring(0,1));
		qsltVO.setFahs6Yn(EgovStringUtil.isEmpty(qsltVO.getFahs6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs6Yn()).substring(0,1));
		qsltVO.setFahsEtc(EgovStringUtil.isEmpty(qsltVO.getFahsEtc()) ? "" : util.decryptAES128Etc(masterKey, qsltVO.getFahsEtc()) == null ? "" : util.decryptAES128Etc(masterKey, qsltVO.getFahsEtc()));

		qsltVO.setHavdisYn(EgovStringUtil.isEmpty(qsltVO.getHavdisYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisYn()).substring(0,1));
		qsltVO.setHavdis1Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis1Yn()).substring(0,1));
		qsltVO.setHavdis2Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis2Yn()).substring(0,1));
		qsltVO.setHavdis3Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis3Yn()).substring(0,1));
		qsltVO.setHavdis4Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis4Yn()).substring(0,1));
		qsltVO.setHavdis5Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis5Yn()).substring(0,1));
		qsltVO.setHavdis6Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis6Yn()).substring(0,1));
		qsltVO.setHavdis7Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis7Yn()).substring(0,1));
		qsltVO.setHavdis8Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis8Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis8Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis8Yn()).substring(0,1));
		qsltVO.setHavdisEtc(EgovStringUtil.isEmpty(qsltVO.getHavdisEtc()) ? "" : util.decryptAES128Etc(masterKey, qsltVO.getHavdisEtc()) == null ? "" : util.decryptAES128Etc(masterKey, qsltVO.getHavdisEtc()));

		qsltVO.setMoaciYn(EgovStringUtil.isEmpty(qsltVO.getMoaciYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaciYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaciYn()).substring(0,1));
		qsltVO.setMoaci1Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci1Yn()).substring(0,1));
		qsltVO.setMoaci2Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci2Yn()).substring(0,1));
		qsltVO.setMoaci3Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci3Yn()).substring(0,1));
		qsltVO.setMoaci4Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci4Yn()).substring(0,1));
		qsltVO.setMoaci5Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci5Yn()).substring(0,1));
		qsltVO.setMoaci6Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci6Yn()).substring(0,1));
		qsltVO.setMoaci7Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci7Yn()).substring(0,1));

		qsltVO.setWkpnYn(EgovStringUtil.isEmpty(qsltVO.getWkpnYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpnYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpnYn()).substring(0,1));
		qsltVO.setWkpn1Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn1Yn()).substring(0,1));
		qsltVO.setWkpn2Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn2Yn()).substring(0,1));
		qsltVO.setWkpn3Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn3Yn()).substring(0,1));
		qsltVO.setWkpn4Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn4Yn()).substring(0,1));
		qsltVO.setWkpn5Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn5Yn()).substring(0,1));
		qsltVO.setWkpn6Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn6Yn()).substring(0,1));
		qsltVO.setWkpn7Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn7Yn()).substring(0,1));

		qsltVO.setRepsym1Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym1Yn()).substring(0,1));
		qsltVO.setRepsym2Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym2Yn()).substring(0,1));
		qsltVO.setRepsym3Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym3Yn()).substring(0,1));
		qsltVO.setRepsym4Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym4Yn()).substring(0,1));
		qsltVO.setRepsym5Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym5Yn()).substring(0,1));

		qsltVO.setCirsym1Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym1Yn()).substring(0,1));
		qsltVO.setCirsym2Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym2Yn()).substring(0,1));
		qsltVO.setCirsym3Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym3Yn()).substring(0,1));
		qsltVO.setCirsym4Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym4Yn()).substring(0,1));
		qsltVO.setCirsym5Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym5Yn()).substring(0,1));
		qsltVO.setCirsym6Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym6Yn()).substring(0,1));
		qsltVO.setCirsym7Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym7Yn()).substring(0,1));

		qsltVO.setInddistYn(EgovStringUtil.isEmpty(qsltVO.getInddistYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddistYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddistYn()).substring(0,1));
		qsltVO.setInddist1Yn(EgovStringUtil.isEmpty(qsltVO.getInddist1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist1Yn()).substring(0,1));
		qsltVO.setInddist2Yn(EgovStringUtil.isEmpty(qsltVO.getInddist2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist2Yn()).substring(0,1));
		qsltVO.setInddist3Yn(EgovStringUtil.isEmpty(qsltVO.getInddist3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist3Yn()).substring(0,1));
		qsltVO.setInddist4Yn(EgovStringUtil.isEmpty(qsltVO.getInddist4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist4Yn()).substring(0,1));
		qsltVO.setInddist5Yn(EgovStringUtil.isEmpty(qsltVO.getInddist5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist5Yn()).substring(0,1));
		qsltVO.setInddist6Yn(EgovStringUtil.isEmpty(qsltVO.getInddist6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist6Yn()).substring(0,1));
		qsltVO.setInddistEtc(EgovStringUtil.isEmpty(qsltVO.getInddistEtc()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddistEtc()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddistEtc()));

		return qsltVO;
	}

	/** 등록 로직 - ajax */
	@RequestMapping(value="/whms/hi/qsltRegistAjax.do")
	public ModelAndView qsltRegistAjax( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		LOGGER.debug("QsltRegistAjax start");

    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");
		
		String UseGrpCd = EgovStringUtil.isNullToString(request.getParameter("UseGrpCd"));
		// 사용그룹코드 - 비어 있으면 곤지암
		if("".equals(UseGrpCd)) {
			UseGrpCd = "01001";
		}
//		qsltVO.setUseGrpCd(EgovStringUtil.isEmpty(UseGrpCd) ? this.defaultUseGrpCd : UseGrpCd);
		qsltVO.setUseGrpCd(UseGrpCd);
		modelAndView.addObject("UseGrpCd", UseGrpCd);

		// EmpTmpId 중복확
		// qsltService.doRegistQslt(qsltVO);
		String EmpTmpId = EgovStringUtil.isNullToString(request.getParameter("EmpTmpId"));
		if(EgovStringUtil.isEmpty(EmpTmpId)) {
			modelAndView.addObject("success", false);
			modelAndView.addObject("error_msg", "고객식별 임시번호가 없습니다.");
			return modelAndView;
		}
		qsltVO.setEmpTmpId(EmpTmpId);
		modelAndView.addObject("EmpTmpId", EmpTmpId);
		
		String sysdate = this.genRequestDateString("yyyy-MM-dd HH:mm:ss");
		qsltVO.setSysRgsDt(sysdate);
		qsltVO.setSysUpdDt(sysdate);
		
		// user id - 전달 받은 값
		String UsrId = EgovStringUtil.isNullToString(request.getParameter("UsrId"));
		String ActionMode = EgovStringUtil.isNullToString(request.getParameter("ActionMode"));

		// 사용자 정보 준비.
		UserManageVO userManageVO = new UserManageVO();
		userManageVO.setUseGrpCd(UseGrpCd);
		
    	try {
	    	
	    	if("doUpdateQslt".equals(ActionMode)) { // update
	
	    		// user id - 전달 받은 값 사용.
				if(EgovStringUtil.isEmpty(UsrId)) {
					modelAndView.addObject("success", false);
					modelAndView.addObject("error_msg", "사용자 아이디 없이 수정할 수 없습니다.");
					return modelAndView;
				}
				qsltVO.setUsrId(UsrId);
	    		modelAndView.addObject("UsrId", UsrId);

	    		qsltVO = this.setYnValues( qsltVO, request );

	    		QsltVO detailVO = qsltService.selectQsltDetail(qsltVO);
	    		String dbSysUpdDt = EgovStringUtil.isNullToString(detailVO.getSysUpdDt());
	    		if(! EgovStringUtil.isEmpty(dbSysUpdDt) ) {
	    			if(! this.checkWriteableDate(dbSysUpdDt)) {
	    				modelAndView.addObject("success", false);
	    				modelAndView.addObject("error_msg", "이미 문진표를 작성했습니다.");
	    				return modelAndView;
	    			}
	    		}

	    		String DysmkCt = EgovStringUtil.isNullToString(qsltVO.getDysmkCt());
    			String WekAlcCt = EgovStringUtil.isNullToString(qsltVO.getWekAlcCt());
    			String AdrkCt = EgovStringUtil.isNullToString(qsltVO.getAdrkCt());
    			String usrHet = EgovStringUtil.isNullToString(qsltVO.getUsrHet());
    			String usrWet = EgovStringUtil.isNullToString(qsltVO.getUsrWet());
    			if("".equals(usrHet)) qsltVO.setUsrHet(0.0);
    			if("".equals(usrWet)) qsltVO.setUsrWet(0.0);
    			if("".equals(DysmkCt)) qsltVO.setDysmkCt("0");
    			if("".equals(WekAlcCt)) qsltVO.setWekAlcCt("0");
    			if("".equals(AdrkCt)) qsltVO.setAdrkCt("0");

	    		// 작성자 본인UsrId로 입력.
	    		qsltVO.setRgsId(UsrId);

	    		qsltVO.setTargetDt(detailVO.getMakeDt());
	    		qsltService.doUpdateQslt(qsltVO);
	    		//qsltService.doRegistQslt(qsltVO);

	    	} else { // insert
	
	    		// 신규 user id - 년월일 + 시퀀스방식으로 생성. 190312 0001
	    		UsrId = qsltService.selectNewUsrId();
//	    		UsrId = "1903120001"; // testing
	    		// 문진표 정보에 신규 UsrId 설정
	    		qsltVO.setUsrId(UsrId);
	    		modelAndView.addObject("UsrId", UsrId);
	    		// 사용자 정보에도 신규  UsrId 설정
	    		userManageVO.setUsrId(UsrId);
	    		
	    		// 작성자 본인UsrId로 입력.
	    		qsltVO.setRgsId(UsrId);

	    		qsltVO = this.setYnValues( qsltVO, request );

	    		// EmpTmpId 중복확인. (19.06.04 해당 부분 고객 요청으로 validation 제거)
	    		//String result = qsltService.selectQsltDetailByTmpId(qsltVO);
	    		//if("0".equals(result)) {
	    		// 문진표 저장.
    			String DysmkCt = EgovStringUtil.isNullToString(qsltVO.getDysmkCt());
    			String WekAlcCt = EgovStringUtil.isNullToString(qsltVO.getWekAlcCt());
    			String AdrkCt = EgovStringUtil.isNullToString(qsltVO.getAdrkCt());
    			String usrHetChk = EgovStringUtil.isNullToString(qsltVO.getUsrHet());
    			String usrWetChk = EgovStringUtil.isNullToString(qsltVO.getUsrWet());
    			if("".equals(usrHetChk)) qsltVO.setUsrHet(0.0);
    			if("".equals(usrWetChk)) qsltVO.setUsrWet(0.0);
    			if("".equals(DysmkCt)) qsltVO.setDysmkCt("0");
    			if("".equals(WekAlcCt)) qsltVO.setWekAlcCt("0");
    			if("".equals(AdrkCt)) qsltVO.setAdrkCt("0");
				qsltService.doRegistQslt(qsltVO);
	    		//} else {
	    		//	modelAndView.addObject("success", false);
	    		//	modelAndView.addObject("error_msg", "기 등록된 식별ID입니다.");
	    		//	return modelAndView;
	    		//}

        		// UsrId 유무 확인.
        		UserManageVO dbUserManageVO = userManageService.selectData(userManageVO);
        		LOGGER.debug("dbUserManageVO" + dbUserManageVO);

        		// 사용자 아이디 없으면 선점하기.
        		if(dbUserManageVO == null) {
            		// 이후는 더미데이터
            		userManageVO.setConnTelno("");
            		userManageVO.setUsrNm("");
            		userManageVO.setBirDt("");
            		userManageVO.setSexSecd("");
            		userManageVO.setBegCd("");
//            		if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(responseJSON.get("EntryDT")))) { // date 컬럼 null 오류 피하기 위해 확인
//            			userManageVO.setEntryDt(EgovStringUtil.isNullToString(responseJSON.get("EntryDT")));
//            		}
            		userManageVO.setDutyDy("");
            		userManageVO.setContDutyDy("");
            		userManageVO.setBldtyCd(""); // NOT NULL 오류 회피용
            		userManageVO.setUseYn("Y"); // NOT NULL 오류 회피용
            		userManageVO.setUsrAge(qsltVO.getUsrAge()); 
            		userManageVO.setHighDgrCd(""); // NOT NULL 오류 회피용
            		userManageVO.setEduDt(null); // NOT NULL 오류 회피용
            		// 더미데이터 저장.
            		userManageService.doRegist(userManageVO);
        		}

        		// FGMS 에 사용자 정보 요청하기.
        		RestTemplate restTemplate = new RestTemplate();
        		restTemplate.getMessageConverters().add(new StringHttpMessageConverter());
        		String RequestDTM = this.genRequestDateString("yyyyMMdd HH:mm:ss");
        		// 정상 url
        		//String url = "http://106.10.58.21:18080/cj_fgms/restful/users?InterFaceID=INFRQW001&EmpTmpID="+EmpTmpId+"&HealthID="+UsrId+"&RequestDTM="+RequestDTM;
        		//String url = "https://www.biztam.net/cj_fgms/restful/users?InterFaceID=INFRQW001&EmpTmpID="+EmpTmpId+"&HealthID="+UsrId+"&RequestDTM="+RequestDTM;
        		//String url = "https://cjexpress.joinfaceone.com:8443/faceone/restful/users?InterFaceID=INFRQW001&EmpTmpID="+EmpTmpId+"&HealthID="+UsrId+"&RequestDTM="+RequestDTM;
        		String url = "https://cjexpress3.joinfaceone.com:8443/faceone/restful/users?InterFaceID=INFRQW001&EmpTmpID="+EmpTmpId+"&HealthID="+UsrId+"&RequestDTM="+RequestDTM;
        		//String url = "https://116.121.26.132/cj_fgms/restful/users?InterFaceID=INFRQW001&EmpTmpID="+EmpTmpId+"&HealthID="+UsrId+"&RequestDTM="+RequestDTM;
        		// 오류 발생용 url
//        		String url = "http://106.10.58.21:1808/cj_fgms/error/users?InterFaceID=INFRQW001&EmpTmpID="+EmpTmpId+"&HealthID="+UsrId+"&RequestDTM="+RequestDTM;
//        		String url = "http://106.10.58.21:18080/cj_fgms/restful/users?InterFaceID=INFRQW001&EmpTmpID=W19031400001&HealthID=1903120001&RequestDTM="+RequestDTM; // testing
        		String responseString = restTemplate.getForObject(url, String.class); // 서버 결과 return
        		LOGGER.debug("responseString" + responseString);
//        		http://106.10.58.21:18080/cj_fgms/restful/users?InterFaceID=INFRQW001&EmpTmpID=W19031400001&HealthID=1903120001&RequestDTM=20190314 15:29:29
//        		{"InterFaceID":"INFRPF001","HealthID":"1903120001","UserNM":"admin",
//        		"TelNO":"[+GqAH/y1FHh61WCdEhdnrg==[2t1KSX1/Cl7nvihJKeBg3A==[1GWVFyRrMF9pUuWjssv2qg==","BirthDT":null,"SexCD":null,
//        		"BelongNM":null,"EntryDT":"2017-05-15 23:08:33.0","WorkDy":null,"ContWorkDy":"3","RequestDTM":"20190407 21:38:28"}
        		JSONObject responseJSON = (JSONObject) new JSONParser().parse(responseString);

        		//userManageVO.setUsrNm(EgovStringUtil.isNullToString(responseJSON.get("UserNM")));

        		String healthID = EgovStringUtil.isNullToString(responseJSON.get("HealthID"));

        		//healthID = UsrId;	// 임시

				if(EgovStringUtil.isEmpty(healthID)) {

					if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(qsltVO.getUsrId()))) {
						LOGGER.debug("qsltVO.getUsrId(): "+ qsltVO.getUsrId());
	    				qsltService.doDeleteQslt(qsltVO);    				
	    			}
	    			if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(userManageVO.getUsrId()))) {
	    				LOGGER.debug("userManageVO.getUsrId(): "+ userManageVO.getUsrId());
		    			userManageService.doDelete(userManageVO);
	    			}

					modelAndView.addObject("success", false);
					modelAndView.addObject("error_msg", "정보에 해당하는 사용자가 존재하지 않습니다.");
					return modelAndView;
				}

        		CryptoUtil util = new CryptoUtil();
        		String encData = EgovStringUtil.isNullToString(responseJSON.get("TelNO"));
        		String masterKey = util.encryptSHA256(UsrId + RequestDTM);	// 대칭키
        		String decryptData = util.decryptAES128(masterKey, encData);
        		String masterKey2 = util.encryptSHA256(UsrId);	// 대칭키 (내부)
        		String encVal = decryptData == null ? "" : util.encryptAES128(masterKey2, decryptData) == null ? "" : util.encryptAES128(masterKey2, decryptData);
        		userManageVO.setConnTelno(encVal);

        		encData = EgovStringUtil.isNullToString(responseJSON.get("UserNM"));
        		masterKey = util.encryptSHA256(UsrId + RequestDTM);	// 대칭키
        		decryptData = util.decryptAES128(masterKey, encData);
        		LOGGER.debug("dec userNm : " + decryptData);
        		if("".equals(decryptData) || decryptData == null) {
        			userManageVO.setUsrNm(decryptData);
        		} else {
        			byte[] decBelongNM = Base64.decodeBase64(decryptData);
        			if(decBelongNM != null) {
        				userManageVO.setUsrNm(new String(decBelongNM));
        			}
        		}
        		LOGGER.debug("dec userNm new : " + userManageVO.getUsrNm());
        		//encVal = decryptData == null ? "" : util.encryptAES128(masterKey2, decryptData) == null ? "" : util.encryptAES128(masterKey2, decryptData);
        		//userManageVO.setUsrNm(encVal);

        		encData = EgovStringUtil.isNullToString(responseJSON.get("BirthDT"));
        		masterKey = util.encryptSHA256(UsrId + RequestDTM);	// 대칭키
        		decryptData = util.decryptAES128(masterKey, encData);
        		encVal = decryptData == null ? "" : util.encryptAES128(masterKey2, decryptData) == null ? "" : util.encryptAES128(masterKey2, decryptData);
        		userManageVO.setBirDt(encVal);

        		/*userManageVO.setConnTelno(EgovStringUtil.isNullToString(responseJSON.get("TelNO")));
        		if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(responseJSON.get("BirthDT")))) { // date 컬럼 null 오류 피하기 위해 확인
        			userManageVO.setBirDt(EgovStringUtil.isNullToString(responseJSON.get("BirthDT")));
        		}*/
        		/* SexCd 값 변경 */
        		String sexCd = EgovStringUtil.isNullToString(responseJSON.get("SexCD"));
        		userManageVO.setSexSecd("".equals(sexCd) ? "" : "M".equals(sexCd) ? "01" : "02");

        		/*JSONArray array = (JSONArray) responseJSON.get("BelongNM");
        		byte[] encArr = new byte[array.size()];
        		for(int i=0; i<array.size(); i++) {
        			Long data = (long) array.get(i);
        			encArr[i] = data.byteValue();
        		}*/
        		String belongNm = EgovStringUtil.isNullToString(responseJSON.get("BelongNM"));
        		if("".equals(belongNm)) {
            		userManageVO.setBegCd("");
        		} else {
        			byte[] decBelongNM = Base64.decodeBase64(belongNm);
        			if(decBelongNM != null) {
                		userManageVO.setBegCd(new String(decBelongNM));        				
        			}
        		}

        		if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(responseJSON.get("EntryDT")))) { // date 컬럼 null 오류 피하기 위해 확인
        			userManageVO.setEntryDt(EgovStringUtil.isNullToString(responseJSON.get("EntryDT")));
        		}
        		userManageVO.setDutyDy(EgovStringUtil.isNullToString(responseJSON.get("WorkDy")));
        		userManageVO.setContDutyDy(EgovStringUtil.isNullToString(responseJSON.get("ContWorkDy")));

        		Double usrHet = qsltVO.getUsrHet();
        		Double usrWet = qsltVO.getUsrWet();
        		userManageVO.setUsrHet(usrHet == null ? "0" : Double.toString(usrHet));		// 키
        		userManageVO.setUsrWet(usrWet == null ? "0" : Double.toString(usrWet));		// 몸무게

        		if("N".equals(qsltVO.getAlcYn())) {																		// 음주 여부
        			userManageVO.setAlcYn("0");
        		} else {
        			userManageVO.setAlcYn("1");
        		}

        		if("N".equals(qsltVO.getSmkYn())) {																	// 흡연 여부
        			userManageVO.setSmkYn("0");
        		} else {
        			userManageVO.setSmkYn("1");
        		}

        		userManageVO.setBldtyCd(qsltVO.getBldtyCd()); 												// 혈액형
        		userManageVO.setUseYn("Y"); // NOT NULL 오류 회피용
        		userManageVO.setUsrAge(qsltVO.getUsrAge()); 
        		userManageVO.setHighDgrCd(qsltVO.getHighDgrCd()); // NOT NULL 오류 회피용
        		userManageVO.setEduDt(null); // NOT NULL 오류 회피용

        		LOGGER.debug("userManageVO 설정 완료.");

        		// 사용자 정보 update
        		userManageService.doUpdate(userManageVO);
        		LOGGER.debug("doSave 실행 완료.");

        		userLogService.logInsertUserLog("system", "qsltRegist", "I", healthID);

        		// 사용자 정보 수집 로그 삽입
    		}

    	} catch (Exception e) {
    		
    		// 신규 쓰기 작업중 오류가 발생하면 신규 UsrId 삭제. 
    		if(! "doUpdateQslt".equals(ActionMode)) { //
    			LOGGER.debug("오류 발생으로 신규 UsrId삭제 시작");
    			if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(qsltVO.getUsrId()))) {
    				LOGGER.debug("qsltVO.getUsrId(): "+ qsltVO.getUsrId());
    				qsltService.doDeleteQslt(qsltVO);    				
    			}
    			if(! EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(userManageVO.getUsrId()))) {
    				LOGGER.debug("userManageVO.getUsrId(): "+ userManageVO.getUsrId());
	    			userManageService.doDelete(userManageVO);
    			}
    			LOGGER.debug("오류 발생으로 신규 UsrId삭제 끝");
    		}

			// json 응답 내보내는 부분
			e.printStackTrace();
			modelAndView.addObject("success", false);
			modelAndView.addObject("error_msg", "문진표를 작성하지 못했습니다.");
			return modelAndView;
			
		}
    	
		modelAndView.addObject("success", true);
		modelAndView.addObject("error_msg", "");
		
		return modelAndView;
	}

	/** 문진표 완료 페이지 */
	@RequestMapping(value="/whms/hi/qsltComplete.do")
	public String qsltComplete( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		return "egovframework/whms/hi/qslt/qsltComplete";
	}

	/**
	 * AES 128 복호화
	 * @param encrypte
	 * @return
	 * @throws Exception
	 */
	public static String decrypt(String encrypted) throws Exception{
		String r = "";
	    if(encrypted == null){
	    }else{
	    	String key = "1234567890"; // 복호화 키.
	        SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(), "AES");
	        Cipher cipher = Cipher.getInstance("AES");
	        cipher.init(Cipher.DECRYPT_MODE, secretKeySpec);
	        byte[] original = cipher.doFinal(hexToByteArray(encrypted));
	        String originalStr = new String(original);
	        r = originalStr;
	    }
	    return r;
	}
	private static byte[] hexToByteArray(String hex) {
	    if(hex == null || hex.length() == 0){
	        return null;
	    }
	    //16진수 문자열을 byte로 변환
	    byte[] byteArray = new byte[hex.length() /2 ];
	    for(int i=0; i<byteArray.length; i++){
	        byteArray[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2*i+2), 16);
	    }
	    return byteArray;
	}

	private String genRequestDateString( String sFormat ) throws Exception {
		Date today = new Date();
		SimpleDateFormat datetime = new SimpleDateFormat(sFormat); 
		String RequestDTM = datetime.format(today);
		return RequestDTM;
	}
	
	
	/** 상세페이지 */
	@RequestMapping(value="/whms/hi/qsltDetail.do")
	public String qsltView( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		QsltVO detailVO = qsltService.selectQsltDetail(qsltVO);
		model.addAttribute("detailVO", detailVO);
		return "egovframework/whms/hi/qslt/qsltDetail";
	}
	
	/** 수정 폼 및 수정 로직 */
	@RequestMapping(value="/whms/hi/qsltUpdate.do")
	public String qsltUpdate( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String flag = EgovStringUtil.isNullToString(request.getParameter("flag"));
		QsltVO detailVO = qsltService.selectQsltDetail(qsltVO);
		model.addAttribute("detailVO", detailVO);
		if("U".equals(flag)) {		// flag가 R일 경우 저장 로직 적용
			qsltVO.setTargetDt(qsltVO.getMakeDt());
			qsltService.doUpdateQslt(qsltVO);
			return "forward:/whms/qsltDetail.do";
		}
		return "egovframework/whms/hi/qslt/qsltUpdate";
	}

	/** 삭제 로직 */
	@RequestMapping(value="/whms/hi/qsltDelete.do")
	public String qsltDelete( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		qsltService.doDeleteQslt(qsltVO);
		return "forward:/whms/hi/qslt/qsltList.do";
	}
	
	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/hi/qsltDataAjax.do")
	public ModelAndView qsltDataAjax(@ModelAttribute("searchVO") QsltVO qsltVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			List<QsltVO> qsltList = qsltService.selectQsltList(qsltVO);
			modelAndView.addObject("qsltList", qsltList);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("qsltList", null);
		}

		return modelAndView;
	}

	/**
	 * 문진표 작성 가능한 날짜인지 확인.
	 * @param pDate 마지막 수정날자.
	 * @return 작성 가능여부. true: 작성 가능 , false: 작성 불가.
	 * @throws Exception
	 */
	private Boolean checkWriteableDate(String pDate) throws Exception {
		Boolean r = false;
		SimpleDateFormat df= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date RegDate = df.parse(pDate);
		Date CurDate = new Date();
		long diffTime = CurDate.getTime() - RegDate.getTime();
		long diffDate = Math.abs(diffTime / (24*60*60*1000));
		if(diffDate>30*6) {// 작성일이 6개월 지난경우 미작성으로 리턴.
			r = true;
		}
		return r;
	}
	
	/** 문진표작성여부 */
	@RequestMapping(value = "/whms/INFRQF002.do")
	public ModelAndView INFRQF002( HttpServletRequest request ) throws Exception {

		QsltVO qsltVO = new QsltVO();
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");
    	String ForwardUrl = "";

    	String checkId = EgovStringUtil.isNullToString(request.getParameter("InterFaceID"));

    	if("INFRQF002".equals(checkId)) {
	    	String usrId = EgovStringUtil.isNullToString(request.getParameter("HealthID"));
	
			try {
				LOGGER.debug("before usrId : " + usrId);
				qsltVO.setUsrId(usrId);
				LOGGER.debug("after usrId : " + qsltVO.getUsrId());
	
				QsltVO detailVO = qsltService.selectQsltDetail(qsltVO);
				if(detailVO == null) {
					modelAndView.addObject("HealthID", usrId);
					modelAndView.addObject("HealWrtYn", "N");
					//ForwardUrl = "http://14.51.236.206:3979/whms/hi/qsltRegist.do?HealthID="+usrId+"&EmpTmpId=";
					ForwardUrl = "https://www.whmscnko.co.kr:3979/whms/hi/qsltRegist.do?HealthID="+usrId+"&EmpTmpId=";
					modelAndView.addObject("ForwardUrl", ForwardUrl);
					/*modelAndView.setViewName("forward:/whms/hi/qsltRegist.do?HealthID="+newUsrId+"&EmpTmpId=");
					return modelAndView;*/
				} else {
					usrId = EgovStringUtil.isNullToString(detailVO.getUsrId());
					// 작성일 없는 경우 미작성으로 리턴.
					String dbSysUpdDt = EgovStringUtil.isNullToString(detailVO.getSysUpdDt());
					String dbUsrId = EgovStringUtil.isNullToString(detailVO.getUsrId());
					String dbEmpTmpId = EgovStringUtil.isNullToString(detailVO.getEmpTmpId());
					if("".equals(dbSysUpdDt) ) {
						modelAndView.addObject("HealthID", dbUsrId); // qsltVO.getUsrId()
						modelAndView.addObject("EmpTmpId", dbEmpTmpId);
						modelAndView.addObject("HealWrtYn", "N");
						ForwardUrl = "https://www.whmscnko.co.kr:3979/whms/hi/qsltRegist.do?HealthID="+dbUsrId+"&EmpTmpId="+dbEmpTmpId;
						modelAndView.addObject("ForwardUrl", ForwardUrl);
						/*modelAndView.setViewName("forward:/whms/hi/qsltRegist.do?HealthID="+dbUsrId+"&EmpTmpId="+dbEmpTmpId);
						return modelAndView;*/
					} else {
						// 작성일이 6개월 지난경우 미작성으로 리턴.
						if(this.checkWriteableDate(dbSysUpdDt)) {
							modelAndView.addObject("HealthID", dbUsrId);
							modelAndView.addObject("EmpTmpId", dbEmpTmpId);
							modelAndView.addObject("HealWrtYn", "N");
							ForwardUrl = "https://www.whmscnko.co.kr:3979/whms/hi/qsltRegist.do?HealthID="+dbUsrId+"&EmpTmpId="+dbEmpTmpId;
							modelAndView.addObject("ForwardUrl", ForwardUrl);
							/*modelAndView.setViewName("forward:/whms/hi/qsltRegist.do?HealthID="+dbUsrId+"&EmpTmpId="+dbEmpTmpId);
							return modelAndView;*/
						} else { // 이미 작성한 경우(6개월 이내)
							// json 응답 내보내는 부분
							modelAndView.addObject("HealthID", dbUsrId);
							modelAndView.addObject("EmpTmpId", dbEmpTmpId);
							modelAndView.addObject("HealWrtYn", "Y");
						}
					}
				}
			} catch (Exception e) {
				// json 응답 내보내는 부분
				e.printStackTrace();
				modelAndView.addObject("HealthID", usrId);
				//modelAndView.addObject("EmpTmpId", "");
				modelAndView.addObject("HealWrtYn", "N");
			}
	
			// json 응답 내보내는 부분
			modelAndView.addObject("InterFaceID", "INFRQW002");
			modelAndView.addObject("RequestDTM", request.getParameter("RequestDTM"));
    	} else {
    		LOGGER.debug("INFRQF002 InterfaceID Error");
    		modelAndView.addObject("InterFaceID", "INFRQW002");
    		modelAndView.addObject("HealthID", "");
    		modelAndView.addObject("HealWrtYn", "N");
    		modelAndView.addObject("RequestDTM", request.getParameter("RequestDTM"));
    		modelAndView.addObject("ForwardUrl", null);
    		modelAndView.addObject("errorMsg", "[오류] InterfaceID가 상이합니다.");
    	}

		return modelAndView;
	}

//	/** 입력 & 수정 (Ajax) */
//	@RequestMapping(value = "/whms/hi/qsltSaveAjax.do")
//	public ModelAndView qsltSaveAjax(@ModelAttribute("searchVO") QsltVO qsltVO) throws Exception {
//
//		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//    	ModelAndView modelAndView = new ModelAndView();
//    	modelAndView.setViewName("jsonView");
//
//		try {
////			qsltVO.setFrstRegisterId(user.getId());
////			qsltVO.setLastUpdusrId(user.getId());
////			if(qsltVO.getDate() == null || "".equals(qsltVO.getDate())) {
////				qsltVO.setDate(null);
////			} else {
////				qsltVO.setDate(qsltVO.getDate().replaceAll("-", ""));
////			}
//			qsltService.doSaveQslt(qsltVO);
//			modelAndView.addObject("result", true);
//		} catch (Exception e) {
//			e.printStackTrace();
//			modelAndView.addObject("result", false);
//		}
//
//		return modelAndView;
//	}

	/** 수정 (Ajax) */
	@RequestMapping(value = "/whms/hi/qsltUpdateAjax.do")
	public ModelAndView qsltUpdateAjax(@ModelAttribute("searchVO") QsltVO qsltVO, HttpServletRequest request) throws Exception {

    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			modelAndView.addObject("result", false);
			return modelAndView;
		}

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		try {
			qsltVO = this.setYnValues( qsltVO, request );
			qsltVO.setUpdId(user.getId());
			qsltVO.setBirDt(EgovStringUtil.isNullToString(qsltVO.getBirDt()).replaceAll("-", ""));

			UserManageVO userManageVO = new UserManageVO();
			userManageVO.setUseGrpCd(qsltVO.getUseGrpCd());
			userManageVO.setUsrId(qsltVO.getUsrId());
			UserManageVO userVO = userManageService.selectData(userManageVO);

			String highDgrCd = qsltVO.getHighDgrCd();
			if("21".equals(highDgrCd)) {
				userManageVO.setHighDgrCd("21");
			} else {
				String hypctCt = userVO.getHypctCt() == null ? "0" : userVO.getHypctCt();
				String hyprxCt = userVO.getHyprxCt() == null ? "0" : userVO.getHyprxCt();
				if(Double.valueOf(hypctCt) >= 160
						|| Double.valueOf(hyprxCt) >= 100 ) {
					userManageVO.setHighDgrCd("21");
				} else if(Double.valueOf(hypctCt) >= 150
						|| Double.valueOf(hyprxCt) >= 95 ) {
					userManageVO.setHighDgrCd("22");
				} else if(Double.valueOf(hypctCt) >= 140
						|| Double.valueOf(hyprxCt) >= 90 ) {
					userManageVO.setHighDgrCd("23");
				} else if(Double.valueOf(hypctCt) < 140
						|| Double.valueOf(hyprxCt) < 90 ) {
					userManageVO.setHighDgrCd("24");
				}
			}

			String DysmkCt = EgovStringUtil.isNullToString(qsltVO.getDysmkCt());
			String WekAlcCt = EgovStringUtil.isNullToString(qsltVO.getWekAlcCt());
			String AdrkCt = EgovStringUtil.isNullToString(qsltVO.getAdrkCt());
			String usrHet = EgovStringUtil.isNullToString(qsltVO.getUsrHet());
			String usrWet = EgovStringUtil.isNullToString(qsltVO.getUsrWet());
			if("".equals(usrHet)) qsltVO.setUsrHet(0.0);
			if("".equals(usrWet)) qsltVO.setUsrWet(0.0);
			if("".equals(DysmkCt)) qsltVO.setDysmkCt("0");
			if("".equals(WekAlcCt)) qsltVO.setWekAlcCt("0");
			if("".equals(AdrkCt)) qsltVO.setAdrkCt("0");

			qsltService.doUpdateQslt(qsltVO);

    		// 사용자 고위험군 정보 update
    		userManageService.doUpdateHighDgrCd(userManageVO);

    		userLogService.logInsertUserLog(user.getId(), "qsltList", "U", userManageVO.getUsrId());

			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	/** 삭제 (Ajax) */
	@RequestMapping(value = "/whms/hi/qsltDeleteAjax.do")
	public ModelAndView qsltDeleteAjax(@ModelAttribute("searchVO") QsltVO qsltVO) throws Exception {

    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			qsltService.doDeleteQslt(qsltVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/hi/qsltListPopup.do")
	public String qsltListPopup( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();

		String paramId = EgovStringUtil.isNullToString(request.getParameter("paramId"));

		if(!"".equals(paramId)) {
			qsltVO.setSearchCondition("USR_ID");
			qsltVO.setSearchKeyword(paramId);

			qsltVO.setLoginAuthorCd(user.getAuthorCd());
			qsltVO.setLoginAuthorType(user.getAuthorType());
	
			QsltVO detailVO = qsltService.selectQsltInfo(qsltVO);
			detailVO = this.decYnValues(detailVO);
			model.addAttribute("detailVO", detailVO);
			userLogService.logInsertUserLog(user.getId(), "qsltList", "R","");
		
		}

		model.addAttribute("useGrpCdList", userManageService.selectUseGrpCdList(new UserManageVO()));

		return "egovframework/whms/hi/qslt/qsltListPopup";
	}

	/** 등록 로직 - ajax */
	@RequestMapping(value="/whms/hi/qsltRegistPopupAjax.do")
	public ModelAndView qsltRegistPopupAjax( @ModelAttribute("searchVO") QsltVO qsltVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		LOGGER.debug("qsltRegistPopupAjax start");

    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		String sysdate = this.genRequestDateString("yyyy-MM-dd HH:mm:ss");
		qsltVO.setSysRgsDt(sysdate);
		qsltVO.setSysUpdDt(sysdate);

    	try {

    		qsltVO = this.setYnValues( qsltVO, request );

    		// 문진표 저장.
			String DysmkCt = EgovStringUtil.isNullToString(qsltVO.getDysmkCt());
			String WekAlcCt = EgovStringUtil.isNullToString(qsltVO.getWekAlcCt());
			String AdrkCt = EgovStringUtil.isNullToString(qsltVO.getAdrkCt());
			String usrHetChk = EgovStringUtil.isNullToString(qsltVO.getUsrHet());
			String usrWetChk = EgovStringUtil.isNullToString(qsltVO.getUsrWet());
			if("".equals(usrHetChk)) qsltVO.setUsrHet(0.0);
			if("".equals(usrWetChk)) qsltVO.setUsrWet(0.0);
			if("".equals(DysmkCt)) qsltVO.setDysmkCt("0");
			if("".equals(WekAlcCt)) qsltVO.setWekAlcCt("0");
			if("".equals(AdrkCt)) qsltVO.setAdrkCt("0");
			qsltService.doRegistQslt(qsltVO);

    		// 사용자 정보 준비.
    		UserManageVO userManageVO = new UserManageVO();
    		userManageVO.setUsrId(qsltVO.getUsrId());
    		userManageVO.setUseGrpCd(qsltVO.getUseGrpCd());
			UserManageVO userVO = userManageService.selectData(userManageVO);
			userManageVO.setUsrNm(userVO.getUsrNm());

    		String highDgrCd = qsltVO.getHighDgrCd();
			if("21".equals(highDgrCd)) {
				userManageVO.setHighDgrCd("21");
			} else {

				CryptoUtil util = new CryptoUtil();
				String healthId = userManageVO.getUsrId();
				String masterKey = util.encryptSHA256(healthId);

				String hypctCt = userVO.getHypctCt() == null ? "0" : util.decryptAES128(masterKey, userVO.getHypctCt()) == null ? "0" : util.decryptAES128(masterKey, userVO.getHypctCt());
				String hyprxCt = userVO.getHyprxCt() == null ? "0" : util.decryptAES128(masterKey, userVO.getHyprxCt()) == null ? "0" : util.decryptAES128(masterKey, userVO.getHyprxCt());

				if(Double.valueOf(hypctCt) >= 160
						|| Double.valueOf(hyprxCt) >= 100 ) {
					userManageVO.setHighDgrCd("21");
				} else if(Double.valueOf(hypctCt) >= 150
						|| Double.valueOf(hyprxCt) >= 95 ) {
					userManageVO.setHighDgrCd("22");
				} else if(Double.valueOf(hypctCt) >= 140
						|| Double.valueOf(hyprxCt) >= 90 ) {
					userManageVO.setHighDgrCd("23");
				} else if(Double.valueOf(hypctCt) < 140
						|| Double.valueOf(hyprxCt) < 90 ) {
					userManageVO.setHighDgrCd("24");
				}
			}

    		Double usrHet = qsltVO.getUsrHet();
			Double usrWet = qsltVO.getUsrWet();
			userManageVO.setUsrHet(usrHet == null ? "0" : Double.toString(usrHet)); // 키
			userManageVO.setUsrWet(usrWet == null ? "0" : Double.toString(usrWet)); // 몸무게

			if ("N".equals(qsltVO.getAlcYn())) { // 음주 여부
				userManageVO.setAlcYn("0");
			} else {
				userManageVO.setAlcYn("1");
			}

			if ("N".equals(qsltVO.getSmkYn())) { // 흡연 여부
				userManageVO.setSmkYn("0");
			} else {
				userManageVO.setSmkYn("1");
			}

			userManageVO.setBldtyCd(qsltVO.getBldtyCd()); // 혈액형
			userManageVO.setUseYn("Y"); // NOT NULL 오류 회피용
			userManageVO.setUsrAge(qsltVO.getUsrAge());
			userManageVO.setEduDt(null); // NOT NULL 오류 회피용

			LOGGER.debug("userManageVO 설정 완료.");

        		// 사용자 정보 update
        		userManageService.doUpdatePopup(userManageVO);
        		LOGGER.debug("doSave 실행 완료.");

        		userLogService.logInsertUserLog("system", "qsltRegist", "I", qsltVO.getUsrId());

    	} catch (Exception e) {
			// json 응답 내보내는 부분
			e.printStackTrace();
			modelAndView.addObject("success", false);
			modelAndView.addObject("error_msg", "문진표 신규 저장에 실패하였습니다.");
			return modelAndView;
		}

		modelAndView.addObject("success", true);
		modelAndView.addObject("error_msg", "");

		return modelAndView;
	}

	/** 문진표 데이터 암호화 sync */
//	@ResponseBody
//	@RequestMapping(value="/whms/hi/qsltDataEncSync.do")
//	public String qsltDataEncSync( @ModelAttribute("searchVO") QsltVO qsltVO
//			, HttpServletRequest request
//			, HttpServletResponse response
//			, ModelMap model) throws Exception {
//		try {
//			List<QsltVO> list = qsltService.selectQsltList(qsltVO);			// 문진표 리스트 조회
//			if(list != null && list.size() > 0) {
//				for(QsltVO vo : list) {
//					QsltVO encVO = this.encYnValues(vo);					// 문진표 항목 암호화
//					encVO.setTargetDt(vo.getMakeDt());
//					qsltService.doUpdateQsltYnValues(encVO);
//				}
//				return "true";
//			} else {
//				return "false";
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "false";
//		}
//	}

	/** 문진표 데이터 복구 */
//	@ResponseBody
//	@RequestMapping(value="/whms/hi/qsltDataDecSync.do")
//	public String qsltDataDecSync( @ModelAttribute("searchVO") QsltVO qsltVO
//			, HttpServletRequest request
//			, HttpServletResponse response
//			, ModelMap model) throws Exception {
//		try {
//			List<QsltVO> list = qsltService.selectQsltList(qsltVO);			// 문진표 리스트 조회
//			if(list != null && list.size() > 0) {
//				for(QsltVO vo : list) {
//					QsltVO decVO = this.decYnValuesDetail(vo);					// 문진표 항목 암호화
//					decVO.setTargetDt(vo.getMakeDt());
//					qsltService.doUpdateQsltYnValues(decVO);
//				}
//				return "true";
//			} else {
//				return "false";
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "false";
//		}
//	}

	/** 문진표 기타 데이터 복구 */
//	@ResponseBody
//	@RequestMapping(value="/whms/hi/qsltDataDecSync2.do")
//	public String qsltDataDecSync2( @ModelAttribute("searchVO") QsltVO qsltVO
//			, HttpServletRequest request
//			, HttpServletResponse response
//			, ModelMap model) throws Exception {
//		try {
//			List<QsltVO> list = qsltService.selectQsltEtcList(qsltVO);			// 문진표 리스트 조회
//			if(list != null && list.size() > 0) {
//				for(QsltVO vo : list) {
//					QsltVO decVO = this.decYnValuesEtcDetail(vo);					// 문진표 항목 암호화
//					decVO.setTargetDt(vo.getMakeDt());
//					qsltService.doUpdateQsltYnEtcValues(decVO);
//				}
//				return "true";
//			} else {
//				return "false";
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "false";
//		}
//	}

	/** 문진표 데이터 암호화 sync2 */
//	@ResponseBody
//	@RequestMapping(value="/whms/hi/qsltDataEncSync2.do")
//	public String qsltDataEncSync2( @ModelAttribute("searchVO") QsltVO qsltVO
//			, HttpServletRequest request
//			, HttpServletResponse response
//			, ModelMap model) throws Exception {
//		try {
//			List<QsltVO> list = qsltService.selectQsltEtcList(qsltVO);			// 문진표 리스트 조회
//			if(list != null && list.size() > 0) {
//				for(QsltVO vo : list) {
//					QsltVO encVO = this.encYnValuesEtc(vo);					// 문진표 항목 암호화
//					encVO.setTargetDt(vo.getMakeDt());
//					qsltService.doUpdateQsltYnEtcValues(encVO);
//				}
//				return "true";
//			} else {
//				return "false";
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			return "false";
//		}
//	}

//	private QsltVO encYnValuesEtc(QsltVO qsltVO) throws Exception {
//
//		String UsrId = qsltVO.getUsrId();
//
//		CryptoUtil util = new CryptoUtil();
//		String masterKey = util.encryptSHA256(UsrId);	// 대칭키
//		qsltVO.setFahsEtc("".equals(qsltVO.getFahsEtc()) ? "" : util.encryptAES128(masterKey, qsltVO.getFahsEtc()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getFahsEtc()));
//
//		qsltVO.setHavdisEtc("".equals(qsltVO.getHavdisEtc()) ? "" : util.encryptAES128(masterKey, qsltVO.getHavdisEtc()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getHavdisEtc()));
//
//		qsltVO.setInddistEtc("".equals(qsltVO.getInddistEtc()) ? "" : util.encryptAES128(masterKey, qsltVO.getInddistEtc()) == null ? "" : util.encryptAES128(masterKey, qsltVO.getInddistEtc()));
//
//		return qsltVO;
//	}
//
//	private QsltVO decYnValuesEtcDetail(QsltVO qsltVO) throws Exception {
//		String UsrId = qsltVO.getUsrId();
//
//		CryptoUtil util = new CryptoUtil();
//		String masterKey = util.encryptSHA256(UsrId);	// 대칭키
//
//		String fahsEtc = qsltVO.getFahsEtc();
//		String havdisEtc = qsltVO.getHavdisEtc();
//		String inddistEtc = qsltVO.getInddistEtc();
//
//		String decFahs1 = fahsEtc == null || "".contentEquals(fahsEtc) ? "" : util.decryptAES128Etc(masterKey, fahsEtc) == null ? "" : util.decryptAES128Etc(masterKey, fahsEtc);
//		String decFahs2 = util.decryptAES128Etc(masterKey, decFahs1) == null ? "" : util.decryptAES128Etc(masterKey, decFahs1);
//		String decFahs3 = util.decryptAES128Etc(masterKey, decFahs2) == null ? "" : util.decryptAES128Etc(masterKey, decFahs2);
//		String decFahs4 = util.decryptAES128Etc(masterKey, decFahs3) == null ? "" : util.decryptAES128Etc(masterKey, decFahs3);
//		if(decFahs1 == null || "".contentEquals(decFahs1)) {
//			qsltVO.setFahsEtc("");
//		} else {
//			if(decFahs2 == null || "".contentEquals(decFahs2)) {
//				qsltVO.setFahsEtc(decFahs1);
//			} else {
//				if(decFahs3 == null || "".contentEquals(decFahs3)) {
//					qsltVO.setFahsEtc(decFahs2);
//				} else {
//					if(decFahs4 == null || "".contentEquals(decFahs4)) {
//						qsltVO.setFahsEtc(decFahs3);
//					} else {
//						qsltVO.setFahsEtc(fahsEtc);
//					}
//				}
//			}
//		}
//
//		String decHavdis1 = havdisEtc == null || "".contentEquals(havdisEtc) ? "" :util.decryptAES128Etc(masterKey, havdisEtc) == null ? "" : util.decryptAES128Etc(masterKey, havdisEtc);
//		String decHavdis2 = util.decryptAES128Etc(masterKey, decHavdis1) == null ? "" : util.decryptAES128Etc(masterKey, decHavdis1);
//		String decHavdis3 = util.decryptAES128Etc(masterKey, decHavdis2) == null ? "" : util.decryptAES128Etc(masterKey, decHavdis2);
//		String decHavdis4 = util.decryptAES128Etc(masterKey, decHavdis3) == null ? "" : util.decryptAES128Etc(masterKey, decHavdis3);
//
//		if(decHavdis1 == null || "".contentEquals(decHavdis1)) {
//			qsltVO.setHavdisEtc("");
//		} else {
//			if(decHavdis2 == null || "".contentEquals(decHavdis2)) {
//				qsltVO.setHavdisEtc(decHavdis1);
//			} else {
//				if(decHavdis3 == null || "".contentEquals(decHavdis3)) {
//					qsltVO.setHavdisEtc(decHavdis2);
//				} else {
//					if(decHavdis4 == null || "".contentEquals(decHavdis4)) {
//						qsltVO.setHavdisEtc(decHavdis3);
//					} else {
//						qsltVO.setHavdisEtc(fahsEtc);
//					}
//				}
//			}
//		}
//
//		String decInddist1 = inddistEtc == null || "".contentEquals(inddistEtc) ? "" :util.decryptAES128Etc(masterKey, inddistEtc) == null ? "" : util.decryptAES128Etc(masterKey, inddistEtc);
//		String decInddist2 = util.decryptAES128Etc(masterKey, decInddist1) == null ? "" : util.decryptAES128Etc(masterKey, decInddist1);
//		String decInddist3 = util.decryptAES128Etc(masterKey, decInddist2) == null ? "" : util.decryptAES128Etc(masterKey, decInddist2);
//		String decInddist4 = util.decryptAES128Etc(masterKey, decInddist3) == null ? "" : util.decryptAES128Etc(masterKey, decInddist3);
//
//		if(decInddist1 == null || "".contentEquals(decInddist1)) {
//			qsltVO.setInddistEtc("");
//		} else {
//			if(decInddist2 == null || "".contentEquals(decInddist2)) {
//				qsltVO.setInddistEtc(decInddist1);
//			} else {
//				if(decInddist3 == null || "".contentEquals(decInddist3)) {
//					qsltVO.setInddistEtc(decInddist2);
//				} else {
//					if(decInddist4 == null || "".contentEquals(decInddist4)) {
//						qsltVO.setInddistEtc(decInddist3);
//					} else {
//						qsltVO.setInddistEtc(fahsEtc);
//					}
//				}
//			}
//		}
//
//		return qsltVO;
//	}
//
//	private QsltVO decYnValuesDetail(QsltVO qsltVO) throws Exception {
//
//		String UsrId = qsltVO.getUsrId();
//		String SysUpdDt = qsltVO.getSysUpdDt().replaceAll("-", "").substring(0,8);
//
//		CryptoUtil util = new CryptoUtil();
//		String masterKey = util.encryptSHA256(UsrId);	// 대칭키
//
//		String fahsYn = EgovStringUtil.isEmpty(qsltVO.getFahsYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn());
//
//		if(!"".contentEquals(fahsYn)) {
//			if("Y".contentEquals(fahsYn.replace(SysUpdDt, "")) || "N".contentEquals(fahsYn.replace(SysUpdDt, ""))) {
//				qsltVO.setFahsYn(EgovStringUtil.isEmpty(qsltVO.getFahsYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn()).substring(0,1));
//				qsltVO.setFahs1Yn(EgovStringUtil.isEmpty(qsltVO.getFahs1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs1Yn()).substring(0,1));
//				qsltVO.setFahs2Yn(EgovStringUtil.isEmpty(qsltVO.getFahs2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs2Yn()).substring(0,1));
//				qsltVO.setFahs3Yn(EgovStringUtil.isEmpty(qsltVO.getFahs3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs3Yn()).substring(0,1));
//				qsltVO.setFahs4Yn(EgovStringUtil.isEmpty(qsltVO.getFahs4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs4Yn()).substring(0,1));
//				qsltVO.setFahs5Yn(EgovStringUtil.isEmpty(qsltVO.getFahs5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs5Yn()).substring(0,1));
//				qsltVO.setFahs6Yn(EgovStringUtil.isEmpty(qsltVO.getFahs6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahs6Yn()).substring(0,1));
//				qsltVO.setFahsEtc(EgovStringUtil.isEmpty(qsltVO.getFahsEtc()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahsEtc()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getFahsEtc()));
//				//qsltVO.setFahsEtc(qsltVO.getFahsEtc());
//	
//				qsltVO.setHavdisYn(EgovStringUtil.isEmpty(qsltVO.getHavdisYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisYn()).substring(0,1));
//				qsltVO.setHavdis1Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis1Yn()).substring(0,1));
//				qsltVO.setHavdis2Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis2Yn()).substring(0,1));
//				qsltVO.setHavdis3Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis3Yn()).substring(0,1));
//				qsltVO.setHavdis4Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis4Yn()).substring(0,1));
//				qsltVO.setHavdis5Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis5Yn()).substring(0,1));
//				qsltVO.setHavdis6Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis6Yn()).substring(0,1));
//				qsltVO.setHavdis7Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis7Yn()).substring(0,1));
//				qsltVO.setHavdis8Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis8Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis8Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis8Yn()).substring(0,1));
//				qsltVO.setHavdisEtc(EgovStringUtil.isEmpty(qsltVO.getHavdisEtc()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisEtc()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisEtc()));
//				//qsltVO.setHavdisEtc(qsltVO.getHavdisEtc());
//	
//				qsltVO.setMoaciYn(EgovStringUtil.isEmpty(qsltVO.getMoaciYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaciYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaciYn()).substring(0,1));
//				qsltVO.setMoaci1Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci1Yn()).substring(0,1));
//				qsltVO.setMoaci2Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci2Yn()).substring(0,1));
//				qsltVO.setMoaci3Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci3Yn()).substring(0,1));
//				qsltVO.setMoaci4Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci4Yn()).substring(0,1));
//				qsltVO.setMoaci5Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci5Yn()).substring(0,1));
//				qsltVO.setMoaci6Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci6Yn()).substring(0,1));
//				qsltVO.setMoaci7Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci7Yn()).substring(0,1));
//	
//				qsltVO.setWkpnYn(EgovStringUtil.isEmpty(qsltVO.getWkpnYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpnYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpnYn()).substring(0,1));
//				qsltVO.setWkpn1Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn1Yn()).substring(0,1));
//				qsltVO.setWkpn2Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn2Yn()).substring(0,1));
//				qsltVO.setWkpn3Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn3Yn()).substring(0,1));
//				qsltVO.setWkpn4Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn4Yn()).substring(0,1));
//				qsltVO.setWkpn5Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn5Yn()).substring(0,1));
//				qsltVO.setWkpn6Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn6Yn()).substring(0,1));
//				qsltVO.setWkpn7Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn7Yn()).substring(0,1));
//	
//				qsltVO.setRepsym1Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym1Yn()).substring(0,1));
//				qsltVO.setRepsym2Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym2Yn()).substring(0,1));
//				qsltVO.setRepsym3Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym3Yn()).substring(0,1));
//				qsltVO.setRepsym4Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym4Yn()).substring(0,1));
//				qsltVO.setRepsym5Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym5Yn()).substring(0,1));
//
//				qsltVO.setCirsym1Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym1Yn()).substring(0,1));
//				qsltVO.setCirsym2Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym2Yn()).substring(0,1));
//				qsltVO.setCirsym3Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym3Yn()).substring(0,1));
//				qsltVO.setCirsym4Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym4Yn()).substring(0,1));
//				qsltVO.setCirsym5Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym5Yn()).substring(0,1));
//				qsltVO.setCirsym6Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym6Yn()).substring(0,1));
//				qsltVO.setCirsym7Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym7Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym7Yn()).substring(0,1));
//
//				qsltVO.setInddistYn(EgovStringUtil.isEmpty(qsltVO.getInddistYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddistYn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddistYn()).substring(0,1));
//				qsltVO.setInddist1Yn(EgovStringUtil.isEmpty(qsltVO.getInddist1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist1Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist1Yn()).substring(0,1));
//				qsltVO.setInddist2Yn(EgovStringUtil.isEmpty(qsltVO.getInddist2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist2Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist2Yn()).substring(0,1));
//				qsltVO.setInddist3Yn(EgovStringUtil.isEmpty(qsltVO.getInddist3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist3Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist3Yn()).substring(0,1));
//				qsltVO.setInddist4Yn(EgovStringUtil.isEmpty(qsltVO.getInddist4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist4Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist4Yn()).substring(0,1));
//				qsltVO.setInddist5Yn(EgovStringUtil.isEmpty(qsltVO.getInddist5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist5Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist5Yn()).substring(0,1));
//				qsltVO.setInddist6Yn(EgovStringUtil.isEmpty(qsltVO.getInddist6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist6Yn()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddist6Yn()).substring(0,1));
//				qsltVO.setInddistEtc(EgovStringUtil.isEmpty(qsltVO.getInddistEtc()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddistEtc()) == null ? "" : util.decryptAES128(masterKey, qsltVO.getInddistEtc()));
//				//qsltVO.setInddistEtc(qsltVO.getInddistEtc());
//			} else {
//				qsltVO.setFahsYn(EgovStringUtil.isEmpty(qsltVO.getFahsYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahsYn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahsYn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahs1Yn(EgovStringUtil.isEmpty(qsltVO.getFahs1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahs1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahs2Yn(EgovStringUtil.isEmpty(qsltVO.getFahs2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahs2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahs3Yn(EgovStringUtil.isEmpty(qsltVO.getFahs3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahs3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahs4Yn(EgovStringUtil.isEmpty(qsltVO.getFahs4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahs4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahs5Yn(EgovStringUtil.isEmpty(qsltVO.getFahs5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahs5Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahs6Yn(EgovStringUtil.isEmpty(qsltVO.getFahs6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getFahs6Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getFahs6Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setFahsEtc(qsltVO.getFahsEtc());
//
//				qsltVO.setHavdisYn(EgovStringUtil.isEmpty(qsltVO.getHavdisYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdisYn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdisYn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis1Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis2Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis3Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis4Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis5Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis5Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis6Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis6Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis6Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis7Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis7Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis7Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdis8Yn(EgovStringUtil.isEmpty(qsltVO.getHavdis8Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getHavdis8Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getHavdis8Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setHavdisEtc(qsltVO.getHavdisEtc());
//
//				qsltVO.setMoaciYn(EgovStringUtil.isEmpty(qsltVO.getMoaciYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaciYn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaciYn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci1Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci2Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci3Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci4Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci5Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci5Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci6Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci6Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci6Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setMoaci7Yn(EgovStringUtil.isEmpty(qsltVO.getMoaci7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getMoaci7Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getMoaci7Yn()).replace(SysUpdDt,"")).substring(0,1));
//
//				qsltVO.setWkpnYn(EgovStringUtil.isEmpty(qsltVO.getWkpnYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpnYn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpnYn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn1Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn2Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn3Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn4Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn5Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn5Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn6Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn6Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn6Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setWkpn7Yn(EgovStringUtil.isEmpty(qsltVO.getWkpn7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getWkpn7Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getWkpn7Yn()).replace(SysUpdDt,"")).substring(0,1));
//
//				qsltVO.setRepsym1Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getRepsym1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setRepsym2Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getRepsym2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setRepsym3Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getRepsym3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setRepsym4Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getRepsym4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setRepsym5Yn(EgovStringUtil.isEmpty(qsltVO.getRepsym5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getRepsym5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getRepsym5Yn()).replace(SysUpdDt,"")).substring(0,1));
//
//				qsltVO.setCirsym1Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setCirsym2Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setCirsym3Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setCirsym4Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setCirsym5Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym5Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setCirsym6Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym6Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym6Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setCirsym7Yn(EgovStringUtil.isEmpty(qsltVO.getCirsym7Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getCirsym7Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getCirsym7Yn()).replace(SysUpdDt,"")).substring(0,1));
//
//				qsltVO.setInddistYn(EgovStringUtil.isEmpty(qsltVO.getInddistYn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddistYn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddistYn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddist1Yn(EgovStringUtil.isEmpty(qsltVO.getInddist1Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist1Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddist1Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddist2Yn(EgovStringUtil.isEmpty(qsltVO.getInddist2Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist2Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddist2Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddist3Yn(EgovStringUtil.isEmpty(qsltVO.getInddist3Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist3Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddist3Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddist4Yn(EgovStringUtil.isEmpty(qsltVO.getInddist4Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist4Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddist4Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddist5Yn(EgovStringUtil.isEmpty(qsltVO.getInddist5Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist5Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddist5Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddist6Yn(EgovStringUtil.isEmpty(qsltVO.getInddist6Yn()) ? "" : util.decryptAES128(masterKey, qsltVO.getInddist6Yn()) == null ? "" : util.decryptAES128(masterKey, util.decryptAES128(masterKey, qsltVO.getInddist6Yn()).replace(SysUpdDt,"")).substring(0,1));
//				qsltVO.setInddistEtc(qsltVO.getInddistEtc());
//			}
//		}
//
//		return qsltVO;
//	}

}