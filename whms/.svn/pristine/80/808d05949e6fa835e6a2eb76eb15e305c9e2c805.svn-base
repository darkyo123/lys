package egovframework.whms.notice.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.whms.notice.service.TestService;
import egovframework.whms.notice.service.TestVO;

@Controller
public class TestController {

	@Resource(name = "testService")
	private TestService testService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** 개발중 페이지 */
	@RequestMapping(value="/whms/devPage.do")
	public String devPage( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		/** Left Menu List */
		model.addAttribute("list_menulist", request.getAttribute("menuList"));

		return "egovframework/whms/devPage";
	}

	/** 오류 페이지 */
	@RequestMapping(value="/whms/errorPage.do")
	public String errorPage( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		model.addAttribute("errorMsg", request.getAttribute("errorMsg"));

		return "egovframework/whms/errorPage";
	}

	/** 목록 및 페이징 */
	@RequestMapping(value="/whms/testList.do")
	public String test( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {

		/** Left Menu List */
		model.addAttribute("list_menulist", request.getAttribute("menuList"));

		List<TestVO> testList = testService.selectTestList(testVO);
		model.addAttribute("testList", testList);

		return "egovframework/whms/testList";
	}

	/** 등록 폼 및 등록 로직 */
	@RequestMapping(value="/whms/testRegist.do")
	public String testRegist( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String flag = EgovStringUtil.isNullToString(request.getParameter("flag"));
		if("R".equals(flag)) {		// flag가 R일 경우 저장 로직 적용
			testVO.setFrstRegisterId(user.getId());
			testVO.setLastUpdusrId(user.getId());
			testService.doRegistTest(testVO);
			return "forward:/whms/testList.do";
		}
		return "egovframework/whms/testRegist";
	}

	/** 상세페이지 */
	@RequestMapping(value="/whms/testDetail.do")
	public String testView( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		TestVO detailVO = testService.selectTestDetail(testVO);
		model.addAttribute("detailVO", detailVO);
		return "egovframework/whms/testDetail";
	}
	
	/** 수정 폼 및 수정 로직 */
	@RequestMapping(value="/whms/testUpdate.do")
	public String testUpdate( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String flag = EgovStringUtil.isNullToString(request.getParameter("flag"));
		TestVO detailVO = testService.selectTestDetail(testVO);
		model.addAttribute("detailVO", detailVO);
		if("U".equals(flag)) {		// flag가 R일 경우 저장 로직 적용
			testVO.setLastUpdusrId(user.getId());
			testService.doUpdateTest(testVO);
			return "forward:/whms/testDetail.do";
		}
		return "egovframework/whms/testUpdate";
	}

	/** 삭제 로직 */
	@RequestMapping(value="/whms/testDelete.do")
	public String testDelete( @ModelAttribute("searchVO") TestVO testVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception {
		testService.doDeleteTest(testVO);
		return "forward:/whms/testList.do";
	}
	
	/** 데이터 Load (Ajax) */
	@RequestMapping(value = "/whms/testDataAjax.do")
	public ModelAndView testData(@ModelAttribute("searchVO") TestVO testVO) throws Exception {
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			List<TestVO> testList = testService.selectTestList(testVO);
			modelAndView.addObject("testList", testList);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("testList", null);
		}

		return modelAndView;
	}

	/** 입력 & 수정 (Ajax) */
	@RequestMapping(value = "/whms/testSaveAjax.do")
	public ModelAndView testSaveAjax(@ModelAttribute("searchVO") TestVO testVO) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			testVO.setFrstRegisterId(user.getId());
			testVO.setLastUpdusrId(user.getId());
			if(testVO.getDate() == null || "".equals(testVO.getDate())) {
				testVO.setDate(null);
			} else {
				testVO.setDate(testVO.getDate().replaceAll("-", ""));
			}
			testService.doSaveTest(testVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}

	/** 삭제 (Ajax) */
	@RequestMapping(value = "/whms/testDeleteAjax.do")
	public ModelAndView testDeleteAjax(@ModelAttribute("searchVO") TestVO testVO) throws Exception {

    	ModelAndView modelAndView = new ModelAndView();
    	modelAndView.setViewName("jsonView");

		try {
			testService.doDeleteTest(testVO);
			modelAndView.addObject("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelAndView.addObject("result", false);
		}

		return modelAndView;
	}
}