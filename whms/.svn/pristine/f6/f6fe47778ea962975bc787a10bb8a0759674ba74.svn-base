<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMenuCreatManage.jsp
  * @Description : 메뉴생성관리 조회 화면
  * @Modification Information
  * @
  * @ 수정일               수정자             수정내용
  * @ ----------   --------   ---------------------------
  * @ 2009.03.10   이용               최초 생성
  *   2018.09.10   신용호            표준프레임워크 v3.8 개선
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */

  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mcm/icon/";
  String imagePath_button = "/images/egovframework/com/sym/mnu/mcm/button/";
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<title><spring:message code="comSymMnuMpm.menuCreatManage.title" /></title><!-- 메뉴생성관리 -->
<link href="<c:url value="/css/egovframework/com/com.css"/>" rel="stylesheet" type="text/css">
<link href="<c:url value="/css/egovframework/com/button.css"/>" rel="stylesheet" type="text/css">

<!-- Bootstrap -->
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/jquery-ui.min.css' />" type="text/css" />

<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/jquery-ui.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->

<script  language="javascript1.2" type="text/javaScript">
<!--

/** Left Menu 동작 script */
function choiceNodes(nodeNum) {
	var nodeValues = document.selectOne.tmp_menuNm[nodeNum].value.split("|");
	if(nodeValues[5].indexOf("dir") < 0) {				// directory가 아니면 페이지 이동
		document.selectOne.vStartP.value=nodeValues[0];
		document.selectOne.chkURL.value=nodeValues[5];
		parent.parent.document.getElementById("main_top").contentWindow.document.getElementById("upper_menu_nm").innerHTML = nodeValues[6];
		parent.parent.document.getElementById("main_top").contentWindow.document.getElementById("menu_nm").innerHTML = nodeValues[2];
 	    document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuRight.do'/>";
	    document.selectOne.submit();
	} else {
		top.location.href=path + "/sym/mnu/mpm/EgovMainMenuIndex.do?menuNo="+nodeValues[0]+"&chkURL=dir";
	}
}

/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.menuCreatManageForm.pageIndex.value = pageNo;
	document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
   	document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() {
	document.menuCreatManageForm.pageIndex.value = 1;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 메뉴생성 화면 호출
 ******************************************************** */
function selectMenuCreat(vAuthorCode) {
	document.menuCreatManageForm.authorCode.value = vAuthorCode;
   	document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
   	document.menuCreatManageForm.submit();
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>
</head>
<body>
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript><!-- 자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다. -->
<form name="selectOne">
	<input name="currentMenu" type="hidden" value="<c:out value='${param.vStartP}'/>" />
	<c:forEach var="result" items="${list_menulist}" varStatus="status" >
		<input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|${result.upperMenuNm}"/>
	</c:forEach>
	<input name="vStartP" type="hidden" />
	<input name="chkURL" type="hidden" />
	<input id="modal_type" type="hidden" value="" />
</form>
<div id="subcontainer">
		<div class="swrap">
			<div class="subcont">
				<div class="left_area">
					<div class="lnav" id="lmenu">
						<c:forEach var="menu" items="${list_menulist}" varStatus="status" >
							<c:if test="${menu.childCnt != 0 }">
								<li id="li<c:out value='${menu.menuNo}'/>">
									<a href="javascript:choiceNodes('<c:out value="${menu.rowNumber}"/>')"><c:out value='${menu.menuNm}'/></a>
									<ul>
										<c:forEach var="menu_lv2" items="${list_menulist}" varStatus="status" >
											<c:if test="${menu.menuNo == menu_lv2.upperMenuId }">
												<li id="li<c:out value='${menu_lv2.menuNo}'/>"><a href="javascript:choiceNodes('<c:out value="${menu_lv2.rowNumber}"/>')"><c:out value='${menu_lv2.menuNm}'/></a></li>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:if>
						</c:forEach>
					</div>
				</div>
				<div class="right_area p25">
					<div class="board">
						<h1><spring:message code="comSymMnuMpm.menuCreatManage.pageTop.title" /></h1><!-- 메뉴생성관리 -->
					
						<form name="menuCreatManageForm" action ="<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>" method="post">
						<input name="checkedMenuNoForDel" type="hidden" />
						<input name="authorCode"          type="hidden" />
						<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
					
						<div class="search_box" title="<spring:message code="common.searchCondition.msg" />"><!-- 이 레이아웃은 하단 정보를 대한 검색 정보로 구성되어 있습니다. -->
							<ul>
								<li>
									<label for=""><spring:message code="comSymMnuMpm.menuCreatManage.authCode" /> : </label><!-- 보안설정대상ID -->
									<input class="s_input2 vat" name="searchKeyword" type="text"  value='<c:out value="${searchVO.searchKeyword}"/>'  size="80" maxlength="60" title="검색조건" />
									
									<input class="s_btn" type="submit" value='<spring:message code="button.inquire" />' title='<spring:message code="button.inquire" />' onclick="selectMenuCreatManageList(); return false;" />
								</li>
							</ul>
						</div>
					
						<table class="board_list">
							<caption></caption>
							<colgroup>
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
								<col style="width:20%" />
							</colgroup>
							<thead>
								<tr>
								   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.authCode" /></th><!-- 권한코드 -->
								   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.authName" /></th><!-- 권한명 -->
								   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.authDesc" /></th><!-- 권한 설명 -->
								   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.creationStatus" /></th><!-- 메뉴생성여부 -->
								   <th scope="col"><spring:message code="comSymMnuMpm.menuCreatManage.createMenu" /></th><!-- 메뉴생성 -->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${list_menumanage}" varStatus="status">
								  <tr>
								    <td><c:out value="${result.authorCode}"/></td>
								    <td><c:out value="${result.authorNm}"/></td>
								    <td><c:out value="${result.authorDc}"/></td>
								    <td>
							          <c:if test="${result.chkYeoBu > 0}">Y</c:if>
							          <c:if test="${result.chkYeoBu == 0}">N</c:if>
								    </td>
								    <td>
								       <a class="btn02" href="<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode='<c:out value="${result.authorCode}"/>&vStartP=<c:out value="${param.vStartP}"/>'"  onclick="selectMenuCreat('<c:out value="${result.authorCode}"/>'); return false;">메뉴생성</a>
								    </td>
								  </tr>
								 </c:forEach>
							</tbody>
						</table>
					
						<!-- paging navigation -->
						<div class="pagination">
							<ul>
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage"/>
							</ul>
						</div>
						
						<input type="hidden" name="req_menuNo">
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>

<div class="btn_up_layer"></div>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>

</body>
</html>

