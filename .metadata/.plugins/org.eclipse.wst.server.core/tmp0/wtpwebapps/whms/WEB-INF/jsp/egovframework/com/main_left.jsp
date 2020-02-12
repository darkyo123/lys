<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
 /**
  * @Class Name : left.jsp
  * @Description :  좌측메뉴화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */

  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/com/sym/mnu/mpm/icon/";
  String imagePath_button = "/images/egovframework/com/sym/mnu/mpm/button/";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%-- <link rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/left.css' />" type="text/css" /> --%>
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/style.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/reset.css' />" type="text/css" />
<link rel="stylesheet" href="<c:url value='/css/egovframework/whms/animate.css' />" type="text/css" />
<title>메뉴정보등록</title>
<script language="javascript1.2" src="<c:url value='/js/egovframework/com/sym/mnu/mpm/EgovMenuList.js' />" /></script>
<script src="<c:url value='/js/egovframework/whms/jquery-1.11.3.min.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/front-ui.js' />" type="text/javascript"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/whms/jquery.navgoco.js' />"></script><!-- left menu js -->
<script type="text/javascript">
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>";
var getContextPath = "${pageContext.request.contextPath}";
var path = location.origin;

/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
	function choiceNodes(nodeNum) {
		var nodeValues = document.menuListForm.tmp_menuNm[nodeNum].value.split("|");
		if(nodeValues[5].indexOf("dir") < 0) {				// directory가 아니면 페이지 이동
			//top.frames[2].document.location=path + nodeValues[5];		// right frame 제어
			//top.location.href=path + "/sym/mnu/mpm/EgovMainMenuIndex.do?menuNo="+nodeValues[0]+"&chkURL="+nodeValues[5];
			document.selectOne.vStartP.value=nodeValues[0];
			document.selectOne.chkURL.value=nodeValues[5];
			/* document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuHead.do'/>";
		    document.selectOne.target = "main_top";
		    document.selectOne.submit();
		    document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuLeft.do'/>";
		    document.selectOne.target = "main_left";
		    document.selectOne.submit(); */
		    $("#lmenu").find("#li"+nodeValues[0]).parent().parent().addClass("open");
			$("#lmenu").find("#li"+nodeValues[0]).parent().show();
			$("#lmenu").find("li").removeClass("active");
			$("#lmenu").find("#li"+nodeValues[0]).addClass("active");
			parent.parent.document.getElementById("main_top").contentWindow.document.getElementById("upper_menu_nm").innerHTML = nodeValues[6];
			parent.parent.document.getElementById("main_top").contentWindow.document.getElementById("menu_nm").innerHTML = nodeValues[2];
	 	    document.selectOne.action = "<c:url value='/sym/mnu/mpm/EgovMainMenuRight.do'/>";
		    document.selectOne.target = "main_right";
		    document.selectOne.submit();
		} else {
			top.location.href=path + "/sym/mnu/mpm/EgovMainMenuIndex.do?menuNo="+nodeValues[0]+"&chkURL=dir";
		}
	}

	$("html").keydown(function(e) {
		var k = window.event.keyCode;
		if(window.event.ctrlKey && k == 85) {
			alert("소스보기가 금지 되어있습니다");
			event.keyCode = 0;
			event.cancleBubble = true;
			event.returnValue = false;
		}
	});

</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight= "0" oncontextmenu="return false" ondragstart="return false" onselectstart="return false">

<form name="selectOne">
<input name="vStartP" type="hidden" />
<input name="chkURL" type="hidden" />
</form>

<form name="menuListForm" action ="<c:url value='/sym/mnu/mpm/EgovMenuListSelect.do' />" method="post">
<input name="currentMenu" type="hidden" value="<c:out value='${param.vStartP}'/>" />
<div style="width:0px; height:0px;">
	<c:forEach var="result" items="${list_menulist}" varStatus="status" >
	<input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|${result.upperMenuNm}"/>
	</c:forEach>
</div>
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
			<!-- <li class="open"> <a href="#">기본 정보</a>
				<ul>
					<li class="active"><a href="#">사용자관리</a></li>
					<li><a href="#">데이터 업로드</a></li>
				</ul>
			</li>
			<li> <a href="#">건강 정보</a>
				<ul>
					<li><a href="#">기본/검진 정보</a></li>
					<li><a href="#">혈압 측정 정보</a></li>
					<li><a href="#">건강 검진 정보</a></li>
					<li><a href="#">교육 이력 정보</a></li>
					<li><a href="#">건강 분석 정보</a></li>
					<li><a href="#">문진표 정보</a></li>
				</ul>
			</li>
			<li> <a href="#">통계 관리</a>
				<ul>
					<li><a href="#">측정항목별</a></li>
					<li><a href="#">관심항목별</a></li>
					<li><a href="#">보고서</a></li>
				</ul>
			</li>
			<li> <a href="#">시스템 관리</a>
				<ul>
					<li><a href="#">관리자 등록</a></li>
					<li><a href="#">화면권한</a></li>
					<li><a href="#">시스템정보</a></li>
				</ul>
			</li> -->
		</div>
	</div>
</div>
</div>
</div>
</form>
<script src="<c:url value='/js/egovframework/whms/needpopup.js' />" type="text/javascript"></script>
<script src="<c:url value='/js/egovframework/whms/default.js' />" type="text/javascript"></script>
</body>
</html>

